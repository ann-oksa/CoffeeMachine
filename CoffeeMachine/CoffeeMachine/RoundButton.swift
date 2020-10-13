//
//  RoundButtonClass.swift
//  CoffeeMachine
//
//  Created by Anna Oksanichenko on 08.10.2020.
//  Copyright © 2020 Anna Oksanichenko. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton : UIButton{

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }

    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }

    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
}
