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
    var tokenId = ""
    
    /**
     * Return url stream link 
     */
    func requestLinkMovie(episode:String, link:String, movieID: String, token: String) {
        
        weak var weakSelf = self
        DispatchQueue.global(qos: .userInitiated).async { // 1
            BaseClient.sharedInstance.getFileMovie(episode:episode, link: link, fid: movieID, token: token, onCompletion: { (isSuccess:Bool?, error:NSError?, value:AnyObject?) in
                DispatchQueue.main.async { // 2
                    if isSuccess == true {
                        weakSelf!.movieFacadeDelegate?.requestLinkMovieSuccess(file: value)
                    } else {
                        weakSelf!.movieFacadeDelegate?.requestLinkMovieFail(sender: error)
                    }
                }
            })
        }
        
    }
    
    /**
     * Return movie id from link
     * @param: ex:http://hdonline.vn/phim-mat-danh-iris-1493.html
     * return: 1493
     */
    func getMovieId(link:String) -> String {
        
        var movieId = ""
        let words = link.components(separatedBy:"-")
        for word in words {
            if word.contains(Common.kHTML) {
                
                // Single film
                let firstWord = word.components(separatedBy:Common.kDot)[0]
                if firstWord.contains(Common.kDot) {
                    // Episode
                    movieId = firstWord.components(separatedBy:Common.kDot)[0]
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

    /**
     * Return token link
     * @param: ex:http://hdonline.vn/phim-mat-danh-iris-1493.html
     */
    func getToken(link:String) -> String {
        var token = ""
        BaseClient.sharedInstance.getTokenMovie(link: link, onCompletion: { (isSuccess:Bool?, error:NSError?, value:AnyObject?) in
            if isSuccess == true {
                let htmlSource = value as! String
                let words = htmlSource.components(separatedBy:"|")
                for item in words {
                    if item.contains("NmY") {
                        token = item
                        self.tokenId = token
                        break
                    }
                }
            }
        })
        return token;
    }
    

}
