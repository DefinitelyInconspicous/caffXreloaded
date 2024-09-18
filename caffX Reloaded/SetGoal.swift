//
//  SetGoal.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 9/9/24.
//

import SwiftUI
import Combine
import Forever

struct SetGoal: View {
    @Binding var goalDate: Date
    @Binding var intakeGoal: String
    @Binding var currentIntake: Double
    @State var currIntake = ""
    @Forever(wrappedValue: "", "intakeGoal") var savedGoal: String
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Current Daily Intake")
                        Spacer()
                        TextField("Daily Intake", text: $currIntake)
                            .keyboardType(.numberPad)
                            .onReceive(Just(intakeGoal)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.intakeGoal = filtered
                                }
                            }
                            .frame(width: 100)
                            .disableAutocorrection(true)
                            
                            .textFieldStyle(.roundedBorder)
                        
                    }

                    HStack {
                        Text("Daily Intake Goal")
                        Spacer()
                        TextField("Goal", text: $intakeGoal)
                            .keyboardType(.numberPad)
                            .onReceive(Just(intakeGoal)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.intakeGoal = filtered
                                }
                            }
                            .frame(width: 100)
                            .disableAutocorrection(true)
                            .textFieldStyle(.roundedBorder)
                        
                    }
                    DatePicker("By when do you want to acheive this goal?", selection: $goalDate, displayedComponents: [.date])
                    
                              
                }
                Button{
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text("Save goal")
                            .foregroundStyle(.green)
                            .fontWeight(.heavy)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Set Goal")
            
            if Double(savedGoal) != 0 {
                Button {
                    intakeGoal = "0"
                    goalDate = .now
                } label: {
                    Text("Delete Goal")
                        .foregroundStyle(.red)
                        .fontWeight(.medium)
                }
            }
            
            
            
        }
        .onAppear() {
            currIntake = String(currentIntake)
            currentIntake = Double(currIntake) ?? 0
        }
    }
}

#Preview {
    SetGoal(goalDate: .constant(.now), intakeGoal: .constant("0"), currentIntake: .constant(0))
}
