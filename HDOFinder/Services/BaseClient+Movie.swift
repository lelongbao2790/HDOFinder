//
//  BaseClient+Movie.swift
//  HDOFinder
//
//  Created by Bao (Brian) L. LE on 3/20/17.
//  Copyright © 2017 Bao (Brian) L. LE. All rights reserved.
//

import Foundation

import RealmSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper


extension BaseClient {
    
    /**
     * Return movie with link
     */
    func getFileMovie(episode:String, link:String, fid:String, token:String, onCompletion:@escaping ServiceGetResponse) {
        
        let token = String(format: API.kFrontEpisode,episode, fid, token)
        let urlRequest = API.kBaseUrl + token
        
        Alamofire.request(urlRequest,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: Header.movieHeader(link: link) ).responseObject { ( response : DataResponse <MovieFile>) in
            
            switch response.result {
                
                case .success (let movie): onCompletion(true, nil, movie); break
                case .failure(let error): onCompletion(false, error as NSError?, nil); break
                
            }
        }
    }
    
}
