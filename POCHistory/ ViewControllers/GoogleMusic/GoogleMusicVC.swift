//
//  GoogleMusicVC.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-13.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import WebKit

class GoogleMusicVC: UIViewController , WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var webActivityLoader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://takeout.google.com/settings/takeout")
        guard let googleUrl = url else {return}
        webView.load(URLRequest(url: googleUrl))
        
        let path = Bundle.main.path(forResource: "GoogleInstructions", ofType: "txt")
        guard let filePath = path else {return}
        let contents = try? String(contentsOfFile: filePath)
        instructionsTextView.text = contents
        
    }
    
    override func loadView() {
        super.loadView()
        webView.navigationDelegate = self
    }
    

    //MARK: - WKNavigationDelegate delegates
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webActivityLoader.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webActivityLoader.stopAnimating()
        webActivityLoader.hidesWhenStopped = true
    }
}
