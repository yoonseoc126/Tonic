//
//  Mutual.swift
//  Tonic
//
//  Created by Student on 11/29/24.
//

import SwiftUI

struct Mutual: View {
    let username: String
    
    
    init(username: String) {
        self.username = username
    }
    
    var body: some View {
        VStack {
            Image("\(username)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 65)
                .clipped()
                .cornerRadius(16)
            Text("@\(username)")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "2A3A52"))
        }
    }
}

struct Mutual_Previews: PreviewProvider {
    static var previews: some View {
        Mutual(username:TonicViewModel().currentUser.username)
    }
}
