//
//  NetworkManager.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    func getMovieListForPage(page:Int, completionHandler:@escaping (_ responsObject: [MovieModel]?, _ error: Error?) -> ()) {
        
        var movieList: [MovieModel] = []
        do {
            guard let path = Bundle.main.path(forResource: "CONTENTLISTINGPAGE-PAGE\(page)", ofType: "json") else {
                completionHandler(movieList,nil)
                return
            }
            let jsonData : NSData = NSData(contentsOfFile: path)!
            let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            if let pageResultDictionary = jsonResult["page"] as? NSDictionary{
                if let contentListDictionary = pageResultDictionary["content-items"] as? NSDictionary {
                    if let contentListArray = contentListDictionary["content"] as? NSArray {
                        for movieDict in contentListArray {
                            if let movie = MovieModel.init(dictionary: movieDict as? NSDictionary){
                                movieList.append(movie)
                            }
                        }
                    }
                }
            }
            completionHandler(movieList,nil)
            
        } catch {
            completionHandler([],error)
        }
        
    }

}
