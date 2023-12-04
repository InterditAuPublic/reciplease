//
//  CustomButton.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 03/12/2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {

    // draw
    override func draw(_ rect: CGRect) {
        _addBorderAndCornerRadius()
    }
    
    // add with border & corner radius to view 
    private func _addBorderAndCornerRadius() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
    }
}
