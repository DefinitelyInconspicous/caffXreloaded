//
//  WelcomeView.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 20/9/24.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        VStack {
            HStack  {
                Spacer()
                Image("AppIcon.png")
                    .imageScale(.large)
                Spacer()
            }
            Text("Welcome to caffX!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            Text("caffX helps you track your caffeine intake and set goals to limit your daily consumption.")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Features include:")
                .font(.headline)
                .padding(.top, 10)
            
            VStack(alignment: .leading) {
                Text("• Track your caffeine intake with custom or predefined drinks.")
                Text("• View daily caffeine consumption charts and goals.")
                Text("• Set intake goals and monitor your progress.")
                Text("• Analyze your caffeine levels with an easy-to-read graph.")
            }
            .padding(.horizontal)
            
            // Explanation of how to read the graph
            VStack(alignment: .center, spacing: 10) {
                Text("How to Read the Graph:")
                    .font(.headline)
                    .padding(.top, 20)
                Text("The graph displays your caffeine levels throughout the day. \nThe x-axis represents the time of day, while the y-axis shows your caffeine intake. \nKeep an eye on the graph to ensure you stay within your daily limits and avoid overconsumption.")
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Button{
                // Set first launch flag to false and close the welcome screen
                isFirstLaunch = false
                UserDefaults.standard.set(false, forKey: "isFirstLaunch")
            } label: {
                Text("Get Started")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
