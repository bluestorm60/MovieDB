//
//  Environment.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import Foundation


enum Environment {
    
    case production
    case testing
    
    var scheme: String {
        switch self {
        case .production,.testing:      return "https"
        }
    }
    
    var host: String {
        switch self {
        case .testing:
            return MainUrl
        case .production:
            return MainUrl
        }
    }

    var port: Int? {
        switch self {
        case .production,.testing:            return nil

        }
    }
    
    
    var components : URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host.encodeUrl()
       components.port = self.port
        
        return components
    }
    
    //additonal headers specified for the environment only
    var headers : [String : String]? {
        switch self {
        case .production,.testing:   return nil
            //["Authorization":  TokenProvider.guestAccessTokenHeader()]

        }
    }
    
    //used for webviews as example
    var baseURL : String {
        switch self {
        case .production,.testing:   return ""
        }
    }
    
}
