//
//  CommentDetailView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/01/27.
//

import SwiftUI
import MapKit

struct CommentDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var commentService: CommentService
    let comment: Comment
    let onDelete: () -> Void
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // コメント内容
                commentContent
                
                // 位置情報
                locationInfo
                
                // 地図表示
                mapView
                
                Spacer()
            }
            .padding()
            .navigationTitle("コメント詳細")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("削除") {
                        showDeleteAlert = true
                    }
                    .foregroundColor(.red)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("閉じる") {
                        dismiss()
                    }
                }
            }
        }
        .alert("コメントを削除", isPresented: $showDeleteAlert) {
            Button("削除", role: .destructive) {
                deleteCommentOptimistically()
            }
            Button("キャンセル", role: .cancel) { }
        } message: {
            Text("このコメントを削除しますか？この操作は取り消せません。")
        }
    }
    
    private var commentContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(comment.userName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(comment.timestamp, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            Text(comment.text)
                .font(.body)
                .foregroundColor(.primary)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
        }
    }
    
    private var locationInfo: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundColor(.red)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("投稿場所")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("緯度: \(String(format: "%.6f", comment.coordinate.latitude))")
                    .font(.caption)
                    .foregroundColor(.primary)
                
                Text("経度: \(String(format: "%.6f", comment.coordinate.longitude))")
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private var mapView: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: comment.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )), annotationItems: [comment]) { comment in
            MapAnnotation(coordinate: comment.coordinate) {
                Image(systemName: "bubble.left.fill")
                    .font(.title2)
                    .foregroundColor(.orange)
                    .background(
                        Circle()
                            .fill(.white)
                            .frame(width: 30, height: 30)
                    )
            }
        }
        .frame(height: 200)
        .cornerRadius(12)
    }
    
    private func deleteCommentOptimistically() {
        // 楽観的UI: 即座にコメントを削除してUIを更新
        commentService.removeCommentOptimistically(comment)
        
        // 即座に画面を閉じる
        dismiss()
        onDelete()
        
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
}

#Preview {
    CommentDetailView(
        commentService: CommentService(),
        comment: Comment(
            text: "素晴らしい景色でした！",
            coordinate: CLLocationCoordinate2D(latitude: 35.3195, longitude: 139.5469)
        )
    ) {
        print("Delete comment")
    }
} 