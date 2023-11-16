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
}
