//
//  RecipeListController.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 17/10/2023.
//

import Foundation

import Foundation
import UIKit

class RecipeListController: UIViewController {

    // MARK: Properties
    var recipeManager = RecipeManager()
    private let _segueToDetails = "recipeListToDetailSegue"
    private var _selectedRecipe: Recipe?
    
    // MARK: Outlets
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var noRecipeFoundView: UIView!
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _delegateSetup()
        _dataSourceSetup()
        _checkIfRecipeToDisplay()
    }

    // MARK: Methods
    /// Prepare the segue to pass data to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == _segueToDetails, let detailViewVC = segue.destination as? DetailsViewController else { return }
        detailViewVC.recipeManager = recipeManager
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeManager.selectedRecipe = recipeManager.downloadedRecipes[indexPath.row]
        performSegue(withIdentifier: _segueToDetails, sender: self)
    }
    
    /// Check if downloadedRecipes contains recipe, if not display noRecipeFoundView
    private func _checkIfRecipeToDisplay() {
        if recipeManager.downloadedRecipes.count == 0 {
            noRecipeFoundView.isHidden = false
        }
    }
}


// MARK: Delegate extension
extension RecipeListController: UITableViewDelegate {
    /// Setup the delegate
    private func _delegateSetup() {
        recipeTableView.delegate = self
    }
}

// MARK: Data source extension
extension RecipeListController: UITableViewDataSource {
    /// Setup the number of row in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeManager.downloadedRecipes.count
    }
    
    /// Configure each cells of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// Get cell that will be reused
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCellView else {
            return UITableViewCell()
        }
        
        recipeCell.configure(withRecipe: recipeManager.downloadedRecipes[indexPath.row])
        
        return recipeCell
    }
    
    /// Setup the source of the data
    private func _dataSourceSetup() {
        recipeTableView.dataSource = self
    }
}
