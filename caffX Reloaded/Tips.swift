//
//  Tips.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 16/9/24.
//

import SwiftUI
import TipKit

struct Tips: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct graphBasic: Tip {
    var title: Text {
        Text("This is your Caffeine tracker")
    }
    var message: Text? {
        Text("Just add in your intakes, goal, and limit and this graph will sort everything out for you!")
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

struct intakeadd: Tip {
    var title: Text {
        Text("Adding your Intake")
    }
    var message: Text? {
        Text("Add in your caffeinated drink intake by entering your values for time it was drunk, and the drink. You can also select custom if you wish.")
    }
    var image: Image? {
        Image(systemName: "plus.app")
    }
}

#Preview {
    Tips()
}
