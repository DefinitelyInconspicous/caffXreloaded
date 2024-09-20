//
//  drinkList.swift
//  caffX
//
//  Created by Avyan Mehra on 20/8/24.
//

import Foundation

struct drink: Hashable, Identifiable, Codable {
    var name: String
    var id = UUID()
    var caff: Double
}

var drinkList = [
    drink(name: "Espresso", caff: 64),
    drink(name: "Brewed Coffee", caff: 96),
    drink(name: "Instant Coffee", caff: 62),
    drink(name: "Black Tea", caff: 47),
    drink(name: "Green Tea", caff: 28),
    drink(name: "Bottled Tea", caff: 19),
    drink(name: "Americano", caff: 64),
    drink(name: "Double shot Espresso", caff: 128),
    drink(name: "Bottled Tea", caff: 19),
    drink(name: "Milk Tea", caff: 130),
    drink(name: "Cappucino", caff: 155),
    drink(name: "Coke", caff: 34),
    drink(name: "Bottled Tea", caff: 19),
    drink(name: "Diet Coke", caff: 46),
    drink(name: "Diet Pepsi", caff: 35),
    drink(name: "Dr Pepper", caff: 41),
    drink(name: "Monster Energy", caff: 160),
    drink(name: "Mountain Dew", caff: 54),
    drink(name: "Red Bull Energy", caff: 80),
    drink(name: "Hot Chocolate", caff: 4.96),
    drink(name: "Custom", caff: 0),

]
