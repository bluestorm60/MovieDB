//
//  LoginHandler.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import Foundation
import Alamofire
import RxSwift

class  HomeServiceHandler : BaseServiceHandler.BaseAPIConnection{
    func popularMoviesRequest(page: Int) -> Observable<MoviesDTO>{
        return request(homeDashboard.movies(page: page))
    }
}
fileprivate enum homeDashboard : RouterConvertible {
    case movies(page: Int)
    
    var reuqestParameterType: RequestParameterType{
        switch self {
        case .movies:
            return .json
        }
    }
    var method: HTTPMethod{
        switch self {
        case .movies:
            return .get
        }
    }
    
    var endPoint: EndPoint{
        switch self {
        case .movies:
            return APIs.Home.movies
        }
    }
    
    var queryItems: QueryItems?{
        switch self {
        case .movies(let page):
            return ["api_key":token,"page":"\(page)"]
        }
    }
    
    var headers: HTTPHeaders?{
        return nil
    }
    
    var parameters: Parameters?{
        switch self {
        default:
            return nil
        }
    }
    
    var environment: Environment{
        return .testing
    }
    
    var isAuth: Bool{
        return true
    }
}
