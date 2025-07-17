//
//  TextInputView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/01/27.
//

import SwiftUI

struct TextInputView: View {
    @Binding var commentText: String
    @FocusState private var isTextFieldFocused: Bool
    
    private let maxCharacterCount = 140
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("コメント")
                .font(.headline)
            
            TextEditor(text: $commentText)
                .frame(minHeight: 120)
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .focused($isTextFieldFocused)
                .onChange(of: commentText) { newValue in
                    if newValue.count > maxCharacterCount {
                        commentText = String(newValue.prefix(maxCharacterCount))
                    }
                }
        }
    }
    
    func focus() {
        isTextFieldFocused = true
    }
}

#Preview {
    @Previewable @State var text = ""
    return TextInputView(commentText: $text)
        .padding()
} 