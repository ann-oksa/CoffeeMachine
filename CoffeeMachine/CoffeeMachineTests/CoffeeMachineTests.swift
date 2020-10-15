//
//  CoffeeMachineTests.swift
//  CoffeeMachineTests
//
//  Created by Anna Oksanichenko on 30.09.2020.
//  Copyright © 2020 Anna Oksanichenko. All rights reserved.
//

import XCTest

@testable import CoffeeMachine

class CoffeeMachineTests: XCTestCase {
    let machine = CoffeeMachine()
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTrashCapacityCanBeSetAfterCMCreated() throws {
        machine.trash = 10000
        XCTAssertEqual(machine.trash, 10000, "trash is not equal to 10000")
    }
    
    func testRefreshTrash() throws {
        machine.trash = 10
        machine.trash = machine.refreshTrash()
        XCTAssertEqual(machine.trash, 0, "trash is not equal to 0")
    }
    
    func testAddSomeComponent() throws {
        machine.addSomeComponent(.beans)
        let beansMachine = machine.getComponentByType(.beans)
        XCTAssertEqual(beansMachine?.volume, 100, "havent any beans")
    }
    
    func testCanMakeADrinkWhenMachineComponentEnough() throws {
        let amer = MyDrink(name: "americano", components: [ComponentContain(type: .beans, volume: 30), ComponentContain(type: .water, volume: 50)])
        let result =  machine.canMakeADrink(amer)
        XCTAssertEqual(result, true, "Component in machine less then drink needed")
    }
    
    func testCanMakeDrinkWhenVolumeOfDrinkComponentBiggerThenComponentInMachine() throws {
        let amer = MyDrink(name: "americano", components: [ComponentContain(type: .beans, volume: 30), ComponentContain(type: .water, volume: 150)])
        let result =  machine.canMakeADrink(amer)
        XCTAssertEqual(result, false, "components must be not enough for preparing drink")
    }
    
    func testCanMakeADrinkWhenTrashIsFull() throws {
        machine.trash = 50
        let latte  = MyDrink(name: "latte", components: [ComponentContain(type: .beans, volume: 30)])
        let result = machine.canMakeADrink(latte)
        XCTAssertEqual(result, false, "trash must be full")
    }
    
    func testEnoughComponentOfType() throws {
        let result = machine.hasEnoughComponentOfType(.beans)
        XCTAssertEqual(result, true, "not enough this component")
    }
    
    func testNotEnoughComponentOfType() throws {
        let latte = MyDrink(name: "latte", components: [ComponentContain(type: .beans, volume: 100), ComponentContain(type: .milk, volume: 45)])
        machine.letsMakeDrink(latte)
       let result = machine.hasEnoughComponentOfType(.beans)
        XCTAssertEqual(result, false, "must be not enough")
    }

    func testLetsMakeADrink() throws {
        let beans = ComponentContain(type: .beans, volume: 30)
        let latte  = MyDrink(name: "latte", components: [beans, ComponentContain(type: .milk, volume: 45)])
        let result =  machine.letsMakeDrink(latte)
        XCTAssertEqual(result, true, "cant make a drink, there is some issue")
    }
    
    func testGetComponentByType() throws {
        let result : ComponentContain? = machine.getComponentByType(.beans)
        let component : ComponentContain? = ComponentContain(type: .beans, volume: 100)
        XCTAssertEqual(result?.type, .beans, "wrong type")
    }
    
    func testDrinkFactoryGetAmericano() throws {
        let result = DrinkFactory.getAmericano()
        let americano = MyDrink(name: "americano", components: [ComponentContain(type: .beans, volume: 20), ComponentContain(type: .water, volume: 25)])
        XCTAssertEqual(result.components, americano.components, "wrong components")
    }
    
    func testDrinkFactoryGetCapuchino() throws {
        let result = DrinkFactory.getCapuchino()
        let capuchino = MyDrink(name: "capuchino", components: [ComponentContain(type: .beans, volume: 25), ComponentContain(type: .milk, volume: 25), ComponentContain(type: .water, volume: 20)])
        XCTAssertEqual(result.components, capuchino.components, "wrong components")
    }
    
    
}
