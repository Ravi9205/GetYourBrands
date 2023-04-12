//
//  EndPointType.swift
//  GetMyCloths
//
//  Created by Ravi Dwivedi on 10/04/23.
//

import Foundation

enum HttpMethods:String{
    case get = "GET"
    case post = "POST"
}

protocol EndPointType  {
    var path:String {get}
    var baseURL:String{get}
    var url:URL? {get}
    var method:HttpMethods{get}
    var body:Encodable? { get}
    var header:[String:String]? {get}
}

enum EndPointsItem{
     case products
     case addProduct(product:AddProduct)
}

//https://fakestoreapi.com/products
extension EndPointsItem:EndPointType{
   
    var path: String {
        switch self{
        case .products:
            return "products"
        case .addProduct:
            return "products/add"
        }
    }
    
    var baseURL: String {
        switch self{
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://dummyjson.com/"
        }
    }
    
    var url: URL? {
        return URL(string:"\(baseURL)\(path)")
    }
    
    var method: HttpMethods {
        switch self{
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }
    
    var body: Encodable? {
        switch self{
        case .products:
            return nil
        case .addProduct(let products):
            return products
        }
    }
    
    var header: [String : String]?{
        return APIManager.commonHeaders
    }
}
