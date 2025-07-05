//
//  location.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/05/30.
//

import Foundation
import MapKit

enum LocationCategory: String, CaseIterable {
    case temple = "寺"
    case shrine = "神社"
    case buddha = "大仏"
    
    var pinImageName: String {
        switch self {
        case .temple:
            return "temple-pin"
        case .shrine:
            return "shrine-pin"
        case .buddha:
            return "buddha-pin"
        }
    }
}

struct Location: Identifiable, Equatable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    let category: LocationCategory
    
    var id: String {
        name + cityName
    }
    
    // Equitable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
