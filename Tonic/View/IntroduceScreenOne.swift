//
//  IntroduceScreenOne.swift
//  Tonic
//
//  Created by Student on 11/16/24.
//

import SwiftUI


struct IntroduceScreenOne: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState var showKeyboard: Bool
    @EnvironmentObject var tonicViewModel: TonicViewModel
    @State private var navigateToNext = false
    @State private var firstName = ""
    @State private var lastName = ""
    
    private var user: Person?
    
    init(user: Person? = nil) {
        self.user = user
        if let user = user {
            _firstName = State(initialValue: user.firstName)
            _lastName = State(initialValue: user.lastName)
        }
        else {
            _firstName = State(initialValue: "")
            _lastName = State(initialValue: "")
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                // Progress Bar
                ZStack() {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 350, height: 10)
                        .foregroundColor(Color(hex: "D9D9D9"))
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 70, height: 10, alignment: .leading)
                        .frame(maxWidth: 350, maxHeight: 10, alignment: .leading)
                        .foregroundColor(Color(hex: "9372FF"))
                }
                .position(x: 195, y:0)
                .frame(height: 70)
                .padding(.top, 30)
                //.background(Color(.black))
                
                // Heading
                Text("Introduce Yourself!")
                    .font(.system(size: 35, weight: .semibold))
                    .frame(maxWidth: 350, alignment: .leading)
                    .frame(height: 20)
                //.background(Color(.black))
                
                
                Text("We want to get to know you!")
                    .frame(maxWidth: 350, alignment: .leading)
                    .frame(height: 50)
                //.background(Color(.black))
                
                // First name entry
                VStack() {
                    Text("First Name")
                        .frame(maxWidth: 350, alignment: .leading)
                        .foregroundColor(Color(hex: "FC8F21"))
                    TextField(" ", text: $firstName)
                        .frame(maxWidth: 350, alignment: .leading)
                        .padding(10)
                        .focused($showKeyboard)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                        )
                    
                    
                }
                .padding(10)
                
                // Last name entry
                VStack() {
                    Text("Last Name")
                        .frame(maxWidth: 350, alignment: .leading)
                        .foregroundColor(Color(hex: "FC8F21"))
                    TextField(" ", text: $lastName)
                        .frame(maxWidth: 350, alignment: .leading)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                        )
                    
                }
                .padding(10)
                
                // Next Button
                Button {
                    navigateToNext = true
                } label: {
                    HStack {
                        Spacer()
                        Image("NextButton")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(30)
                    }
                }
                Spacer()
            }
            .backgroundStyle(Color(hex: "FFF8F0"))
            .task {
                try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 second delay
                showKeyboard = true
            }
        }
        .navigationDestination(isPresented: $navigateToNext) {
            IntroduceScreenTwo()
        }
    }
}

struct IntroduceScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        IntroduceScreenOne(user: TonicViewModel().currentUser)
    }
}
