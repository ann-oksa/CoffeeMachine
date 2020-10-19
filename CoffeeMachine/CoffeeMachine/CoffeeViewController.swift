//
//  SecondViewController.swift
//  CoffeeMachine
//
//  Created by Anna Oksanichenko on 08.10.2020.
//  Copyright © 2020 Anna Oksanichenko. All rights reserved.
//

import UIKit

class CoffeeViewController: UIViewController {
 
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var waterVolumeSlider: UISlider!
    @IBOutlet weak var milkVolumeSlider: UISlider!
    @IBOutlet weak var beansVolumeSlider: UISlider!
    @IBOutlet weak var trashVolumeSlider: UISlider!
    
    @IBOutlet weak var addWater: UIButton!
    @IBOutlet weak var addMilk: UIButton!
    @IBOutlet weak var addBeans: UIButton!
    @IBOutlet weak var clearTrash: UIButton!
    
    @IBOutlet weak var makeAmericano: UIButton!
    @IBOutlet weak var makeCapuchino: UIButton!
    @IBOutlet weak var makeLatte: UIButton!
    @IBOutlet weak var makeFlatWhite: UIButton!
    @IBOutlet weak var makeWarmMilk: UIButton!
    
    
    let machine = CoffeeMachine()
    let cm = AppState.shared.coffeeMachine    
    let americano = DrinkFactory.getAmericano()
    let capuchino = DrinkFactory.getCapuchino()
    let latte = DrinkFactory.getLatte()
    let flatWhite = DrinkFactory.getFlatWhite()
    let warmMilk = DrinkFactory.getWarmMilk()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMinMaxValueOfComponent(.water, for: waterVolumeSlider)
        setupMinMaxValueOfComponent(.milk, for: milkVolumeSlider)
        setupMinMaxValueOfComponent(.beans, for: beansVolumeSlider)
        trashVolumeSlider.maximumValue = Float(cm.trashCapacity)
        
        reloadVolumeSliders()
        
    
        cm.delegate = self
    }
    
    @IBAction func addWaterButton(_ sender: UIButton) {
        addComponent(type: .water)
    }
    
    @IBAction func addMilkButton(_ sender: UIButton) {
        addComponent(type: .milk)
    }
    
    @IBAction func addBeansButton(_ sender: UIButton) {
        addComponent(type: .beans)
    }
    
    @IBAction func cleanTrashButton(_ sender: UIButton) {
        _ = cm.refreshTrash()
        label.text = cm.message
        reloadVolumeSliders()
        makeButtonEnabled()
    }
    
    @IBAction func americanoButton(_ sender: UIButton) {
        makeDrink(americano, from: sender)
    }
    
    @IBAction func capuchinoButton(_ sender: UIButton) {
        makeDrink(capuchino, from: sender)
    }
    
    @IBAction func latteButton(_ sender: UIButton) {
        makeDrink(latte, from: sender)
    }
    
    @IBAction func flatWhiteButton(_ sender: UIButton) {
        makeDrink(flatWhite, from: sender)
    }
    
    
    
    @IBAction func warmMilkButton(_ sender: UIButton) {
        makeDrink(warmMilk, from: sender)
    }
    
}

private extension CoffeeViewController {
    func setupMinMaxValueOfComponent(_ type: MyCoffeeComponentType, for slider: UISlider) {
        slider.maximumValue = Float(cm.valueForAdd)
        slider.minimumValue = Float(cm.getComponentByType(type)?.minvol ?? 0)
    }
    
    func updateValueOfComponent(_ type: MyCoffeeComponentType, for slider: UISlider) {
        UIView.animate(withDuration: 0.4) {
            slider.setValue(Float(self.cm.getComponentByType(type)?.volume ?? 0), animated: true)
        }
    }
    
    func reloadVolumeSliders() {
        updateValueOfComponent(.water, for: waterVolumeSlider)
        updateValueOfComponent(.milk, for: milkVolumeSlider)
        updateValueOfComponent(.beans, for: beansVolumeSlider)
        trashVolumeSlider.value = Float(cm.trash)
    }
    
    func makeButtonEnabled() {
        let makeDrinkButtons : [UIButton] = [makeAmericano, makeCapuchino, makeLatte, makeFlatWhite, makeWarmMilk]
//        for drink in makeDrinkButtons {
//            if drink.isEnabled == false{
//                drink.isEnabled = true
//            }
//        }
        for eachbutton in makeDrinkButtons {
           eachbutton.isEnabled = cm.isAvailable
        }
    }
    
    func addComponent(type: MyCoffeeComponentType) {
        _ = cm.addSomeComponent(type)
        label.text = cm.message
        reloadVolumeSliders()
        makeButtonEnabled()
    }
    
    func makeAlert(title: String) {
        let alert = UIAlertController(title: title, message: "Click YES to take your drink", preferredStyle:  .alert)
        let yesButton = UIAlertAction(title: "YES", style: .default, handler: nil)
        alert.addAction(yesButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeDrink(_ drink: MyDrink, from button: UIButton) {
//        if cm.canMakeADrink(drink) {
//            if cm.isAvailable == false{
//                button.isEnabled = false
//            }
//
//
//
//            _ = cm.letsMakeDrink(drink)
//            label.text = cm.message
//            button.isEnabled = true
//        } else {
//            label.text = cm.message
//            button.isEnabled = false
//        }
//        reloadVolumeSliders()
        
        
        if cm.canMakeADrink(drink){
            button.isEnabled = true
        _ = cm.letsMakeDrink(drink)
            button.isEnabled = cm.isAvailable
        label.text = cm.message
            let makeDrinkButtons : [UIButton] = [makeAmericano, makeCapuchino, makeLatte, makeFlatWhite, makeWarmMilk]
            for drink in makeDrinkButtons {
                drink.isEnabled = true
            }
        } else {
            label.text = cm.message
            button.isEnabled = false
        }
        reloadVolumeSliders()
        
    }
    
}
extension CoffeeViewController : CoffeeMachineDelegate {
    func coffeeMachineAvailable() {
        print("coffeeMachineAvailable")
        makeButtonEnabled()
    }
    
    
}
