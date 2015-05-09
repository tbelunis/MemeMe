//
//  MemeMeTabBarControllerViewController.swift
//  MemeMe
//
//  Created by TOM BELUNIS on 4/27/15.
//  Copyright (c) 2015 TOM BELUNIS. All rights reserved.
//

import UIKit

class MemeMeTabBarControllerViewController: UITabBarController {

  var memes: [Meme]!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

  override func viewDidAppear(animated: Bool) {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    memes = appDelegate.memes
    
    if memes.count == 0 {
      let storyboard = self.storyboard
      let controller = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
      //self.presentViewController(controller, animated: true, completion: nil)
      
      //      self.performSegueWithIdentifier("ShowMemeEditor", sender: nil)
      //      let memeEditorViewController = MemeEditorViewController()
            dispatch_async(dispatch_get_main_queue(), {
              self.presentViewController(controller, animated: true, completion: nil)
            })
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    memes = appDelegate.memes
    
    if memes.count == 0 {
      let storyboard = self.storyboard
      let controller = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
      //self.presentViewController(controller, animated: true, completion: nil)
      
      //      self.performSegueWithIdentifier("ShowMemeEditor", sender: nil)
      //      let memeEditorViewController = MemeEditorViewController()
      dispatch_async(dispatch_get_main_queue(), {
        self.presentViewController(controller, animated: true, completion: nil)
      })
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
