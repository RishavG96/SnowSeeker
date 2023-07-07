//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Rishav Gupta on 06/07/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to ShowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left hand menu")
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
