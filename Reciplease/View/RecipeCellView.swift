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
    func configure(withRecipe recipe: [String : Any]) {
        _recipeTitleLabel.text = recipe["title"] as? String
        _recipeIngredientsLabel.text = recipe["ingredientLines"] as? String
        _recipeLikesLabel.text = recipe["yield"] as? String
        _recipeTimeLabel.text = recipe["totalTime"] as? String
        if let image = recipe["image"] as? String {
            _recipeImageView.image = UIImage(systemName: "cup.and.saucer");
        }
    }
    
    
    @IBOutlet private weak var _recipeImageView: UIImageView!
    @IBOutlet private weak var _recipeTitleLabel: UILabel!
    @IBOutlet private weak var _recipeIngredientsLabel: UILabel!
    @IBOutlet private weak var _recipeLikesLabel: UILabel!
    @IBOutlet private weak var _recipeTimeLabel: UILabel!
}
