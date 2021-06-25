//
//  ViewController.swift
//  RxSwiftProject
//
//  Created by Tb on 2021/6/25.
//

import UIKit
import Moya


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectProvider.request(ProjectService.tags) { (result : Result<Response, MoyaError>) in
            switch result {
            case .success(let response):
                

                guard let json = try? JSONSerialization.jsonObject(with: response.data, options: []) else { return }
                print(json)
                break
            case .failure(let error):
                print(error.errorDescription as Any)
                break
            }
        }
    }


}

