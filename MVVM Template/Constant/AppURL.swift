//
//  AppURL.swift
//  MVVMDemo
//
//  Created by Seifallah Selmi on 17/06/20.
//  Copyright © 2020 Seifallah Selmi All rights reserved.
//

import UIKit

struct Domain {
    static var dev = "http://api.themoviedb.org/"
    static var assest = "http://image.tmdb.org/t/p/w185/"

}
extension Domain {
    static func baseUrl() -> String {
        print(Domain.dev)
        return Domain.dev
    }
}

struct APIEndpoint {
    static let movies         = "3/discover/movie?api_key=57a4269b6c0098d52f01d65572e57972&sort_by=popularity.desc"
}


enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}

enum ContentType: String {
    case json            = "application/json"
    case multipart       = "multipart/form-data"
    case ENUS            = "en-us"
}

enum MultipartType: String {
    case image = "Image"
    case csv = "CSV"
}

enum MimeType: String {
    case image = "image/png"
    case csvText = "text/csv"
}

enum UploadType: String {
    case avatar
    case file
}


