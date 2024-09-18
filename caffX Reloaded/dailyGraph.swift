//
//  dailyGraph.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 18/9/24.
//

import SwiftUI
import Forever
import Charts

struct dailyGraph: View {
    @Forever(wrappedValue: [], "avgList") var avgList: [Double]
    var body: some View {
        Chart {
            ForEach(avgList, id: \.self) { data in
                LineMark(
                    x: .value("Date", avgList.firstIndex(of: data) ?? 0),
                    // Couldn't get this to work in time for submission (Supposed to show a graph of daily intake for the week, then a selection to change to month)
                    // There is also a flaw that if there are 2 days with the same value, it won't work
                    y: .value("Caff Intake", data)
                )
            }
        }
    }
}

#Preview {
    dailyGraph()
}
