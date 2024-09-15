import SwiftUI

// Helper function to get time in "HH:mm" format from Date
func hour24(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH"
    return dateFormatter.string(from: date)
}


// Intake entry view
struct addIntake: View {
    @Binding var intakeGraph: [caffEntry]  // Binding to update the main graph
    @State var date: Date
    @State var selectedDate = Date()        // Date for the intake
    @State var customDrink: String          // For custom drink name
    @State var selectedDrink: drink         // Selected drink from picker
    @State var wrongDate = false            // State for wrong date alert
    @State var calcCaff = [0]               // For calculated caffeine
    @State var currCaff = 0.0               // Current caffeine level
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section {
                // Date picker for intake time
                DatePicker("Date", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                
                // Picker for selecting a drink
                Picker("Drink", selection: $selectedDrink) {
                    ForEach(drinkList, id: \.self) { item in
                        Text(item.name)
                            .font(.headline)
                            .padding()
                    }
                }
                
                // Show caffeine amount if drink is not custom
                if selectedDrink.name != "Custom" {
                    HStack {
                        Text("Caffeine")
                        Spacer()
                        Text(String(selectedDrink.caff))
                            .foregroundStyle(.gray)
                    }
                }
            }
            
            // Section for custom drink input
            if selectedDrink.name == "Custom" {
                Section {
                    TextField("Custom Drink", text: $customDrink)
                        .font(.headline)
                    TextField("Caff amount", value: $currCaff, format: .number)
                        .font(.headline)
                        .keyboardType(.numberPad)
                }
            }
            
            // Add intake button
            Button {
                // Calculate time since last intake
                let intCaff = selectedDrink.name == "Custom" ? currCaff : selectedDrink.caff
                let calcTime = Double(hour24(from: selectedDate)) ?? 0.0
                
                if calcTime >= 24 {
                    wrongDate = true
                } else {
                    let newEntry = caffEntry(caff: intCaff, time: calcTime)
                    intakeGraph.append(newEntry)
                    intakeGraph.sort { $0.time < $1.time }
                    dismiss()
                }
            } label: {
                Text("Add Intake")
                    .fontWeight(.bold)
            }
        }
        .alert("Wrong Date", isPresented: $wrongDate) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    addIntake(intakeGraph: .constant([]), date: .now, customDrink: "", selectedDrink: drink(name: "", caff: 0))
}
