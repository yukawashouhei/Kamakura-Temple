//
//  LocationPreviewView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/06/09.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        HStack (alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                learnMoreButton
                NextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(20)
    }
}

#Preview {
    ZStack {
        Color.green.ignoresSafeArea()
        
        LocationPreviewView(location:  LocationsDataService.locations.first!)
            .padding()
    }
    .environmentObject(LocationsViewModel())
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.localizedName)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(location.localizedCityName)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private var learnMoreButton: some View {
        Button {
            DispatchQueue.main.async {
                vm.sheetLocation = location
            }
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 120, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var NextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 120, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
