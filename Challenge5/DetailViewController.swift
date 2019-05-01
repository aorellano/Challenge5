//
//  DetailViewController.swift
//  Challenge5
//
//  Created by Alexis Orellano on 4/29/19.
//  Copyright © 2019 Alexis Orellano. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = selectedImage{
            image.image = imageToLoad
            print(imageToLoad)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
