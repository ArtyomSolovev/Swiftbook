//
//  PhotoViewController.swift
//  PhotoTapps
//
//  Created by Артем Соловьев on 18.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {

    var image: UIImage?
    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = image
    }
    

    @IBAction func shareAction(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            if bool{
                print("Successful")
            }
        }//отслежимаем был ли успешно доставлен VC
        present(shareController, animated: true, completion: nil)
        
    }
}
