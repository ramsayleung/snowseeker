//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by ramsayleung on 2024-04-07.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View{
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from left edge to show it.")
        }
    }
}

#Preview {
    WelcomeView()
}
