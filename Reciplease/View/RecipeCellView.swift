//
//  RecipeCellView.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 17/10/2023.
//

import Foundation
import UIKit

class RecipeCellView: UITableViewCell {
    
    
    @IBOutlet private weak var _recipeImageView: UIImageView!
    @IBOutlet private weak var _recipeTitleLabel: UILabel!
    @IBOutlet private weak var _recipeIngredientsLabel: UILabel!
    @IBOutlet private weak var _recipeLikesLabel: UILabel!
    @IBOutlet private weak var _recipeTimeLabel: UILabel!
    
    @IBOutlet weak var _infoStackView: UIStackView!
    @IBOutlet weak var _likesStackView: UIStackView!
    @IBOutlet weak var _timeStackView: UIStackView!
    
    
    // MARK: View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    func configure(withRecipe recipe: Recipe) {
        if let url = recipe.image {
            _recipeImageView.dowloadFrom(url)
        } else {
            _recipeImageView.image = UIImage(named: "recipe_default_background")
        }
        _recipeImageView.addBottomBlackGradient()
        _recipeIngredientsLabel.text = recipe.ingredients.compactMap({$0.food}).joined(separator: ", ")
        _recipeIngredientsLabel.accessibilityLabel = "Ingredients: \(recipe.ingredients.compactMap({$0.food}).joined(separator: ", "))"
        _recipeTitleLabel.text = recipe.label
        _recipeTitleLabel.accessibilityLabel = "Recipe title: \(recipe.label)"
        _recipeLikesLabel.text = "\(recipe.yield)"
        _recipeLikesLabel.accessibilityLabel = "\(recipe.yield) likes"

        if let formattedTime = recipe.totalTime.formatToStringTime {
            _recipeTimeLabel.text = formattedTime
            _recipeTimeLabel.accessibilityLabel = recipe.totalTime.formatToStringTimeAccessibilityLabel
        }
    }
}
