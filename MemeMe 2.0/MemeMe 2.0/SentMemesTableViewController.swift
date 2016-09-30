//
//  SentMemesTableViewController.swift
//  MemeMe 2.0
//
//  Created by Michael Stockman on 9/28/16.
//  Copyright © 2016 Michael Stockman.
//

import UIKit

// MARK: - ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    // MARK: Properties
    
    var memes = [Meme]()

    
    override func viewDidLoad() {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    // MARK: Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        
        let meme = memes[indexPath.row]
        
        // Set the text and image
        cell.textLabel?.text = meme.textTop
        cell.imageView?.image = meme.image
        
        return cell
    }
    
    @IBAction func pressedEditButton(_ sender: UIBarButtonItem) {
        print("pressedEditButton")
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("VillainDetailViewController") as! VillainDetailViewController
        detailController.villain = self.allVillains[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)*/
        
        print("selected: \(indexPath)")
        
    }
}
