//
//  MovieFacade.swift
//  HDOFinder
//
//  Created by Bao (Brian) L. LE on 3/20/17.
//  Copyright © 2017 Bao (Brian) L. LE. All rights reserved.
//

import Cocoa

public protocol MovieFacadeDelegate : class{
    func requestLinkMovieSuccess(file: AnyObject?)
    func requestLinkMovieFail(sender: AnyObject?)
}

class MovieFacade: NSObject {

    weak var movieFacadeDelegate:MovieFacadeDelegate?
    static let shared = MovieFacade()
    
    /**
     * Return url stream link 
     */
    func requestLinkMovie(episode:String, link:String, movieID: String, token: String) {
        weak var weakSelf = self
        BaseClient.sharedInstance.getFileMovie(episode:episode, link: link, fid: movieID, token: token, onCompletion: { (isSuccess:Bool?, error:NSError?, value:AnyObject?) in
            
            if isSuccess == true {
                weakSelf!.movieFacadeDelegate?.requestLinkMovieSuccess(file: value)
            } else {
                weakSelf!.movieFacadeDelegate?.requestLinkMovieFail(sender: error)
            }
        })
    }
    
    /**
     * Return movie id from link
     */
    func getMovieId(link:String) -> String {
        
        var movieId = ""
        let words = link.components(separatedBy:"-")
        for word in words {
            if word.contains(".html") {
                
                // Single film
                let lastWords = word.components(separatedBy:".")
                let firstWord = lastWords[0]
                if firstWord.contains(".") {
                    // Episode
                    movieId = firstWord.components(separatedBy:".")[0]
                    break
                } else {
                    // Single 
                    movieId = firstWord
                }
            
                break
            }
        }
        
        return movieId
        
    }

}
