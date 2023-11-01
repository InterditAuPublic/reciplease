//
//  RecipeManager.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 23/10/2023.
//

import Foundation
import Alamofire

class RecipeManager {
    
    // MARK: Public
    var downloadedRecipes: [Recipe] { _downloadedRecipes }
    
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
    
    
    
    init(networkManager: NetworkManager = NetworkManager()) {
        _networkManager = networkManager
    }


    // MARK: Private
    private let _url = "https://api.edamam.com/api/recipes/v2?"
    private let _appKey = "2f8f6c08ae95647c2434085cb6eb890d"
    private let _appId = "b8ff4009"
    private var _downloadedRecipes: [Recipe] = []
    private var _networkManager: NetworkManager
    
    private func _createRecipeSearchURL(withIngredients ingredients: [String]) -> URL? {
        let parameters = ["type": "public", "q": ingredients.joined(separator: ","), "app_id": _appId, "app_key": _appKey]
        var components = URLComponents(string: _url)
        components?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return components?.url
    }
}
