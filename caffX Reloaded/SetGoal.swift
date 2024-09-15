//
//  SetGoal.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 9/9/24.
//

import SwiftUI
import Combine

struct SetGoal: View {
    @State var goalDate: Date
    @State var intakeGoal = "100"
    @Binding var currentIntake: Double
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Current Daily Intake")
                        Spacer()
                        TextField("Daily Intake", text: $intakeGoal)
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
            
        }
    }
}

#Preview {
    SetGoal(goalDate: .now, currentIntake: .constant(0))
}
