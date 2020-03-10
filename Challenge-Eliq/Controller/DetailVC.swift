//
//  ViewController.swift
//  Challenge-Eliq
//
//  Created by parto on 3/10/20.
//  Copyright © 2020 parto. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class DetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var domainLabel: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    
    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let company = company {
            
            nameLabel.text = company.name
            domainLabel.text = company.domain
            setImage(url:company.logo)
        }
        
    }
    
    private func setImage(url: String){
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                self.logoImg.image = image
            }
        }
    }
    
    
}

