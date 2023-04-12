//
//  ProductViewModel.swift
//  GetMyCloths
//
//  Created by Ravi Dwivedi on 09/04/23.
//

import Foundation



final class ProductViewModel{
    
    var  products:[Products] = []
    var eventHandler:((_ event:Event) -> Void)? // Data Binding
    
    
    // Generic API Calls
    func getAllProducts(){
        APIManager.shared.request(modelType: [Products].self, type: EndPointsItem.products) {[weak self] response in
            switch response{
            case .success(let product):
                // print(product)
                self?.products = product
                self?.eventHandler?(.dataLoaded)
            case .failure(let error):
                self?.eventHandler?(.error(error))
                //print(error)
            }
        }
    }
    
    
    func addProduct(parameters:AddProduct){
        APIManager.shared.request(modelType: AddProduct.self, type: EndPointsItem.addProduct(product: parameters)) { result in
            switch result{
            case .success(let product):
                print(product)
                self.eventHandler?(.newProductAdded(product: product))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    /*
     func getAllProducts(){
     eventHandler?(.startLoading)
     APIManager.shared.getDataFromApi(completion: { [weak self] response in
     switch response{
     case .success(let product):
     print(product)
     self?.products = product
     self?.eventHandler?(.dataLoaded)
     case .failure(let error):
     self?.eventHandler?(.error(error))
     print(error)
     }
     
     }, url: Constants.API.productURL)
     }
     */
}

extension ProductViewModel{
    
    enum Event{
        case startLoading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newProductAdded(product:AddProduct)
    }
}
