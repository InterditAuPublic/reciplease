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

    // MARK: Public
    // MARK: Outlet

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
    // MARK: Private method
    /// Setup the delegate
    private func _delegateSetup() {
        recipeTableView.delegate = self
    }
}

// MARK: Data source extension
extension RecipeListController: UITableViewDataSource {
    // MARK: Public method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    /// Configure each cells of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell to reuse
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCellView else {
            return UITableViewCell()
        }
        return recipeCell
    }
    
    // MARK: Private method
    /// Setup the source of data
    private func _dataSourceSetup() {
        recipeTableView.dataSource = self
    }
}
