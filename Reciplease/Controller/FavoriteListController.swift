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
//        favoriteRecipeTableView.reloadData()
    }
}

