//
//  SentMemesViewController.swift
//  MemeMe 2.0
//
//  Created by Onyinyechukwu Uchime on 9/25/16.
//  Copyright © 2016 Michael Stockman. All rights reserved.
//

import UIKit

class SentMemesViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        print("editButtonPresed()")
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addMemeSegue", sender: nil)
    }
    
}
