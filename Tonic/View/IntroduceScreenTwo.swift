//
//  IntroduceScreenTwo.swift
//  Tonic
//
//  Created by Student on 11/16/24.
//

import SwiftUI


struct IntroduceScreenTwo: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var tonicViewModel: TonicViewModel
    @State private var navigateToNext = false
    @FocusState var showKeyboard: Bool
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var gender = "Select Gender"
    @State private var birthday = ""
        
    private let genderOptions = ["Male", "Female", "Non-Binary", "Prefer not to say"]

    
    private var user: Person?
    
    init(user: Person? = nil) {
        self.user = user
        if let user = user {
            _firstName = State(initialValue: user.firstName)
            _lastName = State(initialValue: user.lastName)
            _gender = State(initialValue: user.gender)
            _birthday = State(initialValue: user.birthday)
        }
        else {
            _firstName = State(initialValue: "")
            _lastName = State(initialValue: "")
            _gender = State(initialValue: "")
            _birthday = State(initialValue: "")
            
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack() {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 350, height: 10)
                        .foregroundColor(Color(hex: "D9D9D9"))
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 140, height: 10, alignment: .leading)
                        .frame(maxWidth: 350, maxHeight: 50, alignment: .leading)
                        .foregroundColor(Color(hex: "9372FF"))
                }
                .position(x: 195, y:0)
                .frame(height: 70)
                .padding(.top, 20)
                //.background(Color(.black))
                
                Text("Gender")
                    .font(.system(size: 35, weight: .semibold))
                    .frame(maxWidth: 350, alignment: .leading)
                    .frame(height: 20)
                //.background(Color(.black))
                
                Menu {
                    ForEach(genderOptions, id: \.self) { gend in
                        Button(action: {
                            gender = gend
                        }) {
                            Text(gend)
                        }
                    }
                } label: {
                    HStack {
                        Text(gender)
                            .foregroundColor(Color(hex: "FC8F21"))
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: 350)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                    )
                }
                .padding(20)
                
                Text("Birthday")
                    .font(.system(size: 35, weight: .semibold))
                    .frame(maxWidth: 350, alignment: .leading)
                    .frame(height: 20)
                    .padding(.top, 20)
                
                VStack() {
                    TextField("MM/DD/YYYY", text: $birthday)
                        .frame(maxWidth: 350, alignment: .leading)
                        .padding()
                        .foregroundColor(Color(hex: "FC8F21"))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                        )
                }
                .padding(20)
                
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
            HobbiesSelect()
        }
    }
}

struct IntroduceScreenTwo_Previews: PreviewProvider {
    static var previews: some View {
        IntroduceScreenTwo(user: TonicViewModel().currentUser)
    }
}
