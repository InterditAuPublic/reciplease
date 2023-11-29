//
//  Int.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 16/11/2023.
//

import Foundation

extension Int {
    
    var formatToStringTime: String? {
        guard self > 0 else {
            return nil
        }
        
        let hours = self / 60
        let minutes = self % 60
        
        switch (hours, minutes) {
        case (0, _):
            return String(format: "%dmin", minutes)
        case (_, 0):
            return String(format: "%dh", hours)
        default:
            return String(format: "%dh %dmin", hours, minutes)
        }
    }
    
    var formatToStringTimeAccessibilityLabel: String? {
        guard self > 0 else {
            return nil
        }
        
        let hours = self / 60
        let minutes = self % 60
        
        switch (hours, minutes) {
        case (0, _):
            return String(format: "%d minutes", minutes)
        case (_, 0):
            return String(format: "%d hours", hours)
        default:
            return String(format: "%d hours and %d minutes", hours, minutes)
        }
    }
}
