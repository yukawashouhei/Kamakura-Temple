// Mapkit/Models/MapAnnotationItem.swift
// 地図上のアノテーションを統一的に扱うenum
import Foundation
import MapKit

enum MapItem: Identifiable {
    case location(Location)
    case comment(Comment)

    var id: String {
        switch self {
        case .location(let loc):
            return "location-\(loc.id)"
        case .comment(let com):
            return "comment-\(com.id.uuidString)"
        }
    }

    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .location(let loc):
            return loc.coordinates
        case .comment(let com):
            return com.coordinate
        }
    }

    var title: String {
        switch self {
        case .location(let loc):
            return loc.localizedName
        case .comment(let com):
            return com.text
        }
    }

    var subtitle: String? {
        switch self {
        case .location(let loc):
            return loc.localizedDescription
        case .comment(let com):
            return com.userName
        }
    }
} 