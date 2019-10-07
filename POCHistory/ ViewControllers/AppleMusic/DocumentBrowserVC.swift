//
//  DocumentBrowserVC.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-13.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class DocumentBrowserVC: UIDocumentBrowserViewController,UIDocumentBrowserViewControllerDelegate, UIDocumentInteractionControllerDelegate{
    
    var sourceURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
    
    func presentDocument(at documentURL: URL){
        let documentView = UIDocumentInteractionController(url: documentURL)
        documentView.delegate = self
        documentView.presentPreview(animated: true)
    }
    
    //MARK: - UIDocumentBrowserViewControllerDelegate
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return}
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        let alert = UIAlertController(title: "Error", message: "File import has been failed", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .destructive , handler: nil )
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
   
    //MARK: - UIDocumentInteractionControllerDelegate delegates
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}
