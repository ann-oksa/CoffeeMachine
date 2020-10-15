//
//  SecondViewController.swift
//  CoffeeMachine
//
//  Created by Anna Oksanichenko on 08.10.2020.
//  Copyright © 2020 Anna Oksanichenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
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
    
    @IBOutlet weak var cnstrMakeAmericanoWight: NSLayoutConstraint!
    
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
        
        updateAllValues()
        cnstrMakeAmericanoWight.constant = 40
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
        updateAllValues()
        enabled()
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

private extension ViewController {
    func setupMinMaxValueOfComponent(_ type: MyCoffeeComponentType, for slider: UISlider) {
        slider.maximumValue = Float(cm.valueForAdd)
        slider.minimumValue = Float(cm.getComponentByType(type)!.minvol)
    }
    
    func updateValueOfComponent(_ type: MyCoffeeComponentType, for slider: UISlider) {
        UIView.animate(withDuration: 0.4) {
            slider.setValue(Float(self.cm.getComponentByType(type)!.volume), animated: true)
        }
    }
    
    func updateAllValues() {
        updateValueOfComponent(.water, for: waterVolumeSlider)
        updateValueOfComponent(.milk, for: milkVolumeSlider)
        updateValueOfComponent(.beans, for: beansVolumeSlider)
        trashVolumeSlider.value = Float(cm.trash)
    }
    
    func enabled() {
        let drinks = [makeAmericano, makeCapuchino, makeLatte, makeFlatWhite, makeWarmMilk]
        for drink in drinks {
            if drink?.isEnabled == false{
                drink?.isEnabled = true
            }
        }
    }
    
    func addComponent(type: MyCoffeeComponentType) {
        _ = cm.addSomeComponent(type)
        label.text = cm.message
        updateAllValues()
        enabled()
    }
    
    func makeAlert(title: String) {
        let alert = UIAlertController(title: title, message: "Click YES to take your drink", preferredStyle:  .alert)
        let yesButton = UIAlertAction(title: "YES", style: .default, handler: nil)
        alert.addAction(yesButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeDrink(_ drink: MyDrink, from button: UIButton) {
        if cm.canMakeADrink(drink) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                button.isEnabled = true
            }
            button.isEnabled = false
            _ = cm.letsMakeDrink(drink)
            label.text = cm.message
        } else {
            label.text = cm.message
            button.isEnabled = false
        }
        updateAllValues()
    }
    
}
