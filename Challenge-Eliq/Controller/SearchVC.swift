//
//  SearchVC.swift
//  Challenge-Eliq
//
//  Created by parto on 3/10/20.
//  Copyright © 2020 parto. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    private var searchTimer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func editingChanged(_ sender: Any) {
        
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(search), userInfo: nil, repeats: false )
    }

    @objc func search() {
        guard let keyWord = searchField.text else { return }
//        delegate?.searchWord(keyWord)
    }
    
}
