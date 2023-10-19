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
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _delegateSetup()
        _dataSourceSetup()
        _prepareView()
    }
    
    private func _prepareView() {
        
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
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
    }
    
    // MARK: Private method
    private func _dataSourceSetup() {
        ingredientTableView.dataSource = self
    }
}
