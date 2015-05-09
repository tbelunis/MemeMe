//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by TOM BELUNIS on 4/30/15.
//  Copyright (c) 2015 TOM BELUNIS. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeDetailImageView: UIImageView!
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let meme = meme {
            memeDetailImageView.image = meme.memedImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
