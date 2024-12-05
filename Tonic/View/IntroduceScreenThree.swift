//
//  IntroduceScreenThree.swift
//  Tonic
//
//  Created by Student on 11/16/24.
//

import SwiftUI


struct IntroduceScreenThree: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState var showKeyboard: Bool
    @EnvironmentObject var tonicViewModel: TonicViewModel
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var gender = "Select Gender"
    @State private var birthday = ""
    @State private var username = ""
    @State private var bio = ""
    
    
    private var user: Person?
    
    init(user: Person? = nil) {
        self.user = user
        if let user = user {
            _firstName = State(initialValue: user.firstName)
            _lastName = State(initialValue: user.lastName)
            _gender = State(initialValue: user.gender)
            _birthday = State(initialValue: user.birthday)
            _username = State(initialValue: user.username)
            _bio = State(initialValue: user.bio)
        }
        else {
            _firstName = State(initialValue: "")
            _lastName = State(initialValue: "")
            _gender = State(initialValue: "")
            _birthday = State(initialValue: "")
            _username = State(initialValue: "")
            _bio = State(initialValue: "")
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack() {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 350, height: 10)
                    .foregroundColor(Color(hex: "D9D9D9"))
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 280, height: 10, alignment: .leading)
                    .frame(maxWidth: 350, maxHeight: 10, alignment: .leading)
                    .foregroundColor(Color(hex: "9372FF"))
            }
            .position(x: 195, y:0)
            .frame(height: 70)
            .padding(.top, 30)
            //.background(Color(.black))
            
            Text("Finish Your Profile!")
                .font(.system(size: 35, weight: .semibold))
                .frame(maxWidth: 350, alignment: .leading)
                .frame(height: 20)
            //.background(Color(.black))
            
            
            Text("How do you want others to discover you?")
                .frame(maxWidth: 350, alignment: .leading)
                .frame(height: 50)
            //.background(Color(.black))
            
            VStack() {
                Text("Username")
                    .frame(maxWidth: 350, alignment: .leading)
                    .foregroundColor(Color(hex: "FC8F21"))
                TextField(" ", text: $username)
                    .frame(maxWidth: 350, alignment: .leading)
                    .padding()
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
            .padding(20)
            
            VStack() {
                Text("Bio")
                    .frame(maxWidth: 350, alignment: .leading)
                    .foregroundColor(Color(hex: "FC8F21"))
                TextField(" ", text: $bio)
                    .frame(maxWidth: 350, minHeight: 20, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                    )
                
            }
            .padding(.horizontal, 20)
            
            NavigationLink(destination:         MapDiscovery(user: Person(id:1, firstName: "Esther", lastName: "Kim", gender: "female", birthday: "07/27/2005", bio: "Hi, I'm Esther, Nice to meet you! I'm a sophomore at USC studying at IYA and I'd love to find new friends that have similar interests and hobbies.", username: "esther5727", location: [34.040000, -118.292230], interests: ["anime", "camping", "karaoke", "k-drama", "k-pop"], friends: ["renaewang", "philipkeem"]))
                .environmentObject(TonicViewModel.shared)) {
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
}

struct IntroduceScreenThree_Previews: PreviewProvider {
    static var previews: some View {
        IntroduceScreenThree(user: TonicViewModel().currentUser)
    }
}

