//
//  Settings.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 13/9/24.
//

import SwiftUI

struct Settings: View {
    @State var limit = 400
    var body: some View {
        HStack {
            Text("Limit")
            Button {
                
            } label: {
                Image(systemName: "info.circle.fill")
            }
            Spacer()
            Picker(selection: $limit, label: Text("Numbers")) {
                ForEach(0...999, id: \.self) { number in
                    Text(String(number))
                }
            }.pickerStyle(.wheel)
        }
    }
}

#Preview {
    Settings()
}
