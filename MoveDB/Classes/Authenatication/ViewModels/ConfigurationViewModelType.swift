//
//  File.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import Foundation

protocol InputType {}

protocol OutputType {}

protocol ConfigurationViewModelType {
    associatedtype Input: InputType
    associatedtype Output: OutputType

    func configure(input: Input) -> Output
}
