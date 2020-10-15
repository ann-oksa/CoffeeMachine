//
//  GlobalClass.swift
//  CoffeeMachine
//
//  Created by Anna Oksanichenko on 05.10.2020.
//  Copyright © 2020 Anna Oksanichenko. All rights reserved.
//

import Foundation



class AppState {
    static let shared = AppState()
    var coffeeMachine : CoffeeMachine
    
    init() {
        coffeeMachine = CoffeeMachine()
    }
}

let myMachine = AppState.shared.coffeeMachine
