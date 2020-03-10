//
//  Constants.swift
//  Challenge-Eliq
//
//  Created by parto on 3/10/20.
//  Copyright © 2020 parto. All rights reserved.
//

import Foundation

let URL_BASE = "https://autocomplete.clearbit.com/v1/companies/"
let SUGGESTION_URL = URL_BASE + "suggest?query="

typealias CompanyList = [Company]
typealias CompanyListCompletion = (CompanyList?) -> Void
