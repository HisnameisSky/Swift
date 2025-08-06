//
//  ProfileHeader.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI

//[](:.)
struct ProfileHeader: View {
    
    let user: User
    
    var body: some View {
        
        HStack {
            
            Image(user.userImage)
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
                .clipped()
                .padding()
            Spacer()
            
            VStack {
                Text("205")
                    .font(Font.system(size: 16, weight: .bold))
                Text("Posts")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()
            
            VStack {
                Text("364")
                    .font(Font.system(size: 16, weight: .bold))
                Text("Followers")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()
            
            VStack {
                Text("358")
                    .font(Font.system(size: 16, weight: .bold))
                Text("Following")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()
        }
        
        HStack {
            Text("I breathe life in objects #Programmer \nStraight Edge \nAiming to make this planet #gogreen \nLoves Football \nFan of @fcbarcelona @liverpoolfc \npankajgaikar.com")
                .font(.caption)
                .padding(.horizontal)
            Spacer()
        }
        
    }
}

#Preview {
    ProfileHeader(user: User(userName: "pankajgaikar", userImage: "sample_post"))
}
