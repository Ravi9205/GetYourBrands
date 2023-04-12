//
//  AddProduct.swift
//  GetMyCloths
//
//  Created by Ravi Dwivedi on 11/04/23.
//

import Foundation


struct AddProduct:Codable {
    var id:Int? = nil
    var title:String
    
     enum CodingKeys: String,CodingKey{
        case id = "id"
        case title = "title"
    }
}

