//
//  Meme.swift
//  MemeMe
//
//  Created by TOM BELUNIS on 4/23/15.
//  Copyright (c) 2015 TOM BELUNIS. All rights reserved.
//

import UIKit

class Meme: NSObject {
  
  var topText: String = "TOP"
  var bottomText: String = "BOTTOM"
  var originalImage: UIImage
  var memedImage: UIImage
  

  
  init(topText: String?, bottomText: String?, originalImage: UIImage, memedImage: UIImage) {
    if let topText = topText {
      self.topText = topText
    }
    if let bottomText = bottomText {
      self.bottomText = bottomText
    }
    self.originalImage = originalImage
    self.memedImage = memedImage
  }
  
  var memeLabelText: String {
    let topPartLength = count(topText) >= 10 ? 10 : count(topText)
    let bottomPartLength = count(bottomText) >= 10 ? 10 : count(bottomText)
    let topPart = topText.substringWithRange(Range(start: topText.startIndex, end: advance(topText.startIndex, topPartLength)))
    let bottomPart = bottomText.substringWithRange(Range(start: advance(bottomText.endIndex, -1 * bottomPartLength), end: bottomText.endIndex))
    return "\(topPart)...\(bottomPart)"
  }
  
}
