//
//  DownloadVC.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2019-01-02.
//  Copyright © 2019 Shalu Scaria. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON
import Alamofire

protocol DownloadTableViewDelegate: class {
    func downloadComplete()
}

class DownloadVC: UIViewController, WKUIDelegate, DownloadTableViewDelegate {
    
    var webView: WKWebView!
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var instructionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "DownloadInstructions", ofType: ".txt")
        let contents = try? String(contentsOfFile: path!)
        instructionTextView.text = contents
        
        let config = WKWebViewConfiguration()
        //run the script after a click event
        let source = "document.addEventListener('click', function(){ window.webkit.messageHandlers.iosListener.postMessage(document.documentElement.outerHTML.toString()); })"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        config.userContentController.addUserScript(script)
        config.userContentController.add(self, name: "iosListener")
        webView = WKWebView(frame: self.containerView.frame, configuration: config)
        
        webView.uiDelegate = self
        //webView.navigationDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let url = URL(string: "https://privacy.apple.com/account")!
        let request = URLRequest(url: url)
        webView.load(request)
        self.view.addSubview(webView)
    }
    
    
    func downloadComplete() {
        let alert = UIAlertController(title: "Download Complete", message:"You will be redirected to the main page" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK"
            , style: .default, handler: { action in
                self.performSegue(withIdentifier: "unwindToAppleMusicVCSegue", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// Extract link and Download zip file from json
    ///
    /// - Parameter json:
    //    func extractLink(from json: JSON) {
    //        guard json["bootData"]["isAuthenticated"].boolValue == true else { return }
    //
    //        let userRequestsId = json["bootData"]["data"]["userRequests"][0]["id"].stringValue
    //        let zonesName = json["bootData"]["data"]["userRequests"][0]["categoryRequests"][0]["zones"][0]["name"].stringValue
    //        let size = json["bootData"]["data"]["userRequests"][0]["categoryRequests"][0]["zones"][0]["size"].stringValue
    //        let requestName = json["bootData"]["data"]["userRequests"][0]["categoryRequests"][0]["name"].stringValue
    //        guard let escapedRequestName = requestName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    //
    //        let urlString = "https://privacy.apple.com/download/request/" + userRequestsId + "/zone/" + zonesName + "?f=" + escapedRequestName
    //        let url = URL(string: urlString)
    //
    //        WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ (cookie) in
    //            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
    //
    //            Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookies(cookie, for: url, mainDocumentURL: nil)
    //
    //            Alamofire.download(
    //                urlString,
    //                method: .get,
    //                parameters: nil,
    //                encoding: JSONEncoding.default,
    //                headers: nil,
    //                to: destination).downloadProgress(closure: { (progress) in
    //                }).response(completionHandler: { (DefaultDownloadResponse) in
    //                })
    //        })
    //    }
    
}

//extension ViewController: WKNavigationDelegate {
//
//    /// Not really useful, called after page loaded, not after user login
//    ///
//    /// - Parameters:
//    ///   - webView: <#webView description#>
//    ///   - navigation: <#navigation description#>
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("document.getElementById('app_config').textContent") {data, error in
//            guard let jsonString = data as? String else { return }
//
//            guard let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) else { return }
//
//            do {
//                let json = try JSON(data: dataFromString)
//                //self.extractLink(from: json)
//            } catch {
//                print("Error JSON: \(error)")
//            }
//        }
//    }
//}

extension DownloadVC: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        //User has login successfully and click the get your data link
        if let htmlString = message.body as? String, htmlString.contains("Data downloads are not supported on this device.") {
            //refresh to start download
            webView.reload()
            
            WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ (cookie) in
                let url = URL(string: "https://privacy.apple.com/section")
                
                Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookies(cookie, for: url, mainDocumentURL: nil)
                
                Alamofire.request("https://privacy.apple.com/section").responseJSON { response in
                    
                    if let value = response.result.value {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DownloadViewController") as! DownloadTableVC
                        vc.delegate = self
                        let json = JSON(value)
                        let requestArray = json["userRequests"].arrayValue
                        //print("requestArray", requestArray)
                        let filteredrequests = requestArray.filter({ (json) -> Bool in
                            var hasAppleMusicRequest = false
                            
                            for categoryRequest in json["categoryRequests"].arrayValue {
                                if categoryRequest["name"].stringValue == "Apple Media Services information" {
                                    hasAppleMusicRequest = true
                                    break
                                }
                            }
                            
                            return hasAppleMusicRequest
                        })
                        
                        vc.resources = filteredrequests
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                }
            })
            
            
            
            //TODO: make API call to https://privacy.apple.com/section, let user choose which one to download, generate the download link and start downloading
            //            webView.evaluateJavaScript("document.getElementById('app_config').textContent") {data, error in
            //
            //                guard let jsonString = data as? String else { return }
            //
            //                guard let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) else { return }
            //
            //                do {
            //                    let json = try JSON(data: dataFromString)
            //                    self.extractLink(from: json)
            //                } catch {
            //                    print("Error JSON: \(error)")
            //                }
            //            }
        }
    }
}

