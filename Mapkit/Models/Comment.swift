//
//  Comment.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/01/27.
//

import Foundation
import MapKit

struct Comment: Identifiable, Codable, Equatable {
    let id: UUID
    let text: String
    let coordinate: CLLocationCoordinate2D
    let timestamp: Date
    let userId: String
    let userName: String
    
    init(text: String, coordinate: CLLocationCoordinate2D, userId: String = "user", userName: String = "ユーザー") {
        self.id = UUID()
        self.text = text
        self.coordinate = coordinate
        self.timestamp = Date()
        self.userId = userId
        self.userName = userName
    }
    
    init(id: UUID, text: String, coordinate: CLLocationCoordinate2D, timestamp: Date, userId: String, userName: String) {
        self.id = id
        self.text = text
        self.coordinate = coordinate
        self.timestamp = timestamp
        self.userId = userId
        self.userName = userName
    }
    
    // CLLocationCoordinate2DのCodable対応
    enum CodingKeys: String, CodingKey {
        case id, text, latitude, longitude, timestamp, userId, userName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        timestamp = try container.decode(Date.self, forKey: .timestamp)
        userId = try container.decode(String.self, forKey: .userId)
        userName = try container.decode(String.self, forKey: .userName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(userId, forKey: .userId)
        try container.encode(userName, forKey: .userName)
    }
    
    // Equatable
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        lhs.id == rhs.id
    }
    
    // フォーマットされた日時文字列
    var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日(E) HH:mm"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: timestamp)
    }
    
    // 短い日時文字列
    var shortTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: timestamp)
    }
} 