//
//  IngredientCellView.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 12/10/2023.
//

import Foundation


import UIKit

class IngredientCellView: UITableViewCell {
    
    // MARK: View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    func configure(withIngredient ingredient: String) {
        _ingredientLabel.text = "- \(ingredient.trimmingCharacters(in: .whitespacesAndNewlines))"
    }
    
    // MARK: Outlets
    @IBOutlet private weak var _ingredientLabel: UILabel!
}
