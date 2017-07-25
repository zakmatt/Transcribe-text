//
//  CircleButton.swift
//  Scribe
//
//  Created by Admin on 24/07/2017.
//  Copyright © 2017 Mattowy. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }

}
