//
//  DrinkFactoryClass.swift
//  CoffeeMachine
//
//  Created by Anna Oksanichenko on 12.10.2020.
//  Copyright © 2020 Anna Oksanichenko. All rights reserved.
//

import Foundation

//у напитка есть имя и компоненты
class MyDrink {
    let name: String
    var components = [ComponentContain]()
    init(name: String, components : [ComponentContain]) {
        self.name = name
        self.components = components
    }
}

class DrinkFactory {
    class func getAmericano() -> MyDrink {
        let americano = MyDrink(name: "americano", components: [ComponentContain(type: .beans, volume: 20), ComponentContain(type: .water, volume: 25)])
        return americano
    }
    
    class func getLatte() -> MyDrink {
        let latte = MyDrink(name: "latte", components: [ComponentContain(type: .beans, volume: 30), ComponentContain(type: .milk, volume: 45)])
        return latte
    }
    
    class func getCapuchino() -> MyDrink {
        let capuchino = MyDrink(name: "capuchino", components: [ComponentContain(type: .beans, volume: 25), ComponentContain(type: .milk, volume: 25), ComponentContain(type: .water, volume: 20)])
        return capuchino
    }
    
    class func getFlatWhite() -> MyDrink {
        let flatWhite = MyDrink(name: "Flat White", components: [ComponentContain(type: .beans, volume: 25), ComponentContain(type: .milk, volume: 15), ComponentContain(type: .water, volume: 10)])
        return flatWhite
    }
    
    class func getWarmMilk() -> MyDrink {
        let warmMilk = MyDrink(name: "Warm Milk", components: [ComponentContain(type: .beans, volume: 0), ComponentContain(type: .milk, volume: 50), ComponentContain(type: .water, volume: 0)])
        return warmMilk
    }
}
