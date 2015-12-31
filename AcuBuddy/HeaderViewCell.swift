//
//  HeaderViewCell.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/31/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit

protocol HeaderTableViewCellDelegate {
    
    func didSelectUserHeaderTableViewCell(Selected: Bool, UserHeader: EM_HeaderTableViewCell)
    
}

class EM_HeaderTableViewCell: UITableViewCell  {
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    var reference: String?
    
    
    var delegate : HeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func selectedHeader(sender: AnyObject) {
        delegate?.didSelectUserHeaderTableViewCell(true, UserHeader: self)
        
    }
    
    
}