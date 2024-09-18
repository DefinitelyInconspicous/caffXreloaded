//
//  Logbook.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 16/9/24.
//

import SwiftUI

struct Logbook: View {
    @Binding var logbook: [log]
    var body: some View {
        NavigationStack {
            List {
                if logbook == [] || logbook == [log(caff: 0, name: "", date: .now)] {
                    Text("There are no logs to be logged")
                } else {
                    ForEach($logbook) { log in
                        VStack {
                            Text(log.date.wrappedValue.formatted(date: .abbreviated, time: .omitted) + " " + log.date.wrappedValue.formatted(date: .omitted, time: .shortened))
                                .fontDesign(.rounded)
                                .opacity(0.5)
                            HStack {
                                Text(log.name.wrappedValue)
                                    .bold()
                                Spacer()
                                Text(String(log.caff.wrappedValue))
                                    .font(.largeTitle)
                            }
                        }
                    }
                   
                }
            }
            .navigationTitle("Logbook")
            if logbook != [] && logbook != [log(caff: 0, name: "", date: .now)] {
                Section {
                    Button {
                        logbook = []
                    } label: {
                        Text("Delete all Logs")
                            .foregroundStyle(.red)
                    }
                }
            }
            
        }
        .onAppear() {
            logbook.sort {
                $0.date < $1.date
            }
        }
    }
}

#Preview {
    Logbook(logbook: .constant([log(caff: 0, name: "", date: .now)]))
}
