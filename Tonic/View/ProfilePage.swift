//
//  ProfilePage.swift
//  Tonic
//
//  Created by Student on 11/28/24.
//

import SwiftUI

struct ProfilePage: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var tonicViewModel: TonicViewModel
    @FocusState var showKeyboard: Bool
    let firstName: String
    let lastName: String
    let gender: String
    let birthday: String
    let bio: String
    let username: String
    let location: [Double]
    let interests: [String]
    let friends: [String]
    
    // need to implement mutual calculation
    let mutualsNum = 1
    let mutuals = ["esther5727", "esther5727", "esther5727", "esther5727", "esther5727"]
    
    // need to implement mutual interest calculation
    let mutualInterests = ["anime"]

    @State private var navigateToMessage = false
    @State private var buttonClick = 0
    
    private var user: Person
    let isCurrentUser: Bool
    
    init(user: Person, isCurrentUser: Bool) {
        self.user = user
        self.isCurrentUser = isCurrentUser
        firstName = user.firstName
        lastName = user.lastName
        gender = user.gender
        birthday = user.birthday
        bio = user.bio
        username = user.username
        location = user.location
        interests = user.interests
        friends = user.friends
    }
    
    var interestsPadding: Int {
        get {
            if isCurrentUser {
                return 30
            } else {
                return 0
            }
        }
    }
    
    
    var body: some View {
        NavigationStack () {
            ZStack {
                // Bg Color
                Color(hex: "FFF8F0").ignoresSafeArea()
                
                // Content
                ScrollView {
                    VStack {
                        // Name+username
                        VStack (alignment: .leading) {
                            Text("\(firstName) \(lastName)")
                                .font(.system(size: 32, weight: .semibold))
                            Text("@\(username)")
                                .foregroundColor(Color(hex: "FC8F21"))
                        }
                        .padding(.horizontal, 25)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        // Pfp
                        Image("\(username)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 350, height: 240)
                            .clipped()
                            .cornerRadius(16)
                        
                        // Bio
                        Text("\(bio)")
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.horizontal, 25)
                            .foregroundColor(Color(hex: "2A3A52"))
                        
                        // Connect Button
                        if isCurrentUser == false {
                            Button  {
                                if buttonClick == 0 {
                                    buttonClick = buttonClick + 1
                                }
                                else {
                                    navigateToMessage = true
                                }
                                
                            } label: {
                                if buttonClick == 0 {
                                    HStack {
                                        Text("CONNECT")
                                            .foregroundColor(Color(hex: "FFF"))
                                            .font(.system(size: 20))
                                        Image("user-add")
                                            .frame(width: 20, height: 20)
                                    }
                                    .frame(width: 170, height: 45)
                                    .background(Color(hex: "9747FF"))
                                    .cornerRadius(4)
                                }
                                else {
                                    HStack {
                                        Text("MESSAGE")
                                            .foregroundColor(Color.white)
                                    }
                                    .frame(width: 170, height: 45)
                                    .background(Color(hex: "9747FF"))
                                    .cornerRadius(4)
                                }
                            }
                        }
                        
                        //About Section
                            //About Tab
                            HStack(alignment: .top, spacing: 8) {
                                Text("About")
                                .font(
                                Font.custom("Inter", size: 14)
                                .weight(.semibold)
                                )
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .frame(width: 160, alignment: .top)
                            .background(.white)
                            .cornerRadius(24)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 1, y: 1)
                            .zIndex(100)
                            .offset(y: 20)
                            
                            
                            VStack(alignment: .leading, spacing: 0) {
                                if isCurrentUser == false {
                                    //Mutuals
                                    Text("Mutuals (\(mutualsNum))")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                        .padding()
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 16) {
                                            ForEach(Array(mutuals), id: \.self) { mutual in
                                                Mutual(username: mutual)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                    
                                    // Interest Matches
                                    VStack (alignment: .leading) {
                                        Text("Matches")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 20))
                                            .frame(maxWidth: .infinity, alignment: .topLeading)
                                            .padding(.horizontal)
                                            .padding(.top)
                                        
                                        FlowLayout(spacing: 8) {
                                            ForEach(Array(mutualInterests), id: \.self) { interest in
                                                InterestToken(hobby: interest, isSelected: true)
                                            }
                                        }
                                        .padding(.horizontal)
                                        .padding(.bottom, 10)
                                    }
                                    .background(Color(hex: "FFF8F0"))
                                    .cornerRadius(24)
                                    .padding()
                                }
                                
                                // Other Interests
                                VStack (alignment: .leading) {
                                    Text("Interests & Hobbies")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                        .padding(.horizontal)
                                        .padding(.top)
                                    
                                    FlowLayout(spacing: 8) {
                                        ForEach(Array(interests), id: \.self) { interest in
                                            InterestToken(hobby: interest, isSelected: false)
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                    
                                }
                                .background(Color(hex: "FFF8F0"))
                                .cornerRadius(24)
                                .padding(.horizontal)
                                .padding(.bottom)
                                .padding(.top, CGFloat(interestsPadding))
                                
                                // About Me
                                VStack (alignment: .leading) {
                                    Text("About Me")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                        .padding(.horizontal)
                                        .padding(.top)
                                    HStack {
                                        Text("Gender")
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 16))
                                            .padding(.horizontal)
                                            .padding (.top, 5)
                                        Text("\(gender)")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal)
                                    }
                                    
                                    HStack {
                                        Text("Birthday")
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 16))
                                            .padding(.horizontal)
                                            .padding (.top, 5)
                                            .padding (.bottom, 10)
                                        Text("\(birthday)")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal)
                                    }
                                                                    }
                                .background(Color(hex: "FFF8F0"))
                                .cornerRadius(24)
                                .padding(.horizontal)
                                
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                
                            }
                            .padding(.horizontal, 0)
                            .padding(.top, 10)
                            .frame(height: .infinity, alignment: .topLeading)
                            .ignoresSafeArea()
                            .background(
                            LinearGradient(
                            stops: [
                            Gradient.Stop(color: Color(red: 1, green: 0.91, blue: 0.76), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.93, green: 0.84, blue: 1), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: -0.42, y: -2.62),
                            endPoint: UnitPoint(x: 1.3, y: 2.84)
                            )
                            )
                            .cornerRadius(24)
                        }
//                        .padding(.top, 0)
//                        .offset(y: 20)
                    }
            }
            .padding(.top, 50)
            .ignoresSafeArea()
            
            NavigationLink(
                destination: MessagingView(),
                isActive: $navigateToMessage
            ) {
                EmptyView()
            }
        }
        .navigationDestination(isPresented: $navigateToMessage) {
            MessageScreen()
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(user: TonicViewModel().currentUser, isCurrentUser: true)
    }
}
