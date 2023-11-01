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
    private let _recipeManager = RecipeManager()

    @IBOutlet weak var recipeTableView: UITableView!
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _delegateSetup()
        _dataSourceSetup()
    }
    
    // MARK: Properties
    private let _segueToDetails = "recipeListToDetailSegue"
    
    // MARK: Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        performSegue(withIdentifier: _segueToDetails, sender: self)
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
//        _recipeManager.downloadedRecipes.count
        12
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
        recipeTableView.dataSource = self
    }
}
