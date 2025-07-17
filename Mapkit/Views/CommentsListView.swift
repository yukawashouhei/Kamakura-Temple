//
//  CommentsListView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/01/27.
//

import SwiftUI
import MapKit

struct CommentsListView: View {
    @ObservedObject var commentService: CommentService
    @Environment(\.dismiss) private var dismiss
    
    @State private var showDeleteAlert = false
    @State private var commentToDelete: Comment?
    
    var body: some View {
        NavigationView {
            VStack {
                if commentService.isLoading {
                    loadingView
                } else if commentService.comments.isEmpty {
                    emptyStateView
                } else {
                    commentsList
                }
            }
            .navigationTitle("コメント一覧")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("閉じる") {
                        dismiss()
                    }
                }
                

            }
        }
        .alert("コメントを削除", isPresented: $showDeleteAlert) {
            Button("削除", role: .destructive) {
                if let comment = commentToDelete {
                    deleteCommentOptimistically(comment)
                }
            }
            Button("キャンセル", role: .cancel) { }
        } message: {
            Text("このコメントを削除しますか？この操作は取り消せません。")
        }
        .alert("エラー", isPresented: .constant(commentService.errorMessage != nil)) {
            Button("OK") {
                commentService.errorMessage = nil
            }
        } message: {
            if let errorMessage = commentService.errorMessage {
                Text(errorMessage)
            }
        }
    }
    
    private func deleteCommentOptimistically(_ comment: Comment) {
        // 楽観的UI: 即座にコメントを削除してUIを更新
        commentService.removeCommentOptimistically(comment)
        
        // バックグラウンドで削除処理を実行（エラーハンドリング付き）
        Task {
            do {
                try await commentService.deleteCommentFromStorage(comment)
                // 削除成功 - 何もしない（既にUIから削除済み）
            } catch {
                // 削除失敗時はコメントを再表示
                await MainActor.run {
                    commentService.addCommentOptimistically(comment)
                    commentService.showError("コメントの削除に失敗しました: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            
            Text("読み込み中...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("まだコメントがありません")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Text("地図上で「+」ボタンを押して、最初のコメントを投稿してみましょう！")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    private var commentsList: some View {
        List {
            ForEach(commentService.comments.sorted(by: { $0.timestamp > $1.timestamp })) { comment in
                CommentRowView(comment: comment) {
                    commentToDelete = comment
                    showDeleteAlert = true
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct CommentRowView: View {
    let comment: Comment
    let onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.title3)
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(comment.userName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(comment.timestamp, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            
            Text(comment.text)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(3)
            
            HStack {
                Image(systemName: "location.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                
                Text("緯度: \(String(format: "%.4f", comment.coordinate.latitude)), 経度: \(String(format: "%.4f", comment.coordinate.longitude))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CommentsListView(commentService: CommentService())
} 