//
//  RecipeCellView.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 17/10/2023.
//

import Foundation
import UIKit

class RecipeCellView: UITableViewCell {
    
    // MARK: View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    func configure(withRecipe recipe: Recipe) {
        _recipeImageView.image = UIImage(named: "recipe_default_background")
        if let url = recipe.image {
            _recipeImageView.dowloadFrom(url)
        }
        _recipeIngredientsLabel.text = recipe.ingredients.compactMap({$0.food}).joined(separator: ", ")
        _recipeIngredientsLabel.accessibilityLabel = _recipeIngredientsLabel.text
        _recipeTitleLabel.text = recipe.label
        _recipeTitleLabel.accessibilityLabel = _recipeTitleLabel.text
        _recipeLikesLabel.text = "\(recipe.yield)"
        _recipeLikesLabel.accessibilityLabel = "\(recipe.yield) likes"
        _recipeTimeLabel.text = "\(recipe.totalTime)"
        _recipeTimeLabel.accessibilityLabel = "\(recipe.totalTime) to prepare this recipe"
    }
    
    
    @IBOutlet private weak var _recipeImageView: UIImageView!
    @IBOutlet private weak var _recipeTitleLabel: UILabel!
    @IBOutlet private weak var _recipeIngredientsLabel: UILabel!
    @IBOutlet private weak var _recipeLikesLabel: UILabel!
    @IBOutlet private weak var _recipeTimeLabel: UILabel!
}
