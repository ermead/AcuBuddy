//
//  Home_ContainerViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/20/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import UIKit

class EM_HPVC_ContainerViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
       
        let image = EM_ImagesController.sharedInstance.images.first?.image
        
        imageView.image = image
        imageView.alpha = 0.2
        
    }
    
    
}
