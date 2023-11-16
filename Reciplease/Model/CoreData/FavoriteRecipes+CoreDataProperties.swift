//
//  FavoriteRecipes+CoreDataProperties.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 16/11/2023.
//
//

import Foundation
import CoreData


extension FavoriteRecipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteRecipes> {
        return NSFetchRequest<FavoriteRecipes>(entityName: "FavoriteRecipes")
    }

    @NSManaged public var image: String?
    @NSManaged public var ingredientLines: NSObject?
    @NSManaged public var ingredients: NSObject?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var label: String?
    @NSManaged public var totalTime: Int32
    @NSManaged public var url: String?
    @NSManaged public var yield: Int16

}

extension FavoriteRecipes : Identifiable {

}
