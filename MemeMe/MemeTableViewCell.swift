//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by TOM BELUNIS on 4/23/15.
//  Copyright (c) 2015 TOM BELUNIS. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
  
  @IBOutlet var memeImage: UIImageView!
  @IBOutlet var memeLabel: UILabel!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
