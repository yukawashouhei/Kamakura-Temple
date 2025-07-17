//
//  CommentService.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/01/27.
//

import Foundation
import MapKit
import Combine

// MARK: - Error Types

enum CommentError: LocalizedError {
    case saveFailed(Error)
    case deleteFailed(Error)
    case loadFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .saveFailed(let error):
            return "コメントの保存に失敗しました: \(error.localizedDescription)"
        case .deleteFailed(let error):
            return "コメントの削除に失敗しました: \(error.localizedDescription)"
        case .loadFailed(let error):
            return "コメントの読み込みに失敗しました: \(error.localizedDescription)"
        }
    }
}

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
    
    /// 楽観的UI用: 即座にコメントを追加（UI更新）
    func addCommentOptimistically(_ comment: Comment) {
        DispatchQueue.main.async {
            self.comments.append(comment)
            self.objectWillChange.send()
        }
    }
    
    /// 楽観的UI用: 即座にコメントを削除（UI更新）
    func removeCommentOptimistically(_ comment: Comment) {
        DispatchQueue.main.async {
            self.comments.removeAll { $0.id == comment.id }
            self.objectWillChange.send()
        }
    }
    
    /// バックグラウンドでコメントを保存
    func saveCommentToStorage(_ comment: Comment) async throws {
        // 新しいコメントを一時的に追加して保存
        var commentsToSave = comments
        if !commentsToSave.contains(where: { $0.id == comment.id }) {
            commentsToSave.append(comment)
        }
        
        // UserDefaultsに保存
        do {
            let data = try JSONEncoder().encode(commentsToSave)
            await MainActor.run {
                userDefaults.set(data, forKey: commentsKey)
            }
        } catch {
            throw CommentError.saveFailed(error)
        }
    }
    
    /// バックグラウンドでコメントを削除
    func deleteCommentFromStorage(_ comment: Comment) async throws {
        // UserDefaultsに保存
        do {
            let data = try JSONEncoder().encode(comments)
            await MainActor.run {
                userDefaults.set(data, forKey: commentsKey)
            }
        } catch {
            throw CommentError.deleteFailed(error)
        }
    }
    
    /// エラーメッセージを表示
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
            // 3秒後にエラーメッセージを自動で消す
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if self.errorMessage == message {
                    self.errorMessage = nil
                }
            }
        }
    }
    
    /// エラーメッセージをクリア
    func clearError() {
        DispatchQueue.main.async {
            self.errorMessage = nil
        }
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
    
    /// UserDefaultsにコメントを非同期で保存
    private func saveCommentsAsync() async {
        do {
            let data = try JSONEncoder().encode(comments)
            await MainActor.run {
                userDefaults.set(data, forKey: commentsKey)
            }
        } catch {
            print("Error saving comments asynchronously: \(error)")
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
                addCommentOptimistically(comment)
            }
        }
    }

} 