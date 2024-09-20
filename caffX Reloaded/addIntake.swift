import SwiftUI
import Forever

// Helper function to get time in "HH" format from Date
func hour24(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH"
    return dateFormatter.string(from: date)
}

// Intake entry view
struct addIntake: View {
    @Binding var intakeGraph: [caffEntry]  // Binding to update the main graph
    @Binding var logbook: [log]
    @State var date: Date
    @State var selectedDate = Date()        // Date for the intake
    @State var customDrink: String          // For custom drink name
    @State var selectedDrink: drink         // Selected drink from picker
    @Forever("favourites") var favorites: [drink] = []      // List of favorite drinks
    @State var wrongDate = false            // State for wrong date alert
    @State var calcCaff = [0]               // For calculated caffeine
    @State var currCaff = 0.0               // Current caffeine level
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section {
                // Date picker for intake time
                DatePicker("Date", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                
                // Picker for selecting a drink (Favorites first)
                Picker("Drink", selection: $selectedDrink) {
                    if !favorites.isEmpty {
                        Text("Favorites").font(.headline)
                        ForEach(favorites, id: \.self) { item in
                            Text(item.name)
                        }
                    }
                    
                    Text("All Drinks").font(.headline)
                    ForEach(drinkList, id: \.self) { item in
                        Text(item.name)
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
                
                // Add/Remove from Favorites
                Button {
                    toggleFavorite(drink: selectedDrink)
                } label: {
                    HStack {
                        Image(systemName: isFavorite(drink: selectedDrink) ? "star.fill" : "star")
                        Text(isFavorite(drink: selectedDrink) ? "Remove from Favorites" : "Add to Favorites")
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
                addNewIntake()
            } label: {
                Text("Add Intake")
                    .fontWeight(.bold)
            }

            // Favorite drink buttons
            if !favorites.isEmpty {
                Section(header: Text("Quick Add Favorites")) {
                    ForEach(favorites, id: \.self) { favorite in
                        Button {
                            autoAddFavorite(favorite)
                        } label: {
                            HStack {
                                Text(favorite.name)
                                    .bold()
                                Spacer()
                                Text("\(Int(favorite.caff)) mg")
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
            }
        }
        .alert("Wrong Date", isPresented: $wrongDate) {
            Button("OK", role: .cancel) { }
        }
    }
    
    // Function to toggle the favorite status of a drink
    func toggleFavorite(drink: drink) {
        if let index = favorites.firstIndex(of: drink) {
            favorites.remove(at: index)
        } else {
            favorites.append(drink)
        }
    }
    
    // Function to check if a drink is a favorite
    func isFavorite(drink: drink) -> Bool {
        return favorites.contains(drink)
    }
    
    // Function to add a new intake manually
    func addNewIntake() {
        let intCaff = selectedDrink.name == "Custom" ? currCaff : selectedDrink.caff
        
        if selectedDate > .now {
            wrongDate = true
        } else {
            let newEntry = caffEntry(caff: intCaff, time: Double(hour24(from: selectedDate)) ?? 0)
            logbook.append(log(caff: intCaff, name: selectedDrink.name == "Custom" ? customDrink : selectedDrink.name, date: selectedDate))
            intakeGraph.append(newEntry)
            intakeGraph.sort { $0.time < $1.time }
            dismiss()
        }
    }
    
    // Function to auto-add favorite intake
    func autoAddFavorite(_ favorite: drink) {
        let newEntry = caffEntry(caff: favorite.caff, time: Double(hour24(from: selectedDate)) ?? 0)
        logbook.append(log(caff: favorite.caff, name: favorite.name, date: selectedDate))
        intakeGraph.append(newEntry)
        intakeGraph.sort { $0.time < $1.time }
        dismiss()
    }
}

#Preview {
    addIntake(intakeGraph: .constant([]), logbook: .constant([log(caff: 0, name: "", date: .now)]), date: .now, customDrink: "", selectedDrink: drink(name: "Espresso", caff: 64))
}
