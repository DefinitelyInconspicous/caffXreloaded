import SwiftUI
import Charts
import Forever

struct caffEntry: Identifiable, Decodable, Encodable {
    var id = UUID()
    var caff: Double
    var time: Double
}

struct ContentView: View {
    @Forever("caffG") var caffG: [caffEntry] = [(caffEntry(caff: 0, time: 0)),(caffEntry(caff: 0, time: 1)),(caffEntry(caff: 0, time: 2)),(caffEntry(caff: 0, time: 3)),(caffEntry(caff: 0, time: 4)),(caffEntry(caff: 0, time: 5)),(caffEntry(caff: 0, time: 6)),(caffEntry(caff: 0, time: 7)),(caffEntry(caff: 0, time: 8)),(caffEntry(caff: 0, time: 9)),(caffEntry(caff: 0, time: 10)),(caffEntry(caff: 0, time: 11)),(caffEntry(caff: 0, time: 12)),(caffEntry(caff: 0, time: 13)),(caffEntry(caff: 0, time: 14)),(caffEntry(caff: 0, time: 15)),(caffEntry(caff: 0, time: 16)),(caffEntry(caff: 0, time: 17)),(caffEntry(caff: 0, time: 18)),(caffEntry(caff: 0, time: 19)),(caffEntry(caff: 0, time: 20)),(caffEntry(caff: 0, time: 21)),(caffEntry(caff: 0, time: 22)),(caffEntry(caff: 0, time: 23))]
    
    @State var add = false
    @State var firstInt = false
    @State var customDrink: String
    @State var entryDate: Date
    @State var selectedDrink: drink
    @State var currCaff = 0.0
    @State var setGoal = false
    
    @Forever("dailyAvg") var dailyAvg: Double = 0
    @Forever(wrappedValue: [], "avgList") var avgList: [Double]
    
    var body: some View {
        NavigationStack {
            
            Chart {
                ForEach(caffG) { entry in
                    LineMark(
                        x: .value("Time", entry.time),
                        y: .value("Caffeine", entry.caff)
                    )
                    .foregroundStyle(.red)
                    .interpolationMethod(.monotone)
                }
            }
            .padding()
            .frame(width: 330, height: 200)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.top, 20)
            .chartXScale(domain: 0...24) // Set x-axis range to 24 hours
            
            
            Button {
                                add = true
                            } label: {
                                Text("Add Intake")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 20)
                            
                            Button {
                                setGoal = true
                            } label: {
                                Text("Set Goal")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 20)
    
                            Button {
                                caffG = [(caffEntry(caff: 0, time: 0)),(caffEntry(caff: 0, time: 1)),(caffEntry(caff: 0, time: 2)),(caffEntry(caff: 0, time: 3)),(caffEntry(caff: 0, time: 4)),(caffEntry(caff: 0, time: 5)),(caffEntry(caff: 0, time: 6)),(caffEntry(caff: 0, time: 7)),(caffEntry(caff: 0, time: 8)),(caffEntry(caff: 0, time: 9)),(caffEntry(caff: 0, time: 10)),(caffEntry(caff: 0, time: 11)),(caffEntry(caff: 0, time: 12)),(caffEntry(caff: 0, time: 13)),(caffEntry(caff: 0, time: 14)),(caffEntry(caff: 0, time: 15)),(caffEntry(caff: 0, time: 16)),(caffEntry(caff: 0, time: 17)),(caffEntry(caff: 0, time: 18)),(caffEntry(caff: 0, time: 19)),(caffEntry(caff: 0, time: 20)),(caffEntry(caff: 0, time: 21)),(caffEntry(caff: 0, time: 22)),(caffEntry(caff: 0, time: 23))]
                            } label: {
                                Text("Delete All")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.red, lineWidth: 2)
                                    )
                            }
                            .padding(.horizontal, 20)
            Spacer()
                .navigationTitle("caffX")

        }
        .onAppear {
            processCaffeineData()
        }
        .sheet(isPresented: $add) {
            addIntake(intakeGraph: $caffG, date: entryDate, firstint: $firstInt, customDrink: customDrink, selectedDrink: selectedDrink)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $setGoal) {
            SetGoal(goalDate: .now, currentIntake: $dailyAvg)
        }
    }
    
    // Helper to reset the graph data
    
    private func processCaffeineData() {
        let halfLife = 5.5
        let currentTime = hour24(from: Date()) // Get the current time in hours
        
        // Create a copy of the entries to avoid modifying the array while iterating
        var updatedEntries = [caffEntry]()
        
        for entry in caffG {
            if entry.caff > 0 {
                // Calculate the decayed caffeine value based on the elapsed time
                let elapsedTime = Double(currentTime) ?? 24 - entry.time
                let decayFactor = pow(0.5, elapsedTime / halfLife)
                let decayedCaff = entry.caff * decayFactor
                // Ensure caffeine level does not go below zero
                let updatedCaff = max(decayedCaff, 0)
                
                updatedEntries.append(caffEntry(caff: updatedCaff, time: entry.time))
            } else {
                updatedEntries.append(entry) // Keep zero entries unchanged
            }
        }
        
        // Update the caffG array with the decayed values
        caffG = updatedEntries
    }

}

#Preview {
    ContentView(customDrink: "", entryDate: .now, selectedDrink: drink(name: "", caff: 0))
}
