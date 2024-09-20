//
//  Logbook.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 16/9/24.
//

import SwiftUI

struct Logbook: View {
    @Binding var logbook: [log]
    
    var groupedLogs: [Date: [log]] {
        // Group logs by just the date (ignoring time)
        Dictionary(grouping: logbook) { logEntry in
            Calendar.current.startOfDay(for: logEntry.date)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if logbook.isEmpty || logbook == [log(caff: 0, name: "", date: .now)] {
                    Text("There are no logs to be logged")
                } else {
                    // Iterate over each group (date-based)
                    ForEach(groupedLogs.keys.sorted(), id: \.self) { date in
                        Section(header: HStack{
                            Text(date.formatted(date: .abbreviated, time: .omitted))
                            Spacer()
                            Text("Total Caffeine: \(totalCaffeine(for: date), specifier: "%.1f") mg")

                        }
                            .font(.headline)) {

                                ForEach(groupedLogs[date] ?? []) { logEntry in
                                    HStack {
                                        Text(logEntry.name)
                                            .bold()
                                            .font(.title2)
                                        Spacer()
                                        Text("\(logEntry.caff, specifier: "%.1f") mg")
                                            .font(.largeTitle)
                                    }
                                }
                            }
                    }
                }
            }
            .navigationTitle("Logbook")
            
            if !logbook.isEmpty && logbook != [log(caff: 0, name: "", date: .now)] {
                Section {
                    Button {
                        logbook = []
                    } label: {
                        Text("Delete all Logs")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .onAppear {
            logbook.sort { $0.date > $1.date }
        }
    }
    
    // Function to calculate the total caffeine intake for a specific day
    func totalCaffeine(for date: Date) -> Double {
        let logsForDay = groupedLogs[Calendar.current.startOfDay(for: date)] ?? []
        return logsForDay.reduce(0) { $0 + $1.caff }
    }
}

#Preview {
    Logbook(logbook: .constant([log(caff: 100, name: "Coffee", date: .now)]))
}
