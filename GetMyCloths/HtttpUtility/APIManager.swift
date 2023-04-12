//
//  APIManager.swift
//  GetMyCloths
//
//  Created by Ravi Dwivedi on 09/04/23.
//

import Foundation

enum DataError:Error {
    case invalidData
    case invalidURL
    case invalidResponse
    case message(Error?)
}

final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    //MARK:- GENERIC API CALL
    typealias handler<T> = (Result<T,DataError>)->Void
    
    func request<T:Codable>(modelType:T.Type,type:EndPointType,completion:@escaping handler<T>){
        
        guard let url = type.url else {
            return
        }
        
        
        var request =   URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        
        if let paramters =  try? type.body?.data(){
            request.httpBody =  paramters
        }
        request.allHTTPHeaderFields = type.header
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
           guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let product = try JSONDecoder().decode(modelType, from: data)
                completion(.success(product))
            }
            
            catch{
                completion(.failure(.message(error)))
            }
            
        }.resume()
    }
    
    
    static var  commonHeaders: [String:String]{
        return [
            "Content-Type":"application/json"
        ]
    }
    
    /* Without Generic
     typealias handler = (Result<[Products],DataError>)->Void
     
     func getDataFromApi(completion:@escaping handler,url:String){
     
     guard let url = URL(string:url) else {
     return
     }
     
     URLSession.shared.dataTask(with: url) { data, response, error in
     guard let data = data, error == nil else {
     completion(.failure(.invalidData))
     return
     }
     
     guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
     completion(.failure(.invalidResponse))
     return
     }
     
     do{
     let product = try JSONDecoder().decode([Products].self, from: data)
     completion(.success(product))
     }
     
     catch{
     completion(.failure(.message(error)))
     }
     
     }.resume()
     }
     */
}

//MARK:- Extension for Codebale conversion into Data
extension Encodable {
    func data(using encoder: JSONEncoder = JSONEncoder()) throws -> Data
    { try encoder.encode(self) }
}
