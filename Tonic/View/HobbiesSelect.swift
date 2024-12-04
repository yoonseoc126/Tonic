//
//  HobbiesSelect.swift
//  Tonic
//
//  Created by Student on 11/16/24.
//

import SwiftUI

struct HobbiesSelect: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var tonicViewModel: TonicViewModel
    @State private var navigateToNext = false
    @FocusState var showKeyboard: Bool
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var gender = "Select Gender"
    @State private var customInterest = ""
    @State private var interests: Set<String> = []
    
    private let interestOptions = ["Movies", "Art", "Cafes", "Journaling", "Camping", "Photography", "Dance", "Singing", "Museums", "Crochet", "Soccer", "Basketball", "Bouldering", "Bowling", "Exercise", "Theatre", "Concerts", "Kpop", "K-R&B", "Rap", "Band", "EDM", "Documentaries", "K-drama", "Anime", "Horror", "True Crime", "Rom-com", "Thriller", "Fantasy", "Reality Shows", "Indie"]
    private let genderOptions = ["Male", "Female", "Non-Binary", "Prefer not to say"]
    private let minimumInterests = 5
    
    private var user: Person?
    
    init(user: Person? = nil) {
        self.user = user
        if let user = user {
            _firstName = State(initialValue: user.firstName)
            _lastName = State(initialValue: user.lastName)
            _gender = State(initialValue: user.gender)
            _interests = State(initialValue: Set(user.interests))
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress Bar
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 350, height: 10)
                        .foregroundColor(Color(hex: "D9D9D9"))
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 210, height: 10, alignment: .leading)
                        .frame(maxWidth: 350, maxHeight: 50, alignment: .leading)
                        .foregroundColor(Color(hex: "9372FF"))
                }
                .position(x: 195, y: 0)
                .frame(height: 70)
                .padding(.top, 20)
                
                // Header
                Text("List Your Interests")
                    .font(.system(size: 35, weight: .semibold))
                    .frame(maxWidth: 350, alignment: .leading)
                    .frame(height: 20)
                
                Text("Choose at least 5 tokens!")
                    .frame(maxWidth: 350, alignment: .leading)
                    .frame(height: 50)
                
                // Selected Interests
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        if !interests.isEmpty {
                            //                        Text("Selected Interests")
                            //                            .font(.headline)
                            //                            .padding(.horizontal)
                            
                            FlowLayout(spacing: 8) {
                                ForEach(Array(interests), id: \.self) { interest in
                                    InterestToken(hobby: interest, isSelected: true)
                                        .onTapGesture {
                                            interests.remove(interest)
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        //                    Text("Suggested Interests")
                        //                        .font(.headline)
                        //                        .padding(.horizontal)
                        
                        FlowLayout(spacing: 8) {
                            ForEach(interestOptions.filter { !interests.contains($0) }, id: \.self) { interest in
                                InterestToken(hobby: interest, isSelected: false)
                                    .onTapGesture {
                                        interests.insert(interest)
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
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
                try? await Task.sleep(nanoseconds: 500_000_000)
                showKeyboard = true
            }
        }
        .navigationDestination(isPresented: $navigateToNext) {
            IntroduceScreenThree()
        }
    }
}

// Flow Layout for wrapping tokens
struct FlowLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrangementHelper(proposal: proposal, subviews: subviews)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrangementHelper(proposal: proposal, subviews: subviews)
        
        for idx in result.frames.indices {
            subviews[idx].place(at: CGPoint(x: bounds.minX + result.frames[idx].minX,
                                          y: bounds.minY + result.frames[idx].minY),
                              anchor: .topLeading,
                              proposal: ProposedViewSize(result.frames[idx].size))
        }
    }
    
    private func arrangementHelper(proposal: ProposedViewSize, subviews: Subviews) -> (frames: [CGRect], size: CGSize) {
        var frames: [CGRect] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        var maxWidth: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if currentX + size.width > (proposal.width ?? .infinity) {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            
            frames.append(CGRect(x: currentX, y: currentY, width: size.width, height: size.height))
            lineHeight = max(lineHeight, size.height)
            currentX += size.width + spacing
            maxWidth = max(maxWidth, currentX)
        }
        
        return (frames, CGSize(width: maxWidth, height: currentY + lineHeight))
    }
}

struct HobbiesSelect_Previews: PreviewProvider {
    static var previews: some View {
        HobbiesSelect()
    }
}
