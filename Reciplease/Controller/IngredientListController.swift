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
        
        // TODO: CREATE AlertHelper
        guard !_ingredients.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "You must add at least one ingredient", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }
        
        loadingView.isHidden = false

        // Timeout for the loadingView while the API process isn't created
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.loadingView.isHidden = true
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
    
    // MARK: Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the reusable Cell
        guard let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientCellView else {
            return UITableViewCell()
        }
        
        ingredientCell.configure(withIngredient: _ingredients[indexPath.row])
        
        return ingredientCell
    }
    
    // MARK: Private Methods
    /// Setup the source of the data
    private func _dataSourceSetup() {
        ingredientTableView.dataSource = self
    }
}
