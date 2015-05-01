//
//  ViewController.swift
//  MemeMe
//
//  Created by TOM BELUNIS on 4/23/15.
//  Copyright (c) 2015 TOM BELUNIS. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController {
  
  var memes: [Meme]!
  
  @IBOutlet weak var memeTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    //self.memeTableView.registerClass(SentMemeTableViewCell.self, forCellReuseIdentifier: "SentMemeTableCell")
    memeTableView.registerNib(UINib(nibName: "memeTableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    memes = appDelegate.memes
    memeTableView.reloadData()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowMemeDetail" {
      let controller = segue.destinationViewController as! MemeDetailViewController
      controller.meme = sender as? Meme
    }
  }
  
  @IBAction func addMeme(sender: UIBarButtonItem) {
    performSegueWithIdentifier("EditMeme", sender: nil)
  }
  
}

// MARK: UITableViewDelegate methods
extension SentMemesTableViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let meme = memes[indexPath.row]
    performSegueWithIdentifier("ShowMemeDetail", sender: meme)
  }
}

// MARK: UITableViewDataSource methods
extension SentMemesTableViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell: SentMemeTableViewCell  = tableView.dequeueReusableCellWithIdentifier("tableCell") as! SentMemeTableViewCell
    let meme = memes[indexPath.row]

    cell.memeImageView!.image = meme.memedImage
    cell.memeLabel!.text = meme.memeLabelText
    return cell
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
}