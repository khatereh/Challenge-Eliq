//
//  Company.swift
//  Challenge-Eliq
//
//  Created by parto on 3/10/20.
//  Copyright © 2020 parto. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct Company: Decodable {
    
    let name : String
    let domain : String
    let logo : String
    
    
    static func fetchList(_ query: String, completion: @escaping CompanyListCompletion){
        
        
        
        func saveCache(_ query: String, _ companyList: CompanyList) {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            for company in companyList {
                
                let managedContext = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Result", in: managedContext)!
                let result = NSManagedObject(entity: entity, insertInto: managedContext)
                
                result.setValue(query, forKeyPath: "query")
                result.setValue(company.name, forKeyPath: "name")
                result.setValue(company.domain, forKeyPath: "domain")
                result.setValue(company.logo, forKeyPath: "logo")
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            
        }
        
        
        
        func checkFromcCache(_ query: String) -> CompanyList {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            var cacheResults: [NSManagedObject] = []
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Result")
            fetchRequest.predicate = NSPredicate(format: "query == %@", query)
            
            do {
                cacheResults = try managedContext.fetch(fetchRequest)
                var companies : CompanyList = []
                for result in cacheResults {
                    
                    let company = Company(name: result.value(forKeyPath:"name") as! String,
                                          domain: result.value(forKeyPath:"domain") as! String,
                                          logo: result.value(forKeyPath:"logo") as! String)
                    companies.append(company)
                }
                return companies
                
            }
            catch {
                print("error executing fetch request: \(error)")
            }
            return []
            
        }
        
        
        //GET Cache Data
        let list = checkFromcCache(query)
        if  list.count > 0  {
            completion(list)
            return
        }
        
        //Send Request to API
        APIManager.sharedInstance.fetch(SUGGESTION_URL+query, of: CompanyList.self) { (companyList) in
            
            saveCache(query,companyList)
            completion(companyList)
        }
        
        
        
    }
    
    
    
}



