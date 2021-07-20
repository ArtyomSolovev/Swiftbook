//
//  GetCommentResponse.swift
//  MVC-Networking
//
//  Created by Артем Соловьев on 20.07.2021.
//

import Foundation

struct GetCommentResponse {
    
    typealias JSON = [String: AnyObject]
    let comments: [Comment]
    
    init(json: Any) throws{
        guard let array = json as? [JSON] else { throw NetworkError.failInternet }
        
        var comments = [Comment]()
        for dictionary in array {
            guard let comment = Comment(dict: dictionary) else {
                continue
            }
            comments.append(comment)
        }
        self.comments = comments
    }
    
}
