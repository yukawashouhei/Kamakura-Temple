//
//  LocationMapAnnotationView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/06/14.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "building.columns.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
                .padding(8)
                .background(
                    LinearGradient(
                        colors: [Color.orange, Color.red],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.orange)
                .frame(width: 12, height: 12)
                .rotationEffect(Angle(degrees:180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        LocationMapAnnotationView()
    }
}
