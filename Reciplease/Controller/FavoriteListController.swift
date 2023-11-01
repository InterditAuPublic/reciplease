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
    private var favoriteRecipes : [String] = []
    
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
    
    // MARK: Method
    /// Retrieve favorites recipes
    private func _downloadRecipes() {
        
        if favoriteRecipes.count == 0 {
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
