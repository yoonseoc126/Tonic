//
//  Messaging.swift
//  Tonic
//
//  Created by Student on 12/2/24.
//

import SwiftUI

// Message model to represent individual messages
// reorganize into Model foler later
struct MessageModel: Identifiable {
    let id = UUID()
    let text: String
    let sender: String
    let timestamp: Date
    let isCurrentUser: Bool
}

// MessagingView that mimics iMessage interface
struct MessagingView: View {
    @State private var messages: [MessageModel] = []
    @State private var newMessageText: String = ""
    
    var body: some View {
        VStack {
            // Message List
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(spacing: 10) {
                        ForEach(messages) { message in
                            MessageBubbleView(message: message)
                                .id(message.id)
                        }
                    }
                    .onChange(of: messages.count) { _ in
                        // Automatically scroll to bottom when new message arrives
                        proxy.scrollTo(messages.last?.id)
                    }
                }
            }
            .background(Color(hex: "FFF8F0"))
            
            // Message Input Area
            HStack {
                // Plus
                Button(action: {
                    //Doesn't Do anything
                }) {
                    Image("plus")
                        .padding(1)
                }
                
                // Text Input
                TextField("Message", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(4)
                
                // Send Button
                Button(action: sendMessage) {
                    Image("paper-airplane")
                        .resizable()
                        .frame(width: 30, height: 30)
                        
                }
                .disabled(newMessageText.isEmpty)
            }
            .padding()
        }
    }
    
    // Send message functionality
    private func sendMessage() {
        guard !newMessageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        let newMessage = MessageModel(
            text: newMessageText,
            sender: "CurrentUser",
            timestamp: Date(),
            isCurrentUser: true
        )
        
        messages.append(newMessage)
        
        // Simulate incoming message (for demo purposes)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let responseMessage = MessageModel(
                text: "Thanks for your message!",
                sender: "Contact",
                timestamp: Date(),
                isCurrentUser: false
            )
            messages.append(responseMessage)
        }
        
        newMessageText = ""
    }
}



// Preview for SwiftUI Canvas
struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView()
    }
}
