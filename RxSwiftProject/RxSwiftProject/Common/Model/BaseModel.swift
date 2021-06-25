//
//  BaseModel.swift
//  RxSwiftProject
//
//  Created by Tb on 2021/6/25.
//

import Foundation


struct BaseModel<T: Codable>: Codable {
    let data: T?
    let errorCode: Int?
    let errorMsg: String?
}
