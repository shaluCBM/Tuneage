//
//  WatchVideoVC.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-21.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import WebKit

class WatchVideoVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webContainerView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var items: [Item]!
    var itemIndex : Int!
    
    var videoWebView: WKWebView!
    var videoStatus = VideoStatus.play
    var url : URL?
    var videoId : String?
    var html = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoId = items[itemIndex].id.videoId
        loadImage()
        setUpViews()
        loadWebView()
        self.videoStatus = .pause
        videoWebView.navigationDelegate = self
        print("VideoId", self.videoId)
    }
    

    @IBAction func rewindBtnTapped(_ sender: Any) {
        if itemIndex == 0 {
            itemIndex = items.count
        }
        itemIndex -= 1
        loadImage()
        loadWebView()
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if itemIndex > items.count {
            itemIndex = -1
        }
        itemIndex += 1
        loadImage()
        loadWebView()
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        switch self.videoStatus {
        case .play :
            playButton.setImage(UIImage(named: "pause_black"), for: .normal)
            videoId = items[itemIndex].id.videoId
            let html = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){ a.target.playVideo(); }</script><iframe id='playerId' type='text/html' width='100%' maxwidth='\(self.webContainerView.frame.width)' height='100%' maxheight='\(self.webContainerView.frame.height)' src='https://www.youtube.com/embed/\(self.videoId!)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0' allowfullscreen></body></html>"
            videoWebView.loadHTMLString(html, baseURL: URL(string: "http://www.youtube.com"))
            videoWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            videoWebView.frame.size = webContainerView.frame.size
            self.videoStatus = .pause
        case .pause:
            print("We are here")
            playButton.setImage(UIImage(named: "play_black"), for: .normal)
            self.videoStatus = .play
            videoWebView.evaluateJavaScript("ytplayer.pauseVideo()", completionHandler: nil)
        }
    }
    
    
    func setUpViews(){
        
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        self.videoWebView = WKWebView(frame: CGRect(origin: CGPoint.zero, size: self.webContainerView!.frame.size), configuration: config)
        self.webContainerView.addSubview(videoWebView)
    }
    func loadWebView(){
        videoId = items[itemIndex].id.videoId
        navigationItem.title = items[itemIndex].snippet.title
        self.html = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReadyprint(a){ a.target.playVideo(); }</script><iframe id='playerId' type='text/html' width='100%' maxwidth='\(self.webContainerView.frame.width)' height='100%' maxheight='\(self.webContainerView.frame.height)' src='https://www.youtube.com/embed/\(self.videoId!)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0' allowfullscreen></body></html>"
        
        
        videoWebView.loadHTMLString(html, baseURL: URL(string: "http://www.youtube.com"))
        videoWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        videoWebView.frame.size = webContainerView.frame.size
    }
    
    func loadImage(){
        thumbnailImageView.getImageFromUrl(url: URL(string: items[itemIndex].snippet.thumbnails.high.url)!)
        print("Thumbanils",items[itemIndex].snippet.thumbnails.high.height,
              items[itemIndex].snippet.thumbnails.high.width)
    }
    
    
}
