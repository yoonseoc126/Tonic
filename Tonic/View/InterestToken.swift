//
//  InterestToken.swift
//  Tonic
//
//  Created by Student on 11/16/24.
//

import SwiftUI

struct InterestToken: View {
    let hobby: String
    let isSelected: Bool
    
    var body: some View {
        ZStack() {
            Text(hobby)
                .zIndex(100)
            RoundedRectangle(cornerRadius: 30)
                .frame(width: CGFloat(hobby.count) * 13, height: 35)
                .foregroundColor(isSelected == true ? Color(hex: "FC8F21") : Color(hex: "FFBB77"))
        }
    }
}

struct InterestToken_Previews: PreviewProvider {
    static var previews: some View {
        InterestToken(hobby: "ur mom", isSelected: false)
    }
}
