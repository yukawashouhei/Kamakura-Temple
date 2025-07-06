//
//  LocationMapAnnotationView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/06/14.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let location: Location
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 0) {
            Image(location.category.pinImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            
            // Remove the triangle since we're using custom pin images
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        LocationMapAnnotationView(location: LocationsDataService.locations.first!)
    }
}
