//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by TOM BELUNIS on 5/1/15.
//  Copyright (c) 2015 TOM BELUNIS. All rights reserved.
//

import UIKit

let reuseIdentifier = "MemeCollectionCell"

class SentMemesCollectionViewController: UICollectionViewController {
  
  var memes: [Meme]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    // self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 120, height: 120)
//    self.collectionView!.
    self.collectionView!.registerNib(UINib(nibName: "MemeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    
    // Do any additional setup after loading the view.
    collectionView!.delegate = self
    collectionView!.dataSource = self
    self.collectionView!.allowsMultipleSelection = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    memes = appDelegate.memes
    collectionView!.reloadData()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "CollectionShowDetail" {
      let controller = segue.destinationViewController as! MemeDetailViewController
      let meme = sender as! Meme
      controller.meme = meme
    }
  }
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    //#warning Incomplete method implementation -- Return the number of sections
    return 1
  }
  
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //#warning Incomplete method implementation -- Return the number of items in the section
    return memes.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SentMemeCollectionViewCell
    
    // Configure the cell
    cell.memeImageView.image = memes[indexPath.row].memedImage
    
    return cell
  }
  
  @IBAction func addMeme(sender: UIBarButtonItem) {
    performSegueWithIdentifier("AddMeme", sender: nil)
  }
  
  // MARK: UICollectionViewDelegate
  

  
  /*
  // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
  override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
  
  }
  */
  
}

// MARK: UICollectionViewDelegateFlowLayout
extension SentMemesCollectionViewController:UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let picDimension = self.view.frame.size.width / 4.0
    return CGSizeMake(picDimension, picDimension)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    let leftRightInset = self.view.frame.size.width / 14.0
    return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
  }
}

// MARK: UICollectionViewDelegate
extension SentMemesCollectionViewController:UICollectionViewDelegate {
  
  // Uncomment this method to specify if the specified item should be highlighted during tracking
  override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  // Uncomment this method to specify if the specified item should be selected
  override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    println("cell selected")
    let meme = memes[indexPath.row]
    performSegueWithIdentifier("CollectionShowDetail", sender: meme)
  }
}
