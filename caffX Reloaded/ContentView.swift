import SwiftUI
import Charts
import Forever

struct caffEntry: Identifiable, Codable, Equatable {
    var id = UUID()
    var caff: Double
    var time: Double
}

struct ContentView: View {
    
    @State var add = false
    @State var customDrink: String
    @State var entryDate: Date
    @State var selectedDrink: drink
    @State var currCaff = 0.0
    @State var setGoal = false
    
    @Forever("dailyAvg") var dailyAvg: Double = 0
    @Forever(wrappedValue: [], "avgList") var avgList: [Double]
    
    @Forever("caffeineIntake") var caffIntake: [caffEntry] = []
    
    @Forever("caffeineChart") var caffChart: [caffEntry] = [(caffEntry(caff: 0, time: 0)),(caffEntry(caff: 0, time: 1)),(caffEntry(caff: 0, time: 2)),(caffEntry(caff: 0, time: 3)),(caffEntry(caff: 0, time: 4)),(caffEntry(caff: 0, time: 5)),(caffEntry(caff: 0, time: 6)),(caffEntry(caff: 0, time: 7)),(caffEntry(caff: 0, time: 8)),(caffEntry(caff: 0, time: 9)),(caffEntry(caff: 0, time: 10)),(caffEntry(caff: 0, time: 11)),(caffEntry(caff: 0, time: 12)),(caffEntry(caff: 0, time: 13)),(caffEntry(caff: 0, time: 14)),(caffEntry(caff: 0, time: 15)),(caffEntry(caff: 0, time: 16)),(caffEntry(caff: 0, time: 17)),(caffEntry(caff: 0, time: 18)),(caffEntry(caff: 0, time: 19)),(caffEntry(caff: 0, time: 20)),(caffEntry(caff: 0, time: 21)),(caffEntry(caff: 0, time: 22)),(caffEntry(caff: 0, time: 23))]
    
    var body: some View {
        NavigationStack {
            Chart {
                ForEach(caffChart) { entry in
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
                caffIntake = []
                caffChart = []
                for i in 0...23 {
                    caffChart.append(caffEntry(caff: 0, time: Double(i)))
                }
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
        .onChange(of: caffIntake) {
            processCaffeineIntakeData()
        }
        .onAppear {
            processCaffeineIntakeData()
        }
        .sheet(isPresented: $add) {
            addIntake(intakeGraph: $caffIntake, date: entryDate, customDrink: customDrink, selectedDrink: selectedDrink)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $setGoal) {
            SetGoal(goalDate: .now, currentIntake: $dailyAvg)
        }
    }
    
    // Helper to reset the graph data
    private func processCaffeineIntakeData() {
        let halfLife = 5.5
        let currentTime = hour24(from: Date())
        
        var newCaffChart: [caffEntry] = []
        for i in 0...23 {
            newCaffChart.append(caffEntry(caff: 0, time: Double(i)))
        }
        
        for intake in caffIntake {
            var intakesCaffeineDecayGraph: [caffEntry] = []
            
            // fills in the hours before intake with blank caffEntries
            for i in 0..<Int(intake.time) {
                intakesCaffeineDecayGraph.append(caffEntry(caff: 0, time: Double(i)))
            }
            
            // calculates caffeine decay
            for i in 0...23 {
                let halfLifeDivisorMultiplier = Double(i) / halfLife
                let halfLifeDivisor = pow(2, halfLifeDivisorMultiplier)
                let decayedCaff = intake.caff / halfLifeDivisor
                let updatedCaff = max(decayedCaff, 0)
                intakesCaffeineDecayGraph.append(caffEntry(caff: updatedCaff, time: intake.time + Double(i)))
            }
            
            // fills in the hours after decay with blank caffEntries, if there are less than 24 caffEntries
            if intakesCaffeineDecayGraph.count < 24 {
                for i in intakesCaffeineDecayGraph.count-1...23 {
                    intakesCaffeineDecayGraph.append(caffEntry(caff: 0, time: Double(i)))
                }
            }
            
            // adds to newCaffChart
            for i in 0...23 {
                newCaffChart[i] = caffEntry(caff: newCaffChart[i].caff + intakesCaffeineDecayGraph[i].caff, time: Double(i))
            }
        }
        
        // adds to main graph
        caffChart = newCaffChart
    }
}

#Preview {
    ContentView(customDrink: "", entryDate: .now, selectedDrink: drink(name: "", caff: 0))
}
