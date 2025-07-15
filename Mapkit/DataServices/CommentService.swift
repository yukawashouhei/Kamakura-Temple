//
//  CommentService.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/01/27.
//

import Foundation
import MapKit
import Combine

class CommentService: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let userDefaults = UserDefaults.standard
    private let commentsKey = "saved_comments"
    
    init() {
        loadComments()
    }
    
    // MARK: - Public Methods
    
    /// 新しいコメントを追加
    func addComment(_ comment: Comment) {
        comments.append(comment)
        saveComments()
        objectWillChange.send()
    }
    
    /// コメントを削除
    func removeComment(_ comment: Comment) {
        comments.removeAll { $0.id == comment.id }
        saveComments()
        objectWillChange.send()
    }
    
    /// 指定された座標の近くのコメントを取得
    func getCommentsNear(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance = 1000) -> [Comment] {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        return comments.filter { comment in
            let commentLocation = CLLocation(latitude: comment.coordinate.latitude, longitude: comment.coordinate.longitude)
            return location.distance(from: commentLocation) <= radius
        }
    }
    
    /// 最新のコメントを取得（指定された数まで）
    func getRecentComments(limit: Int = 50) -> [Comment] {
        return Array(comments.sorted { $0.timestamp > $1.timestamp }.prefix(limit))
    }
    
    /// コメントの総数を取得
    var totalCommentCount: Int {
        return comments.count
    }
    
    // MARK: - Private Methods
    
    /// コメントをUserDefaultsに保存
    private func saveComments() {
        do {
            let data = try JSONEncoder().encode(comments)
            userDefaults.set(data, forKey: commentsKey)
        } catch {
            print("Error saving comments: \(error)")
        }
    }
    
    /// UserDefaultsからコメントを読み込み
    private func loadComments() {
        guard let data = userDefaults.data(forKey: commentsKey) else { return }
        
        do {
            comments = try JSONDecoder().decode([Comment].self, from: data)
        } catch {
            print("Error loading comments: \(error)")
            comments = []
        }
    }
    
    /// サンプルコメントを追加（デモ用）
    func addSampleComments() {
        let sampleComments = [
            Comment(text: "今日は良い天気ですね！", coordinate: CLLocationCoordinate2D(latitude: 35.3195, longitude: 139.5469)),
            Comment(text: "鎌倉大仏、迫力あります", coordinate: CLLocationCoordinate2D(latitude: 35.3163, longitude: 139.5362)),
            Comment(text: "鶴岡八幡宮、静かで良い場所です", coordinate: CLLocationCoordinate2D(latitude: 35.3258, longitude: 139.5577)),
            Comment(text: "江ノ電に乗ってきました", coordinate: CLLocationCoordinate2D(latitude: 35.3089, longitude: 139.5458))
        ]
        
        for comment in sampleComments {
            if !comments.contains(where: { $0.coordinate.latitude == comment.coordinate.latitude && $0.coordinate.longitude == comment.coordinate.longitude }) {
                addComment(comment)
            }
        }
    }
    

} 