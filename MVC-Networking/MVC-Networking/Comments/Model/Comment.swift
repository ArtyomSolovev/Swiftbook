//
//  Comment.swift
//  MVC-Networking
//
//  Created by Артем Соловьев on 20.07.2021.
//

import Foundation
 
struct Comment{
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    
    
    init?(dict: [String: AnyObject]) {
        guard let postId = dict["postId"] as? Int,
              let id = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let email = dict["email"] as? String,
              let body = dict["body"] as? String else {return nil}
        
        self.postId = postId
        self.id = id
        self.email = email
        self.name = name
        self.body = body
        
    }
    
    
    
    
    
}
