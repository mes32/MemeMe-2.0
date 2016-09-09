//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Michael Stockman on 9/4/16.
//  Copyright © 2016 Michael Stockman.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //saveButton.enabled = false
        //cameraButton.enabled = false
    }

    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/

    @IBAction func pressedSaveButton(sender: AnyObject) {
        print("Pressed save button")
    }
    
    @IBAction func pressedCameraButton(sender: AnyObject) {
        print("Pressed camera button")
    }
    
    @IBAction func pressedPhotoAlbumButton(sender: AnyObject) {
        print("Pressed photo album button")
    }

}

