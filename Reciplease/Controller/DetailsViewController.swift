//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 19/10/2023.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!

    @IBOutlet weak var likesStackView: UIStackView!
    @IBOutlet weak var timeStackView: UIStackView!
    
    
    // MARK: Properties
    var recipeManager = RecipeManager()
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _delegateSetup()
        _dataSourceSetup()
        _prepareView()
        _prepareAccessibility()
    }
    
    @IBAction func favoriteButtonTouched(_ sender: Any) {
        guard let _ = recipeManager.selectedRecipe else { return }
        _updateDatabase()
        recipeManager.selectedRecipe!.favorite!.toggle()
        _updateFavoriteButtonColor()
    }
    
    @IBAction func getDirectionButtonTouched(_ sender: Any) {
        if let url = recipeManager.selectedRecipe?.url {
            UIApplication.shared.open(url)
        }
    }
    
    private func _prepareView() {
        guard let recipe = recipeManager.selectedRecipe else { return }
        recipeImage.image = UIImage(named: "recipe_default_background")
        if let url = recipe.image {
            recipeImage.dowloadFrom(url)
        }
        recipeTitleLabel.text = recipe.label
        likesLabel.text = "\(recipe.yield)"
        recipeImage.addBottomBackgroundGradient()
        
        if let formattedTime  = recipe.totalTime.formatToStringTime {
            timeLabel.text = formattedTime
        } 
        
        if recipe.url == nil {
            getDirectionButton.isEnabled = false
        }
        
        _updateFavoriteButtonColor()
    }
    
    private func _prepareAccessibility() {
        likesLabel.accessibilityLabel = "\(recipeManager.selectedRecipe?.yield ?? 0) likes"
        timeLabel.accessibilityLabel = recipeManager.selectedRecipe?.totalTime.formatToStringTimeAccessibilityLabel
        recipeTitleLabel.accessibilityLabel = "Recipe Title: \(recipeManager.selectedRecipe?.label ?? "")"
        ingredientTableView.accessibilityLabel = "Ingredient List"
        getDirectionButton.accessibilityLabel = "Get Directions Button"
        getDirectionButton.accessibilityHint = "Go to the recipe website to get the directions"
    }
    
    /// Update favorite button tint color
    private func _updateFavoriteButtonColor() {
        if recipeManager.selectedRecipeIsFavorite {
            favoriteButton.tintColor = UIColor(named: "Button Background")
            favoriteButton.accessibilityLabel = "Remove from Favorites"
            favoriteButton.accessibilityHint = "Remove this recipe from your favorites"
        } else {
            favoriteButton.tintColor = UIColor(named: "ClearButtonBackground")
            favoriteButton.accessibilityLabel = "Add to Favorites"
            favoriteButton.accessibilityHint = "Add this recipe to your favorites"
        }
    }
    
    /// Update the database (save or delete the record)
    private func _updateDatabase() {
        if recipeManager.selectedRecipeIsFavorite {
            if let error = recipeManager.deleteRecordOnDatabase() {
                 AlertManager.shared.sendAlert(error, on: self)
            }
        } else {
            if let error = recipeManager.saveRecordOnDatabase() {
                AlertManager.shared.sendAlert(error, on: self)
            }
        }
    }
}

extension DetailsViewController: UITableViewDelegate {
    // MARK: Private method
    private func _delegateSetup() {
        ingredientTableView.delegate = self
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeManager.selectedRecipe?.ingredientLines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientCellView, let selectedRecipe = recipeManager.selectedRecipe else {
            return UITableViewCell()
        }
        
        ingredientCell.configure(withIngredient: selectedRecipe.ingredientLines[indexPath.row])
        return ingredientCell
    }
    
    // MARK: Private method
    /// Setup the source of data
    private func _dataSourceSetup() {
        ingredientTableView.dataSource = self
    }
}
