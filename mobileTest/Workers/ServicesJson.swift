//
//  ServicesJson.swift
//  mobileTest
//
//  Created by Gio Valdes on 9/11/22.
//

import Alamofire
import UIKit

class ServicesJson{
    func getPosts(idPost:String = "", completion: @escaping (Bool, [Post]) ->()){
        let url = "\(URLs.jsonPlaceHolder)\(Services.getPost)/\(idPost)"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [Post].self) { response in
                switch response.result{
                case .success( _):
                    guard let posts = response.value else { return }
                    completion(true, posts)
                case .failure( _):
                    debugPrint("error")
                    completion(false, [])
                }
            }
        
        
        //        self.loadJson(fromURLString: url) { (result) in
        //            switch result {
        //            case .success(let data):
        //                if let posts = self.parse(jsonData: data)
        //                {
        //                    completion(true, posts)
        //                }
        //
        //            case .failure(let error):
        //                print(error)
        //                completion(false, [])
        //            }
        //        }
    }
    
    func getCommetsByPost(idPost:Int32, completion: @escaping (Bool, [Comment])->()) {
        let url = "\(URLs.jsonPlaceHolder)\(Services.getPost)/\(idPost)\(Services.getComment)"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [Comment].self) { response in
                switch response.result{
                case .success( _):
                    guard let comments = response.value else { return }
                    completion(true, comments)
                case .failure( _):
                    debugPrint("error")
                    completion(false, [])
                }
            }
    }
    
    func getUserInfo(idUser:Int32, completion: @escaping (Bool, AuthorUser)->()) {
        let url = "\(URLs.jsonPlaceHolder)\(Services.getUser)/\(idUser)"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: AuthorUser.self) { response in
                switch response.result{
                case .success( _):
                    guard let user = response.value else { return }
                    completion(true, user)
                case .failure( _):
                    debugPrint("error")
                    let userError = AuthorUser(id: 0, name: "No name", username: "no username", email: "no mail")
                    completion(false, userError)
                }
            }
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    
    private func parse(jsonData: Data) -> [Post]? {
        do {
            let decodedData = try JSONDecoder().decode([Post].self, from: jsonData)
            return decodedData
        } catch {
            debugPrint("decode error")
            return nil
        }
    }
}

