//
//  LocationsViewModel.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/05/31.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation
import Combine

@MainActor
class LocationsViewModel: NSObject, ObservableObject {
    
    //All loaded locations
    @Published var locations: [Location]
    
    // Comment service
    @Published var commentService = CommentService()
    
    // Comment related states
    @Published var showAddCommentSheet = false
    @Published var selectedCommentCoordinate: CLLocationCoordinate2D?
    @Published var selectedComment: Comment?
    @Published var showCommentDetailSheet = false
    @Published var showCommentsListSheet = false
    
    // Combined annotation items for map
    @Published var annotationItems: [MapItem] = []
    
    // Combine cancellables
    private var cancellables = Set<AnyCancellable>()
    
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: self.mapLocation)
        }
    }
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    // Show List of location
    @Published var showLocationsList: Bool = false
    
    // show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    // Location manager for user location
    private let locationManager = CLLocationManager()
    
    // User location
    @Published var userLocation: CLLocation?
    @Published var locationAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var isRequestingLocationPermission: Bool = false
    
    override init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        super.init()
        self.updateMapRegion(location: locations.first!)
        
        setupLocationManager()
        
        // Request location permission on app launch after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.requestLocationPermissionOnLaunch()
        }
        
        // Update annotation items when comments change
        updateAnnotationItems()
        
        // CommentServiceの変更を監視
        commentService.objectWillChange.sink { [weak self] in
            self?.updateAnnotationItems()
        }.store(in: &cancellables)
    }
    
    // MARK: - Annotation Management
    
    private func updateAnnotationItems() {
        // LocationとCommentをMapItemに変換してannotationItemsに設定
        var items: [MapItem] = []
        items.append(contentsOf: locations.map { MapItem.location($0) })
        items.append(contentsOf: commentService.comments.map { MapItem.comment($0) })
        annotationItems = items
    }
    
    // Add sample comments for demo
    private func addSampleComments() {
        commentService.addSampleComments()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        
        // Check if location permission is already granted
        locationAuthorizationStatus = locationManager.authorizationStatus
        
        if locationAuthorizationStatus == .authorizedWhenInUse || locationAuthorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocationPermissionOnLaunch() {
        // Only request if permission is not determined
        if locationAuthorizationStatus == .notDetermined {
            isRequestingLocationPermission = true
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerOnUserLocation() {
        guard let userLocation = userLocation else { 
            // If no user location, request permission
            requestLocationPermission()
            return 
        }
        
        withAnimation(.easeInOut) {
            self.mapRegion = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: self.mapSpan
            )
        }
    }
    
    func showRouteToLocation(_ destination: Location) {
        guard let userLocation = userLocation else { 
            // If no user location, request permission first
            requestLocationPermission()
            return 
        }
        
        // Create MKMapItems for source and destination
        let sourceMapItem = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
        let destinationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: destination.coordinates))
        
        // Open in Apple Maps with walking directions
        MKMapItem.openMaps(with: [sourceMapItem, destinationMapItem], 
                          launchOptions: [
                            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
                          ])
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            self.mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: self.mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            self.showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            self.mapLocation = location
            self.showLocationsList = false
        }
    }
    
    // MARK: - Comment Functions
    
    func addCommentAtCurrentLocation() {
        guard let userLocation = userLocation else {
            // If no user location, request permission
            requestLocationPermission()
            return
        }
        
        selectedCommentCoordinate = userLocation.coordinate
        showAddCommentSheet = true
    }
    
    func addCommentAtMapCenter() {
        selectedCommentCoordinate = mapRegion.center
        showAddCommentSheet = true
    }
    
    func showCommentDetail(comment: Comment) {
        selectedComment = comment
        showCommentDetailSheet = true
    }
    
    func deleteComment(_ comment: Comment) {
        commentService.removeComment(comment)
        updateAnnotationItems()
    }
    
    func showCommentsList() {
        showCommentsListSheet = true
    }
    
    func nextButtonPressed() {
        //Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation}) else {
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        
        // Check if the currentIndex is valid
        let nextIndex = currentIndex + 1
        let nextLocation: Location
        
        if locations.indices.contains(nextIndex) {
            // Next index is Valid
            nextLocation = locations[nextIndex]
        } else {
            // Next Index is not valid, restart from 0
            guard let firstLocation = locations.first else {
                print("Locations array is empty! Should never happen.")
                return
            }
            nextLocation = firstLocation
        }
        
        Task { @MainActor in
            withAnimation(.easeInOut) {
                self.mapLocation = nextLocation
                self.showLocationsList = false
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationsViewModel: CLLocationManagerDelegate {
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        Task { @MainActor in
            let isFirstLocation = self.userLocation == nil
            self.userLocation = location
            
            // Center on user location if this is the first location update
            if isFirstLocation && (self.locationAuthorizationStatus == .authorizedWhenInUse || self.locationAuthorizationStatus == .authorizedAlways) {
                self.centerOnUserLocation()
            }
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        Task { @MainActor in
            self.locationAuthorizationStatus = status
            self.isRequestingLocationPermission = false
            
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                self.locationManager.startUpdatingLocation()
                // Center on user location when permission is granted
                if let userLocation = self.userLocation {
                    self.centerOnUserLocation()
                }
            case .denied, .restricted:
                // Handle denied access - user can still use the app without location
                print("Location access denied by user")
            case .notDetermined:
                // Wait for user decision
                break
            @unknown default:
                break
            }
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
