//
//  ViewController.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-11.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func appleMusicBtnTapped(sender : UIButton ) {
        performSegue(withIdentifier: "appleMusicSegue", sender: self)
        
    }

    
    @IBAction func googleMusicBtnTapped(sender : UIButton ) {
        performSegue(withIdentifier: "googleMusicVCSegue", sender: self)
    }
    
    
    @IBAction func viewHistoryBtnTapped(_ sender: Any) {
         performSegue(withIdentifier: "historyVCSegue", sender: self)
    }
    
    @IBAction func unWindToMainVC(storyboard : UIStoryboardSegue){
       
    }
}

