//
//  CommandCell.swift
//  MVC-Networking
//
//  Created by Артем Соловьев on 20.07.2021.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    func configure(with comment: Comment) {
        self.label.text = comment.name
        self.textView.text = comment.body
        
    }
}
