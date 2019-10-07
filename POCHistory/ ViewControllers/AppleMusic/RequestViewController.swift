//
//  RequestViewController.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-12.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import WebKit

class RequestViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var webLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    
    let customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "Instructions", ofType: ".txt")
        let contents = try? String(contentsOfFile: path!)
        instructionsTextView.text = contents
        
        
        let url = URL(string: "https://privacy.apple.com/")!
        let request = URLRequest(url: url)
        webView.customUserAgent = customUserAgent
        webView.load(request)
        
        
        webView.evaluateJavaScript("navigator.userAgent") { [weak webView] (result, error) in
            if let webView = webView, let userAgent = result as? String {
                print("user agent", userAgent)
                //webView.customUserAgent = userAgent + "/Custom Agent"
            }
        }
        webView.scrollView.showsVerticalScrollIndicator = true
        
    }
    
    
    override func loadView() {
        super.loadView()
        webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webLoadingIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webLoadingIndicator.stopAnimating()
        webLoadingIndicator.hidesWhenStopped = true
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webLoadingIndicator.stopAnimating()
        webLoadingIndicator.hidesWhenStopped = true
        let alert = UIAlertController(title: "Error Occured", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK"
            , style: .default, handler: { action in
                self.performSegue(withIdentifier: "unwindToMainVCSegue", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        let alert = UIAlertController(title: "Signed Out", message:"You will be redirected to the main page" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK"
            , style: .default, handler: { action in
                self.performSegue(withIdentifier: "unwindToMainVCSegue", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

