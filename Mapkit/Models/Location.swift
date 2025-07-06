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

// 多言語対応のための構造体
struct LocalizedString {
    let japanese: String
    let english: String
    
    func localized(for language: String) -> String {
        return language == "en" ? english : japanese
    }
}

struct LocalizedLinks {
    let japanese: String
    let english: String
    
    func localized(for language: String) -> String {
        return language == "en" ? english : japanese
    }
}

struct Location: Identifiable, Equatable {
    let name: LocalizedString
    let cityName: LocalizedString
    let coordinates: CLLocationCoordinate2D
    let description: LocalizedString
    let imageNames: [String]
    let link: LocalizedLinks
    let category: LocationCategory
    
    var id: String {
        name.japanese + cityName.japanese
    }
    
    // 現在の言語設定に基づいてローカライズされた値を取得
    var localizedName: String {
        let language = Bundle.main.preferredLocalizations.first ?? "ja"
        return name.localized(for: language)
    }
    
    var localizedCityName: String {
        let language = Bundle.main.preferredLocalizations.first ?? "ja"
        return cityName.localized(for: language)
    }
    
    var localizedDescription: String {
        let language = Bundle.main.preferredLocalizations.first ?? "ja"
        return description.localized(for: language)
    }
    
    var localizedLink: String {
        let language = Bundle.main.preferredLocalizations.first ?? "ja"
        return link.localized(for: language)
    }
    
    // Equitable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
