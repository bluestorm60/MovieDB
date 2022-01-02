//
//  LoginViewModel.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import Foundation
import RxSwift
import RxCocoa
protocol LoginViewModelValidation{
    func validFor(userName: String, password: String)
}

class LoginViewModel: NSObject, ConfigurationViewModelType{
    
    struct Input: InputType {
        let username: Observable<String>
        let password: Observable<String>
    }

    struct Output: OutputType {
        let isLoginAllowed: Driver<Bool>
    }

    func configure(input: Input) -> Output {
        let isLoginAllowed = Observable.combineLatest(input.username, input.password) { (username, password) in
            return username.isEmail && password.isValidPassword
        }.asDriver(onErrorJustReturn: false)
        return Output(isLoginAllowed: isLoginAllowed)
    }
}
