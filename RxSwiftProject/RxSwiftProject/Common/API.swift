//
//  API.swift
//  RxSwiftProject
//
//  Created by Tb on 2021/6/25.
//

import UIKit
import Moya
import MBProgressHUD


class API {
    /// baseUrl
    static let baseUrl = "https://www.wanandroid.com/"
    /// 私有初始化方法，避免被实例化
    private init(){}
    
    enum Project {
        static let tags = "project/tree/json"
        static let tagList = "project/list/"
    }
}

enum ProjectService {
    case tags
    case tagList(id: Int, page: Int)
}

extension ProjectService: TargetType {
    var baseURL: URL {
        URL(string: API.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .tags:
           return API.Project.tags
        case .tagList(_, let page):
            return API.Project.tagList + page.toString + "/json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .tags:
            return .requestParameters(parameters: Dictionary.temp, encoding: URLEncoding.default)
        case .tagList(let id, _):
            return .requestParameters(parameters: ["cid:" : id.toString], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

extension Int {
    var toString: String {
        return "\(self)"
    }
}
extension Dictionary {
    static var temp: Dictionary { return [:] }
}


let projectProvider: MoyaProvider<ProjectService> = {
    let stubClosure = { (target: ProjectService) -> StubBehavior in
        return .never
    }
    let LoadingPlugin = NetworkActivityPlugin { (type, target) in
        guard let vc = topVC else { return }
        switch type {
        case .began:
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: vc.view, animated: false)
                MBProgressHUD.showAdded(to: vc.view, animated: true)
            }
          
        case .ended:
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: vc.view, animated: true)
            }
            
        }
    }
    return MoyaProvider(stubClosure: stubClosure,  plugins: [LoadingPlugin])
}()
