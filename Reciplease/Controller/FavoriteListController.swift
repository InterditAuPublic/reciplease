//
//  FavoriteListController.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 13/10/2023.
//

import Foundation
import UIKit

class FavoriteListController: UIViewController {
    
    // MARK: Properties
//    private var favoriteRecipes : [String] = ["yes!"]
    private var _favoriteRecipes : [String] = []
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
        performSegue(withIdentifier: _segueToDetails, sender: self)
    }
    
    /// Retrieve favorites recipes
    private func _downloadRecipes() {
        
        if _favoriteRecipes.count == 0 {
            print("no recipe")
            noFavoriteView.isHidden = false
        } else {
            print("recipe!")
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
        12 //TODO: replace by the number of favorites Stored in CoreData
    }
    
    /// Configure each cells of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// Get cell that will be reused
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCellView else {
            return UITableViewCell()
        }
        return recipeCell
    }
    
    /// Setup the source of the data
    private func _dataSourceSetup() {
        favoriteRecipeTableView.dataSource = self
    }
}
