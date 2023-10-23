//
//  Recipe.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 23/10/2023.
//

import Foundation

struct RecipesHits: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let label: String
    let url: URL?
    let image: URL?
    let yield: Int
    let ingredientLines: [String]
    let ingredients: [Ingredients]
    let totalTime: Int
    var favorite: Bool?
}

struct Ingredients: Codable {
    let food: String
}
