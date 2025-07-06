//
//  LocationsView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/05/31.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationsPreviewStack
            }
            
            // Current location button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    currentLocationButton
                        .padding(.trailing, 20)
                        .padding(.bottom, 200)
                }
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in 
            LocationDetailView(location: location)
        }
        .onAppear {
            // Request location permission on first app launch
            if vm.locationAuthorizationStatus == .notDetermined {
                vm.requestLocationPermission()
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.localizedName + "," + vm.mapLocation.localizedCityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees:
                                                    vm.showLocationsList ? 180 : 0))
                    }
            }
            
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            showsUserLocation: vm.locationAuthorizationStatus == .authorizedWhenInUse || vm.locationAuthorizationStatus == .authorizedAlways,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView(location: location)
                    .scaleEffect(vm.mapLocation == location ? 1
                                 : 0.7)
                    .shadow(radius:10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var currentLocationButton: some View {
        Button(action: vm.centerOnUserLocation) {
            Image(systemName: buttonIconName)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(buttonColor)
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                )
        }
        .disabled(vm.locationAuthorizationStatus != .authorizedWhenInUse && vm.locationAuthorizationStatus != .authorizedAlways)
        .opacity(buttonOpacity)
    }
    
    private var buttonIconName: String {
        if vm.isRequestingLocationPermission {
            return "location.circle"
        } else if vm.locationAuthorizationStatus == .authorizedWhenInUse || vm.locationAuthorizationStatus == .authorizedAlways {
            return "location.fill"
        } else {
            return "location.slash.fill"
        }
    }
    
    private var buttonColor: Color {
        if vm.isRequestingLocationPermission {
            return .orange
        } else if vm.locationAuthorizationStatus == .authorizedWhenInUse || vm.locationAuthorizationStatus == .authorizedAlways {
            return .blue
        } else {
            return .gray
        }
    }
    
    private var buttonOpacity: Double {
        if vm.isRequestingLocationPermission {
            return 0.8
        } else if vm.locationAuthorizationStatus == .authorizedWhenInUse || vm.locationAuthorizationStatus == .authorizedAlways {
            return 1.0
        } else {
            return 0.7
        }
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                    
                        .shadow(color: .black.opacity(0.05), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
            
        }
    }
}
