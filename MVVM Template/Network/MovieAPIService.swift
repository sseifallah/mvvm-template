//
//  MovieAPIService.swift
//  MVVMDemo
//
//  Created by Shantaram K on 20/03/19.
//  Copyright © 2019 Shantaram K. All rights reserved.
//

import UIKit

class MovieAPIService: NSObject, Requestable {

    static let instance = MovieAPIService()
    
    fileprivate let laundryUrl = "https://api.pennlabs.org/laundry/rooms"

    public var movies: [Movie]?

    // Prepare the service
    
    func fetchMovies(callback: @escaping Handler) {
        
        request(method: .get, url: Domain.baseUrl() + APIEndpoint.movies) { (result) in
            
           callback(result)
        }
        
    }
    
}
