//
//  EndPoints.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import Foundation


import Foundation
protocol EndPoint {
    var subdomain : String { get }
    var path: String { get }
}

struct APIs {
    static var mainPath = "/"
    
    
    enum Home : EndPoint{
        case movies

        var subdomain: String{
            switch self {
            case .movies:
                return mainPath
            }
            
        }
        var path: String{
            switch self {
            case .movies:
                return "3/movie/popular"
            }
            
        }
    }
    
}
