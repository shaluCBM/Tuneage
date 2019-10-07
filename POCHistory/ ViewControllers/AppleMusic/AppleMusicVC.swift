//
//  WebViewController.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-11.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class AppleMusicVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func requestHistoryBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "requestVCSegue", sender: self)
    }
    
    
    @IBAction func processHistoryBtnTapped(_ sender: Any) {
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let uploadAction = UIAlertAction(title: "Upload", style: .default, handler: { action in
            self.performSegue(withIdentifier: "documentBrowserVCSegue", sender: self)
        })
        uploadAction.setValue(UIImage(named: "Upload")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let downloadAction = UIAlertAction(title: "Download", style: .default, handler: { action in
            self.performSegue(withIdentifier: "downloadVCSegue", sender: self)
        })
        downloadAction.setValue(UIImage(named: "Download")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(uploadAction)
        sheet.addAction(downloadAction)
        sheet.addAction(cancelAction)
        
        self.present(sheet, animated: true, completion: nil)
    }
    
    
    @IBAction func unWindToAppleMusicVC(storyboard : UIStoryboardSegue){
        
    }
}

