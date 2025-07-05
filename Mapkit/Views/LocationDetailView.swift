//
//  LocationDetailView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/06/14.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView  {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    actionButtons
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}


extension LocationDetailView {
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self)  {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil :UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            Text(location.cityName)
                .font(.title2)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 16) {
            // Learn more button (Wikipedia link)
            if let url = URL(string: location.link) {
                Link(destination: url) {
                    HStack {
                        Image(systemName: "book.fill")
                        Text("Learn more")
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                }
                .buttonStyle(.borderedProminent)
            }
            
            // Go here button
            Button(action: {
                vm.showRouteToLocation(location)
                vm.sheetLocation = nil
            }) {
                HStack {
                    Image(systemName: goHereButtonIconName)
                    Text(goHereButtonText)
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.locationAuthorizationStatus != .authorizedWhenInUse && vm.locationAuthorizationStatus != .authorizedAlways)
            .opacity(goHereButtonOpacity)
        }
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius:10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
    
    private var goHereButtonIconName: String {
        if vm.isRequestingLocationPermission {
            return "location.circle"
        } else if vm.locationAuthorizationStatus == .authorizedWhenInUse || vm.locationAuthorizationStatus == .authorizedAlways {
            return "location.fill"
        } else {
            return "location.slash.fill"
        }
    }
    
    private var goHereButtonText: String {
        if vm.isRequestingLocationPermission {
            return "Requesting..."
        } else if vm.locationAuthorizationStatus == .authorizedWhenInUse || vm.locationAuthorizationStatus == .authorizedAlways {
            return "Go here"
        } else {
            return "Enable location"
        }
    }
    
    private var goHereButtonOpacity: Double {
        if vm.isRequestingLocationPermission {
            return 0.8
        } else if vm.locationAuthorizationStatus == .authorizedWhenInUse || vm.locationAuthorizationStatus == .authorizedAlways {
            return 1.0
        } else {
            return 0.7
        }
    }
}
