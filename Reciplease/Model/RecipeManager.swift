//
//  RecipeManager.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 23/10/2023.
//

import Foundation
import Alamofire
import CoreData

class RecipeManager {
    
    // MARK: Public
    var downloadedRecipes: [Recipe] { _downloadedRecipes }
    
    var selectedRecipe: Recipe? {
        didSet {
            if let recipe = selectedRecipe, _coreDataManager.checkIfRecipeIsFavorite(recipe) {
                selectedRecipe!.favorite = true
            }
        }
    }
    
    var favoriteRecipes: [Recipe] {
        
        return _coreDataManager.favorites
    }
    
    var selectedRecipeIsFavorite: Bool {
        guard let recipe = selectedRecipe else { return false }
        return _coreDataManager.checkIfRecipeIsFavorite(recipe)
    }
    
    func getRecipes(forIngredients ingredients: [String], completionHandler: @escaping ((Bool) -> Void)) {
           guard let url = _createRecipeSearchURL(withIngredients: ingredients) else {
               completionHandler(false)
               return
           }

           _networkManager.request(url: url) { [weak self] response in
               guard let self = self else { return }
               var requestSuccess = false
               switch response.result {
               case .success:
                   if let hits = response.value  {
                       self._downloadedRecipes = hits.hits.map{$0.recipe}

                       requestSuccess = true
                   }
               case .failure(let error):
                   print(error)
               }
               completionHandler(requestSuccess)
           }
       }
    
    /// Save the record on the database
    func saveRecordOnDatabase() -> AlertManager.AlertReson? {
        guard let recipe = selectedRecipe else { return .cannotSaveRecipe }
        
        var alert: AlertManager.AlertReson? = nil
        
        if _coreDataManager.addRecipe(recipe) {
            selectedRecipe!.favorite = true
        } else {
            alert = .cannotSaveRecipe
        }
        
        return alert
    }
    
    
    /// Delete the record from the database
    func deleteRecordOnDatabase() -> AlertManager.AlertReson? {
        guard let selectedRecipe = selectedRecipe else { return .cannotDeleteRecipe }

        return _coreDataManager.deleteRecipe(selectedRecipe) ?  nil : .cannotDeleteRecipe
    }
    
    func deleteAllRecordOnDatabase() -> AlertManager.AlertReson? {
        return _coreDataManager.deleteAllRecipe() ? nil : .cannotDeleteRecipe
    }
    /// Reload the favorite list
    func reloadFavoriteList() {
        _coreDataManager.reloadFavoriteList()
    }
    
    init(networkManager: NetworkManager = NetworkManager()) {
        _networkManager = networkManager
    }


    // MARK: Private
    private let _url = "https://api.edamam.com/api/recipes/v2?"
    private let _appKey = "2f8f6c08ae95647c2434085cb6eb890d"
    private let _appId = "b8ff4009"
    private var _downloadedRecipes: [Recipe] = []
    private var _networkManager: NetworkManager
    private let _coreDataManager = CoreDataManager()
    
    private func _createRecipeSearchURL(withIngredients ingredients: [String]) -> URL? {
        let parameters = ["type": "public", "q": ingredients.joined(separator: ","), "app_id": _appId, "app_key": _appKey]
        var components = URLComponents(string: _url)
        components?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return components?.url
    }
}
