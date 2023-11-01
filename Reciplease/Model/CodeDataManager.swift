//
//  CodeDataManager.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 01/11/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: Initialization
    init() {}
    
    // MARK: Properties
    var favorites: [Recipe] = []
    
    // MARK: Methods
    ///add recipe to the database
    func addRecipe(_ recipe: Recipe) -> Bool {
        
        let recipeToSave = FavoriteRecipes(context: _mainContext)
        recipeToSave.label = recipe.label
        if let url = recipe.image {
            recipeToSave.image = url.absoluteString
        }
        recipeToSave.ingredientLines = recipe.ingredientLines as NSObject
        recipeToSave.totalTime = Int32(recipe.totalTime)
        recipeToSave.yield = Int16(recipe.yield)
        recipeToSave.ingredients = recipe.ingredients.compactMap {$0.food} as NSObject
        recipeToSave.isFavorite = true
        recipeToSave.url = recipe.url?.absoluteString
        
        return _coreDataStack.saveContext()
    }
    
    /// Call the CoreData stack to save the context
    func saveContext() {
        _ = _coreDataStack.saveContext()
    }
    
    // MARK: Private
    // MARK: Properties
    private let _coreDataStack = CoreDataStack()
    private var _mainContext: NSManagedObjectContext {
        return CoreDataStack.mainContext
    }
}

