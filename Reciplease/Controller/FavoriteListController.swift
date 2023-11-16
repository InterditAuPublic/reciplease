//
//  FavoriteListController.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 13/10/2023.
//

import Foundation
import UIKit
import CoreData

class FavoriteListController: UIViewController {
    
    // MARK: Properties
    private let _segueToDetails = "favoriteListToDetailSegue"
    private let _recipeManager = RecipeManager()
    
    // MARK: Outlet
    @IBOutlet weak var noFavoriteView: UIView!
    @IBOutlet weak var favoriteRecipeTableView: UITableView!
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _delegateSetup()
        _dataSourceSetup()
        _downloadRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _downloadRecipes()
    }

    
    // MARK: Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == _segueToDetails, let detailViewVC = segue.destination as? DetailsViewController else { return }
        detailViewVC.recipeManager = _recipeManager
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _recipeManager.selectedRecipe = _recipeManager.favoriteRecipes[indexPath.row]
        performSegue(withIdentifier: _segueToDetails, sender: self)
    }
    
    /// Retrieve favorites recipes
    /// Get recipes from CoreData
    private func _downloadRecipes() {
        _recipeManager.reloadFavoriteList()
        
        if _recipeManager.favoriteRecipes.count == 0 {
            noFavoriteView.isHidden = false
        } else {
            noFavoriteView.isHidden = true
        }
        favoriteRecipeTableView.reloadData()
    }
}


// MARK: Delegate extension
extension FavoriteListController: UITableViewDelegate {
    /// Setup the delegate
    private func _delegateSetup() {
        favoriteRecipeTableView.delegate = self
    }
}

// MARK: Data source extension
extension FavoriteListController: UITableViewDataSource {
    /// Setup the number of row in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _recipeManager.favoriteRecipes.count
    }
    
    /// Configure each cells of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// Get cell that will be reused
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCellView else {
            return UITableViewCell()
        }
        
        recipeCell.configure(withRecipe: _recipeManager.favoriteRecipes[indexPath.row])
        
        return recipeCell
    }
    
    /// Setup the source of the data
    private func _dataSourceSetup() {
        favoriteRecipeTableView.dataSource = self
    }
}
