//
//  Tips.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 20/9/24.
//

import Foundation
import SwiftUI
import TipKit


struct graphBasic: Tip {
    var title: Text {
        Text("This is your Caffeine tracker")
    }
    var message: Text? {
        Text("X-axis: Represents time in hours from 0 to 23.Y-axis: Represents the caffeine level in milligrams (mg).\n Plots the caffeine levels across the day, showing the total intake at each hour, including decayed caffeine from earlier entries. \n Horizontal lines showing the hard caffeine limit (400 mg) and the user’s personal intake goal (if set).\n Highlights the caffeine level at the currently selected hour, as chosen by the slider.)")
    }
    var image: Image? {
        Image(systemName: "chart.xyaxis.line")
    }
}

struct timeLooker: Tip {
    var title: Text {
        Text("View Caffeine Value")
    }
    var message: Text? {
        Text("Drag this slider to view the caffeine values at different hours of the day")
    }
    var image: Image? {
        Image(systemName: "number")
    }
}

struct addIntakeTip: Tip {
    var title: Text {
        Text("Adding a Caffeine Intake")
    }
    var message: Text? {
        Text("Use the Add Intake feature to log your caffeine consumption. Select a drink from the list or enter a custom drink. The app will automatically track your intake and show it in the graph.")
    }
    var image: Image? {
        Image(systemName: "plus.circle.fill")
    }
}


struct logbookTip: Tip {
    var title: Text {
        Text("Understanding the Logbook")
    }
    var message: Text? {
        Text("The logbook keeps track of all your caffeine intakes. Each entry records the type of drink, the amount of caffeine, and the time of consumption. You can use it to review your daily intake and monitor your caffeine habits.")
    }
    var image: Image? {
        Image(systemName: "book")
    }
}

