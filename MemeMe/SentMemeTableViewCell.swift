//
//  SentMemeTableViewCell.swift
//  MemeMe
//
//  Created by TOM BELUNIS on 4/30/15.
//  Copyright (c) 2015 TOM BELUNIS. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
