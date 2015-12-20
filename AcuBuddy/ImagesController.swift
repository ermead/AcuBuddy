//
//  ImageController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/20/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import Foundation
import UIKit

class EM_ImagesController {
    
    static let sharedInstance = EM_ImagesController()
    
    var images: [Image] {
        
        let InnerClassic = Image(image: UIImage(named: "InnerClassic"))
        let image1 = Image(image: UIImage(named: "1"))
        let image2 = Image(image: UIImage(named: "2"))
        let image3 = Image(image: UIImage(named: "3"))
        let image4 = Image(image: UIImage(named: "4"))
        let image5 = Image(image: UIImage(named: "5"))
        let image6 = Image(image: UIImage(named: "6"))
        let image7 = Image(image: UIImage(named: "7"))
        let image8 = Image(image: UIImage(named: "8"))
        let image9 = Image(image: UIImage(named: "9"))
        let image10 = Image(image: UIImage(named: "10"))
        let image11 = Image(image: UIImage(named: "11"))
        
        let array = [InnerClassic, image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, image11]
        
        return array
    }
    
}