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
    
    // Computed property for the label text that appears in the table view
    // cell.
    var memeLabelText: String {
        // Take the lesser of 10 or the length of topText and bottomText
        let topPartLength = count(topText) >= 10 ? 10 : count(topText)
        let bottomPartLength = count(bottomText) >= 10 ? 10 : count(bottomText)
        
        // Take the first topPartLength characters of topText
        // Set the start of the range to the startIndex of topText and advance the startIndex by topPartLength to get the endIndex
        let topPart = topText.substringWithRange(Range(start: topText.startIndex, end: advance(topText.startIndex, topPartLength)))
        
        // Take the last bottomPartLength characters of bottomText
        // Get the start index by advancing -1 * bottomPartLength from the endIndex
        let bottomPart = bottomText.substringWithRange(Range(start: advance(bottomText.endIndex, -1 * bottomPartLength), end: bottomText.endIndex))
        
        // Join the two pieces with '...'
        return "\(topPart)...\(bottomPart)"
    }
    
}
