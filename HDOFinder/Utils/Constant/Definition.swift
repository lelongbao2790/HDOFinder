//
//  Definition.swift
//  HDOFinder
//
//  Created by Bao (Brian) L. LE on 3/20/17.
//  Copyright © 2017 Bao (Brian) L. LE. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct Common {
    static let kHTML = ".html"
    static let kDot = "."
    static let kDefaultEpi = "1"
}

struct API {
    
    static let kBaseUrl = "http://hdonline.vn"
    static let kFrontEpisode = "/frontend/episode/xmlplay?ep=%@&fid=%@&token=%@&format=json"
}

class Header {
    static func movieHeader(link:String) -> HTTPHeaders {
        let header = ["Accept":"application/json, text/javascript, */*; q=0.01",
                "Accept-Encoding" : "gzip, deflate, sdch",
                "Accept-Language" : "en-US,en;q=0.8,vi;q=0.6",
                "Cache-Control" : "max-age=0",
                "Host" : "hdonline.vn",
                "Connection" : "keep-alive",
                "Referer" : link,
                "User-Agent" : "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36"]
        return header as HTTPHeaders;
    }
}
