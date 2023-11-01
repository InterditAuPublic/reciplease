//
//  IngredientListController.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 12/10/2023.
//

import Foundation
import UIKit

class IngredientListController: UIViewController {
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _dataSourceSetup()
    }
    
    // MARK: Properties
    private var _ingredients: [String] = []
    private let _recipeManager = RecipeManager()
    private let _searchToRecipeListSegue = "searchToRecipeListSegue"
    
    // MARK: Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: Actions
    @IBAction func addIngredientButtonTouched() {
        _addIngredient()
    }
    
    @IBAction func clearListButtonTouched() {
        _ingredients = []
        ingredientTableView.reloadData()
    }
    
    @IBAction func searchRecipeButtonTouched() {
        /// Check if there is at least one ingredient in the list
        guard !_ingredients.isEmpty else {
            // TODO: CREATE AlertHelper
            let alert = UIAlertController(title: "Error", message: "You must add at least one ingredient", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }
        
        loadingView.isHidden = false

        _recipeManager.getRecipes(forIngredients: _ingredients) { [weak self] isASuccess in
            guard let self = self else { return }
            self.loadingView.isHidden = true
            if isASuccess {
                self.performSegue(withIdentifier: self._searchToRecipeListSegue, sender: self)
            } else {
                // TODO: CREATE AlertHelper
                let alert = UIAlertController(title: "Error", message: "An error occured while loading recipes", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    // MARK: Methods
    private func _addIngredient() {
        self.view.endEditing(true)
        guard let ingredient = ingredientTextField.text, !ingredient.isEmpty, !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            ingredientTextField.text = ""
            return
        } 
        
        _ingredients.append(ingredient)
        ingredientTableView.reloadData()
        ingredientTextField.text = ""
    }
}

// MARK: Data source extension
extension IngredientListController: UITableViewDataSource {
    
    /// Setup the number of row in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _ingredients.count
    }
    
    /// Configure each cells of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientCellView else {
            return UITableViewCell()
        }
        ingredientCell.configure(withIngredient: _ingredients[indexPath.row])
        return ingredientCell
    }

    /// Setup the source of the data
    private func _dataSourceSetup() {
        ingredientTableView.dataSource = self
    }
}
