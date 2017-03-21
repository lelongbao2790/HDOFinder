//
//  MovieFile.swift
//  HDOFinder
//
//  Created by Bao (Brian) L. LE on 3/20/17.
//  Copyright © 2017 Bao (Brian) L. LE. All rights reserved.
//

import Cocoa
import RealmSwift
import ObjectMapper

class MovieFile: Object, Mappable {
    
    var urlLink = ""
    var file = ""
    var level = List<Links>()
    var mediaid = ""
    var image = ""
    var prelink = ""
    var provider = ""
    var host = ""
    var subtitle = List<Subtitles>()
    
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        urlLink             <- map["link"]
        file           <- map["file"]
        level          <- (map["level"], ListTransform<Links>())
        mediaid         <- map["mediaid"]
        image           <- map["image"]
        prelink         <- map["prelink"]
        provider        <- map["provider"]
        host            <- map["host"]
        subtitle        <- (map["subtitle"], ListTransform<Subtitles>())
    }
    
}

class Links: Object, Mappable {
    var file = ""
    var type = ""
    var quality = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        file             <- map["file"]
        type           <- map["type"]
        quality          <- map["label"]
    }
}

class Subtitles: Object, Mappable {
    
    dynamic var file = ""
    dynamic var type = ""
    dynamic var code = ""
    dynamic var kind = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        file             <- map["file"]
        code           <- map["code"]
        type          <- map["label"]
        kind          <- map["kind"]
    }

    
}
