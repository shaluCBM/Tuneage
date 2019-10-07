//
//  ConnectionManager.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-20.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class ConnectionManager {
    
    let BASE_URL: String = "https://www.googleapis.com/youtube/v3/"
    let SEARCH_VIDEO: String = "search?part=snippet&q="
    let VIDEO_TYPE: String = "&type=video&key="
    let MAX_RESULTS : String = "&maxResults=10"
    let API_KEY = "AIzaSyCEJzTPjEN20qKQmjjBWQa66Z_HsUSw8u0"
   
    
    
    func makeRequest(searchText:String, completion:@escaping(Search?,String?)->()){
        //print("searchText", searchText)
        let requestString = BASE_URL + SEARCH_VIDEO + searchText + MAX_RESULTS + VIDEO_TYPE + API_KEY
        let url = URL(string: requestString)
        let request = URLRequest(url: url!)
        
        Alamofire.request(request).responseData { response in
            if let statusCode = response.response?.statusCode {
                //print("StatusCode", statusCode)
                if statusCode != 200 {
                    self.printJSONResponseToConsole(jsonData: response.data!)
                    if let errorData = try? JSONDecoder().decode(ErrorWrapper.self, from: response.data!) {
                        completion(nil,errorData.error.message)
                    }
                }
            }
            
            if response.result.isSuccess {
                guard let data = response.result.value else {
                    completion(nil,"Invalid results obtained")
                    return
                }
                if let model = try? JSONDecoder().decode(Search.self, from:data){
                    //print("Model", model)
                    //print("Item count", model.items.count)
                    completion(model,nil)
                } else{
                    completion(nil,"Invalid results obtained")
                }
            } else {
                print(response.error)
            }
            //self.printJSONResponseToConsole(jsonData: response.data!)
        }
    }
    
    
    func imageRequest(url : URL, completion : @escaping(UIImage?, String?) -> ()){
        
        Alamofire.request(url).responseImage { response in
            if let statusCode = response.response?.statusCode {
                //print("StatusCode", statusCode)
            }
            if let image = response.result.value {
                //print("Image", response.result.value)
                completion(image, nil)
            } else {
                completion(nil, "Image loading failed")
            }
            
        }
    }
    
    
    
    fileprivate func printJSONResponseToConsole(jsonData: Data) {
        if let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
            if let jsonDict = json as? [String: Any] {
                print(jsonDict)
            } else if let jsonArray = json as? [[String: Any]] {
                print(jsonArray)
            } else {
                print("JSON response is neither array nor dictionary")
            }
        } else {
            print("OOPS!!!! it seems like JSON Data is messed up")
        }
        
    }
}
