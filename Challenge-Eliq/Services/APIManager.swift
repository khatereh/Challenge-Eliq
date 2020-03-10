//
//  APIManager.swift
//  Challenge-Eliq
//
//  Created by parto on 3/10/20.
//  Copyright © 2020 parto. All rights reserved.
//


import Alamofire


class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    
    func  fetch<T: Decodable >(_ url: String, of: T.Type,completion: @escaping (T) -> Void){
        
        AF.request(url).validate().responseDecodable(of: T.self) { (response) in
            
            if let error = response.error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let model = response.value else {
                print("NO DATA")
                return
            }
            completion(model)
            
        }
    }
    
}
