//
//  AddCommentView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/01/27.
//

import SwiftUI
import MapKit

struct AddCommentView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var commentService: CommentService
    let coordinate: CLLocationCoordinate2D
    
    @State private var commentText = ""
    
    private let maxCharacterCount = 140
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // ヘッダー情報
                headerInfo
                
                // テキスト入力エリア（分離されたコンポーネント）
                TextInputView(commentText: $commentText)
                
                // 文字数カウンター
                characterCounter
                
                Spacer()
                
                // 投稿ボタン
                submitButton
            }
            .padding()
            .navigationTitle("コメントを投稿")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            // TextInputViewにフォーカスを設定
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // フォーカスはTextInputView内で自動的に設定される
            }
        }
    }
    
    private var headerInfo: some View {
        VStack(spacing: 8) {
            // 位置情報
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.blue)
                Text("投稿位置")
                    .font(.headline)
                Spacer()
            }
            
            // 座標表示
            HStack {
                Text("緯度: \(String(format: "%.4f", coordinate.latitude))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("経度: \(String(format: "%.4f", coordinate.longitude))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private var characterCounter: some View {
        HStack {
            Spacer()
            Text("\(commentText.count)/\(maxCharacterCount)")
                .font(.caption)
                .foregroundColor(commentText.count > maxCharacterCount * 8 / 10 ? .orange : .secondary)
        }
    }
    
    private var submitButton: some View {
        Button(action: submitComment) {
            HStack {
                Image(systemName: "paperplane.fill")
                Text("投稿する")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(canSubmit ? Color.blue : Color.gray)
            )
        }
        .disabled(!canSubmit)
    }
    
    private var canSubmit: Bool {
        !commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func submitComment() {
        guard canSubmit else { return }
        
        let trimmedText = commentText.trimmingCharacters(in: .whitespacesAndNewlines)
        let newComment = Comment(
            text: trimmedText,
            coordinate: coordinate
        )
        
        // 楽観的UI: 即座にコメントを追加してUIを更新
        commentService.addCommentOptimistically(newComment)
        
        // 即座に画面を閉じる（ユーザーは待たない）
        dismiss()
        
        // バックグラウンドで保存処理を実行（エラーハンドリング付き）
        Task {
            do {
                try await commentService.saveCommentToStorage(newComment)
                // 保存成功 - 何もしない（既にUIに表示済み）
            } catch {
                // 保存失敗時はエラーを表示
                await MainActor.run {
                    commentService.showError("コメントの保存に失敗しました: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    AddCommentView(
        commentService: CommentService(),
        coordinate: CLLocationCoordinate2D(latitude: 35.3195, longitude: 139.5469)
    )
} 