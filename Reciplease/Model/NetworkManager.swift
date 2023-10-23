//
//  NetworkManager.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 23/10/2023.
//

import Foundation
import Alamofire

class NetworkManager: NetworkProtocol {
    func request(url: URL, completionHandler: @escaping (DataResponse<RecipesHits, AFError>) -> Void) {
        let request = AF.request(url) { $0.timeoutInterval = 10 }.validate()
        request.responseDecodable(completionHandler: completionHandler)
    }
}

protocol NetworkProtocol {
    func request(url: URL, completionHandler: @escaping(DataResponse<RecipesHits, AFError>)->Void)
}
