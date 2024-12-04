//
//  MessageBubbleView.swift
//  Tonic
//
//  Created by Student on 12/4/24.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Custom Message Bubble View
struct MessageBubbleView: View {
    let message: MessageModel
    
//    var alignment: HorizontalAlignment = {
//        if message.isCurrentUser {
//            return .trailing
//        } else {
//            return .leading
//        }
//
//    }()
    
    var body: some View {
        VStack (alignment: .trailing) {
            HStack {
                if message.isCurrentUser {
                    Spacer()
                    messageContent
                        .background(Color(hex: "FC8F21"))
                        .cornerRadius(0, corners: [.bottomRight])
                        .cornerRadius(24, corners: [.topLeft, .topRight, .bottomLeft])
                    
                } else {
                    messageContent
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    Spacer()
                }
            
            }
            if message.isCurrentUser {
                Text(formatTimestamp(message.timestamp))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
                    .padding(.bottom, 4)
            } else {
                Text(formatTimestamp(message.timestamp))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 4)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
    
    private var messageContent: some View {
        VStack(alignment: message.isCurrentUser ? .trailing : .leading) {
            Text(message.text)
                .padding(12)
                .foregroundColor(.white)
            
            
        }
    }
    
    private func formatTimestamp(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}


struct MessageBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubbleView(message: MessageModel(text: "Hello my name is Esther", sender: "CurrentUser", timestamp:Date(), isCurrentUser: false))
    }
}
