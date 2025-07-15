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
        VStack(spacing: 0) {
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
            // コメントテキスト
            Text(comment.text)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            // タイムスタンプ
            Text(comment.shortTimestamp)
                .font(.system(size: 10))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.8))
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        )
        .overlay(
            // 吹き出しの矢印
            Triangle()
                .fill(Color.black.opacity(0.8))
                .frame(width: 12, height: 8)
                .rotationEffect(.degrees(180))
                .offset(y: 8)
        )
        .frame(maxWidth: 150)
    }
    
    private var commentMarker: some View {
        ZStack {
            // 外側の円
            Circle()
                .fill(Color.blue)
                .frame(width: 32, height: 32)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
            
            // 笑顔アイコン
            Image(systemName: "face.smiling")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

// 三角形のシェイプ（吹き出しの矢印用）
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
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