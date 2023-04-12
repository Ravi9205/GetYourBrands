//
//  ProductModel.swift
//  GetMyCloths
//
//  Created by Ravi Dwivedi on 09/04/23.
//

import Foundation



struct Products:Codable{
    let id:Int
    let title:String?
    let price:Double
    let description:String?
    let category:String?
    let image:String?
    let rating:Rate
    
}

struct Rate:Codable{
    let rate:Double
    let count:Int
}
