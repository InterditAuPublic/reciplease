//
//  UIImageView.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 15/11/2023.
//

import Foundation
import UIKit

extension UIImageView {
    /// Download image from URL
    func dowloadFrom(_ url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = nil
                }
            }
        }
    }
    
    func addBottomBlackGradient() {
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height + 10)
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.6, 1.0]
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addBottomBackgroundGradient() {
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height + 10)
        gradient.colors = [UIColor.clear.cgColor, UIColor.background.cgColor]
        gradient.locations = [0.0, 1.0]
        layer.addSublayer(gradient)
    }
}
