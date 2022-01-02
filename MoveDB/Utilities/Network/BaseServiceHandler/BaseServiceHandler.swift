//
//  BaseServiceHandler.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import UIKit
import Alamofire
import RxSwift

class BaseServiceHandler {
    class BaseAPIConnection {
         func request<T: Codable> (_ urlConvertible: URLRequestConvertible,_ singleLayer:Bool = false) -> Observable<T> {
            let request = AF.request(urlConvertible).validate(statusCode: 200..<401)
            return  handleRequest(request)
        }
        fileprivate  func handleRequest<T:Codable>(_ request:DataRequest) -> Observable<T>
        {
            request.responseString { (response) in
                print(request.request?.allHTTPHeaderFields as Any)
                print(response)
            }
            
            
            return Observable<T>.create { observer in
                //Trigger the HttpRequest using AlamoFire (AF)
                request.responseData { (response) in
                    //Check the result from Alamofire's response and check if it's a success or a failure
                    switch response.result {
                    case .success(let value):
                        do {
                            // 1
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .useDefaultKeys
                            // 2
                            let json = try decoder.decode(T.self, from: response.data!)
                            observer.on(.next(json))
                        } catch let errorJson { // 3
                            var err = errorJson
                            print(errorJson.localizedDescription)
                            observer.onError(errorJson)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        //Something went wrong, switch on the status code and return the error
                        observer.onError(error)
                    }
                }
                
                //Finally, we return a disposable to stop the request
                return Disposables.create {
                    request.cancel()
                }
            }
        }
    }
}
