//
//  CommentAnnotationView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/01/27.
//

import SwiftUI
import MapKit

struct CommentAnnotationView: View {
    let comment: Comment
    @State private var showBubble = false
    
    var body: some View {
        VStack(spacing: 5) {
            // コメントの吹き出し
            if showBubble {
                commentBubble
                    .transition(.scale.combined(with: .opacity))
            }
            
            // コメントマーカー
            commentMarker
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showBubble.toggle()
                    }
                }
        }
    }
    
    private var commentBubble: some View {
        VStack(alignment: .leading, spacing: 4) {
            // コメントテキスト（最初の15文字）
            Text(comment.text.prefix(15) + (comment.text.count > 15 ? "..." : ""))
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            // タイムスタンプ
            Text(comment.shortTimestamp)
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.black.opacity(0.8))
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        )
        .frame(maxWidth: 180)
    }
    
    private var commentMarker: some View {
        ZStack {
            // 外側の円
            Circle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            
            // 笑顔アイコン
            Image(systemName: "face.smiling")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    VStack {
        CommentAnnotationView(comment: Comment(
            text: "今日は良い天気ですね！",
            coordinate: CLLocationCoordinate2D(latitude: 35.3195, longitude: 139.5469)
        ))
        
        CommentAnnotationView(comment: Comment(
            text: "鎌倉大仏、迫力あります。ぜひ見に来てください！",
            coordinate: CLLocationCoordinate2D(latitude: 35.3163, longitude: 139.5362)
        ))
    }
    .padding()
} 
