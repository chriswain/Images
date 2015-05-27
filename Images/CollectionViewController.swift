//
//  CollectionViewController.swift
//  Images
//
//  Created by Christopher Wainwright Aaron on 5/27/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

let reuseIdentifier = "songIdentifier"

var myGlobalImage: UIImage?

class CollectionViewController: UICollectionViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var searchItem: UISearchBar!
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchItem.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func searchSong() {
        
        let searchText = searchItem.text
        
        let API_URL = "https://itunes.apple.com/search?"
        let parameterKeyValue = "term=\(searchText)&entity=album"
        let endpoint = API_URL + parameterKeyValue
        
        println(endpoint)
        
        let url = NSURL(string: endpoint)
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (request, data, error) -> Void in
            
            //data is the information returned
            
            if let returnedInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                
                println(returnedInfo)
                
                if let responseInfo = returnedInfo["results"] as? [[String:AnyObject]] {
                    
                    if let albumUrl = responseInfo[0]["artworkUrl100"] as? String {
                        
                        println(albumUrl)
                        
                        let albumNSUrl = NSURL(string: albumUrl)
                        let imageData = NSData(contentsOfURL: albumNSUrl!)
                        let albumImage = UIImage(data: imageData!)
                        
//                        self.albumImageView.image = albumImage
                        myGlobalImage = albumImage
                        
                        self.albumImageView.image = albumImage
                        
                    }
                  
                }
            
            }
            
            
        })
      
//        let connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
 //       connection?.start()
        
        
        
            
        }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchSong()
        
    }
        
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> SongCollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SongCollectionViewCell
    
        // Configure the cell
    //  cell.textLabel?.text = foundTweets[indexPath.row]["text"] as? String
        
        cell.songImageView.image = myGlobalImage!
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

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
