import SwiftUI
import Charts
import Forever
import TipKit

struct caffEntry: Identifiable, Codable, Equatable {
    var id = UUID()
    var caff: Double
    var time: Double
}

struct log: Identifiable, Codable, Equatable {
    var id = UUID()
    var caff: Double
    var name: String
    var date: Date
}

struct ContentView: View {
    
    @State var add = false
    @State var customDrink: String = ""
    @State var entryDate: Date = .now
    @State var selectedDrink: drink = drink(name: "", caff: 0)
    @State var currCaff = 0.0
    @State var setGoal = false
    @State var selectedView = 0
    @State var hardLimit = 400
    @State var currIntakeGoal = 0
    @State var curravg = 0
    @State var savedDate = Date.now.formatted(date: .abbreviated, time: .omitted)
    let graphTip = graphBasic()
    @Forever("intakeGoal") var intakeGoal = "0"
    @Forever("goalDate") var goalDate: Date = .now
    
    @Forever("dailyAvg") var dailyAvg: Double = 0
    
    @Forever(wrappedValue: [], "avgList") var avgList: [Double]
    
    @Forever("caffeineIntake") var caffIntake: [caffEntry] = []
    
    @Forever("logbook") var logbook: [log] = []
    
    @Forever("caffeineChart") var caffChart: [caffEntry] = [(caffEntry(caff: 0, time: 0)),(caffEntry(caff: 0, time: 1)),(caffEntry(caff: 0, time: 2)),(caffEntry(caff: 0, time: 3)),(caffEntry(caff: 0, time: 4)),(caffEntry(caff: 0, time: 5)),(caffEntry(caff: 0, time: 6)),(caffEntry(caff: 0, time: 7)),(caffEntry(caff: 0, time: 8)),(caffEntry(caff: 0, time: 9)),(caffEntry(caff: 0, time: 10)),(caffEntry(caff: 0, time: 11)),(caffEntry(caff: 0, time: 12)),(caffEntry(caff: 0, time: 13)),(caffEntry(caff: 0, time: 14)),(caffEntry(caff: 0, time: 15)),(caffEntry(caff: 0, time: 16)),(caffEntry(caff: 0, time: 17)),(caffEntry(caff: 0, time: 18)),(caffEntry(caff: 0, time: 19)),(caffEntry(caff: 0, time: 20)),(caffEntry(caff: 0, time: 21)),(caffEntry(caff: 0, time: 22)),(caffEntry(caff: 0, time: 23))]
    
    var body: some View {
        
        NavigationStack {
            Section {
                VStack {
                    if (logbook.filter({$0.date.formatted(date: .abbreviated, time: .omitted) == Date.now.formatted(date: .abbreviated, time: .omitted)}).reduce(0){$0 + $1.caff}) >= Double(currIntakeGoal) {
                        Text("You've exceeded your goal by \((Int(logbook.filter({$0.date.formatted(date: .abbreviated, time: .omitted) == Date.now.formatted(date: .abbreviated, time: .omitted)}).reduce(0){$0 + $1.caff})) - currIntakeGoal)! Don't drink anymore!")
                    }
                    Chart {
                        withAnimation {
                            PointMark(x: .value("slide", selectedView), y: .value("Goal", caffChart[selectedView].caff))
                        }
                        
                        ForEach(caffChart) { entry in
                            LineMark(
                                x: .value("Time", entry.time),
                                y: .value("Caffeine", entry.caff)
                            )
                            .foregroundStyle(.red)
                            .interpolationMethod(.monotone)
                            
                            RuleMark(
                                xStart: .value("Start", 0),
                                xEnd: .value("End", 23),
                                y: .value("Limit", hardLimit)
                            )
                            .foregroundStyle(.purple)
                            if (Double(intakeGoal) ?? 0) != 0 {
                                RuleMark(
                                    xStart: .value("Start", 0),
                                    xEnd: .value("End", 23),
                                    y: .value("Goal", currIntakeGoal)
                                )
                                
                            }
                        }
                    }
                    .popoverTip(graphTip)
                    .padding()
                    .frame(width: 330, height: 200)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .chartXScale(domain: 0...24)
                    .chartForegroundStyleScale([
                        "Intake": .red, "Daily Goal": .blue, "Hard Limit": .purple
                    ])
                    
                    Section {
                        VStack {
                            HStack {
                                
                                Slider(
                                    value: .init(
                                        get: {
                                            Double(selectedView)
                                        },
                                        set: {
                                            selectedView = Int($0.rounded())
                                        }
                                    ),
                                    in: 0...23
                                )
                                .frame(width: 300)
                            }
                            HStack {
                                Text("Caffeine: ")
                                Text(String(round(caffChart[selectedView].caff)))
                            }
                        }
                        
                    }
                }
            }
            
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
                if (Double(intakeGoal) ?? 0) == 0 {
                    Text("Set Goal")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                } else {
                    Text("Edit Goal")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
            .padding(.horizontal, 20)
            
            NavigationLink {
                Logbook(logbook: $logbook)
            } label: {
                Text("Logbook")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Button {
                caffIntake = []
                caffChart = []
                logbook = []
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
                .toolbar() {
                    ToolbarItem {
                        NavigationLink {
                            Settings(hardLimit: $hardLimit)
                        } label: {
                            Image(systemName: "gearshape")
                                .imageScale(.large)
                        }
                    }
                }
        }
        .onChange(of: caffIntake) {
            processCaffeineIntakeData()
        }
        .onAppear {
            processCaffeineIntakeData()
            processGoal()
            dateProcess()
            
        }
        .sheet(isPresented: $add) {
            addIntake(intakeGraph: $caffIntake, logbook: $logbook, date: entryDate, customDrink: customDrink, selectedDrink: selectedDrink)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $setGoal) {
            SetGoal(goalDate: $goalDate, intakeGoal: $intakeGoal, currentIntake: $dailyAvg)
                .presentationDetents([.medium])
        }
    }

    func processCaffeineIntakeData() {
        let halfLife = 5.5
        
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
    func dateProcess() {
        if (savedDate != (Date.now.formatted(date: .abbreviated, time: .omitted))) {
            for i in logbook.filter({$0.date.formatted(date: .abbreviated, time: .omitted) == Date.now.formatted(date: .abbreviated, time: .omitted)}) {
                curravg += Int(i.caff)
            }
            avgList.append(Double(curravg))
            dailyAvg = Double((avgList.reduce(0) {$0 + Int($1)}) / avgList.count)
            caffIntake = []
            caffChart = []
            logbook = []
            for i in 0...23 {
                caffChart.append(caffEntry(caff: 0, time: Double(i)))
            }
        }
    }
    func processGoal() {
        let daysLeft = ((Int(hour24(from: goalDate)) ?? 0) - (Int(hour24(from: .now)) ?? 0)) / 24
        let change = (Int(dailyAvg)) - (Int(intakeGoal) ?? 0)
        let difference = round(Double(change / (daysLeft != 0 ?  daysLeft : 1)))
        currIntakeGoal = (Int(dailyAvg)) - Int(difference)
    }
    
}

#Preview {
    ContentView(customDrink: "", entryDate: .now, selectedDrink: drink(name: "", caff: 0))
}
