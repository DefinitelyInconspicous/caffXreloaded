//
//  Settings.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 13/9/24.
//

import SwiftUI

struct Settings: View {
    @Binding var hardLimit: Int
    
    var body: some View {
        NavigationStack {
            
                VStack(spacing: 10) {
                    HStack {
                        Text("Hard Limit")
                            .font(.headline)
                        
                        NavigationLink(destination: LimitInfo()) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Picker(selection: $hardLimit, label: Text("Hard Limit")) {
                        ForEach(0...1000, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)  // To provide enough space for the wheel picker
                    .clipped()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                        .shadow(radius: 5)
                )
                .padding(.horizontal)
                
                Spacer()
            
            .navigationTitle("Settings")
            .padding()
        }
    }
}

#Preview {
    Settings(hardLimit: .constant(400))
}
