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
        print("DEBUG: LocalizedString.localized called with language: \(language)")
        let result = language == "en" ? english : japanese
        print("DEBUG: Returning: \(result)")
        return result
    }
}

struct LocalizedLinks {
    let japanese: String
    let english: String
    
    func localized(for language: String) -> String {
        print("DEBUG: LocalizedLinks.localized called with language: \(language)")
        let result = language == "en" ? english : japanese
        print("DEBUG: Returning: \(result)")
        return result
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
        // より確実な言語判定方法を使用
        let language = NSLocale.preferredLanguages.first?.prefix(2).description ?? "ja"
        print("DEBUG: NSLocale.preferredLanguages: \(NSLocale.preferredLanguages)")
        print("DEBUG: Detected language: \(language)")
        let result = name.localized(for: language)
        print("DEBUG: Final result for name: \(result)")
        return result
    }
    
    var localizedCityName: String {
        let language = NSLocale.preferredLanguages.first?.prefix(2).description ?? "ja"
        return cityName.localized(for: language)
    }
    
    var localizedDescription: String {
        let language = NSLocale.preferredLanguages.first?.prefix(2).description ?? "ja"
        return description.localized(for: language)
    }
    
    var localizedLink: String {
        let language = NSLocale.preferredLanguages.first?.prefix(2).description ?? "ja"
        return link.localized(for: language)
    }
    
    // Equitable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
