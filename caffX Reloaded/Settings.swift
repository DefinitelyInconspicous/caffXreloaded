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
        Section {
            HStack {
                Text("Hard Limit")
                Button {
                    LimitInfo()
                } label: {
                    Image(systemName: "info.circle.fill")
                }
                Spacer()
                Picker(selection: $hardLimit, label: Text("Numbers")) {
                    ForEach(0...1000, id: \.self) { number in
                        Text(String(number))
                    }
                }.pickerStyle(.wheel)
            }
        }
    }
}

#Preview {
    Settings(hardLimit: .constant(400))
}
