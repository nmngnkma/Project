//
//  UserRepositories.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import Alamofire

protocol RecipesRepositoryType {
    func takeRandomRecipesData(number: Int, completion: @escaping (BaseResult<RandomRecipes>) -> Void )
    func takeProductData(query: String, number: Int, completion: @escaping (BaseResult<Product>) -> Void)
    func takeProductDetail(productId: Int, completion: @escaping (BaseResult<ProductDetail>) -> Void)
    func getRecipeInfo(recipeId: Int, completion: @escaping (BaseResult<Recipe>) -> Void )
    func getProductInfo(productId: Int, completion: @escaping (BaseResult<Item>) -> Void)
    func searchRecipe(query: String, number: Int, completion: @escaping (BaseResult<SearchResponse>) -> Void)
}

struct Repositories: RecipesRepositoryType {
    
    let api: ApiService
// MARK: - Product in Home Screen
    func takeProductData(query: String, number: Int, completion: @escaping (BaseResult<Product>) -> Void) {
        let input = SearchProductRequest(query: query, number: number)
        api.request(input: input) { (object: Product?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
// MARK: - Recipe in Home Screen
    func takeRandomRecipesData(number: Int, completion: @escaping (BaseResult<RandomRecipes>) -> Void) {
        let input = SearchRecipesRequest(number: number)
        api.request(input: input) { (object: RandomRecipes?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
// MARK: - Product Detail Screen
    func takeProductDetail(productId: Int, completion: @escaping (BaseResult<ProductDetail>) -> Void) {
        let input = SearchProductDetail(productId: productId)
        api.request(input: input) { (object: ProductDetail?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
// MARK: - Use recipeID to get info of Recipe SearchResult
    func getRecipeInfo(recipeId: Int, completion: @escaping (BaseResult<Recipe>) -> Void) {
        let input = GetRecipeInfo(recipeId: recipeId)
        api.request(input: input) { (object: Recipe?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
// MARK: - Use productId to get info of Product SearchResult
    func getProductInfo(productId: Int, completion: @escaping (BaseResult<Item>) -> Void) {
        let input = SearchProductDetail(productId: productId)
        api.request(input: input) { (object: Item?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
// MARK: - Use query to search reicpe and product
    func searchRecipe(query: String, number: Int, completion: @escaping (BaseResult<SearchResponse>) -> Void) {
        let input = SearchRequest(query: query, number: number)
        api.request(input: input) { (object: SearchResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
}
