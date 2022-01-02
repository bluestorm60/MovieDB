//
//  RouterConvertible.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import Foundation
import Alamofire


enum RequestParameterType {
    case json
    case form
}
typealias QueryItems = [String : String]
protocol RouterConvertible: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var endPoint: EndPoint { get }
    var queryItems: QueryItems? { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var environment : Environment { get }
    var isAuth : Bool { get }
    var reuqestParameterType : RequestParameterType { get }
    
    
    
}

extension RouterConvertible {
    private var baseJsonHeaders : [String : String] {
        return [
            "Content-Type" : "application/json; charset=UTF-8",
            "Accept" : "application/json"
        ]
    }
    
    private var baseFormHeaders : [String : String] {
        return [
            "Content-Type" : "application/x-www-form-urlencoded",
            "Accept" : "application/json"
        ]
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        // URL Components
        var components = environment.components
        components.path = endPoint.subdomain + endPoint.path
        
        var items = [URLQueryItem]()
        queryItems?.forEach { items.append(URLQueryItem(name: $0, value: $1)) }
        components.queryItems = items
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
        var escapedString1 = (components.query ?? "".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)?.replacingOccurrences(of: " ", with: "%20")) ?? ""
        let escapedString =  components.query ?? "".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        print(components.query ?? "")

        let url = Foundation.URL(string: ((environment.components.host! +  endPoint.subdomain + endPoint.path) + "?" +  escapedString1 ).replacingOccurrences(of: " ", with: "%20").replacingOccurrences(of: "\n", with: "%20"))

        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        var reqHeaders = [String : String]()
        reqHeaders = (self.reuqestParameterType == .json) ?  baseJsonHeaders : baseFormHeaders// + headers
        
        reqHeaders.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }
        
        // Parameters
        if let parameters = parameters {
            switch self.reuqestParameterType {
            case .json:
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            case .form:
                urlRequest.httpBody = parameters.encodeParametersCustom()
                
            }
        }
        #if DEBUG
        print(parameters)
        print(urlRequest)
        #endif
        return urlRequest
    }
    
    func getFormDataPostString(params:[String:String]) -> String
    {
        var components = URLComponents()
        components.queryItems = params.keys.compactMap{
            URLQueryItem(name: $0, value: params[$0])
        }
        return components.query ?? ""
    }
}

extension Dictionary {
    static func +(lhs: Dictionary, rhs: Dictionary?) -> Dictionary {
        if rhs == nil {
            return lhs
        } else {
            var dic = lhs
            rhs!.forEach { dic[$0] = $1 }
            return dic
        }
    }
    func percentEscapeString(string: String) -> String {
        let characterSet = NSMutableCharacterSet.alphanumerics as! NSMutableCharacterSet
        characterSet.addCharacters(in: "-._* ")
        let convertedString = string.addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)?.replacement(" ", "+")
        return convertedString ?? ""
    }

    func encodeParametersCustom()  -> Data {
        
        let parameterArray = self.map { (key, value) -> String in
            return "\(key)=\(self.percentEscapeString(string: value as! String))"
        }
        if let convertedData = parameterArray.joined(separator: "&").data(using: .utf8) {
            return convertedData
        }
        return Data()
    }
}


extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
    }
}


extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}
