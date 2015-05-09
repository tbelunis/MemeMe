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
    @IBOutlet weak var editSentMemesButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func editSentMemes(sender: UIBarButtonItem) {
        if editSentMemesButton.title == "Edit" {
            self.memeTableView.setEditing(true, animated: true)
            editSentMemesButton.title = "Done"
        } else {
            self.memeTableView.setEditing(false, animated: true)
            editSentMemesButton.title = "Edit"
        }
    }
    
    func deleteMeme(index: Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.removeAtIndex(index)
        memes = appDelegate.memes
    }
}

// MARK: UITableViewDelegate methods
extension SentMemesTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        performSegueWithIdentifier("ShowMemeDetail", sender: meme)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return memeTableView.editing
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        self.deleteMeme(indexPath.row)
        let indexPathArray: NSArray = [indexPath]
        self.memeTableView?.deleteRowsAtIndexPaths(indexPathArray as [AnyObject], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
}

// MARK: UITableViewDataSource methods
extension SentMemesTableViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
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