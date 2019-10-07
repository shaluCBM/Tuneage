//
//  HistoryTableCell.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-17.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import WebKit

enum VideoStatus:String {
    case play
    case pause
}


class HistoryTableCell: UITableViewCell,WKNavigationDelegate {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    
    
    var videoWebView: WKWebView!
    var videoStatus = VideoStatus.play
    var url : URL?
    var videoId : String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        self.videoWebView = WKWebView(frame: CGRect(origin: CGPoint.zero, size: self.containerView!.frame.size), configuration: config)
        videoWebView.navigationDelegate = self
        containerView.addSubview(videoWebView)
        
    }

    @IBAction func playBtnTapped(_ sender: UIButton) {
        switch self.videoStatus {
        case .play :
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            let html = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){ a.target.playVideo(); }</script><iframe id='playerId' type='text/html' width=\(self.containerView.frame.size.width) height=\(self.containerView.frame.size.height) src='http://www.youtube.com/embed/\(self.videoId!)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0' allowfullscreen></body></html>"
            
            videoWebView.loadHTMLString(html, baseURL: URL(string: "http://www.youtube.com"))
            videoWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            videoWebView.frame.size = containerView.frame.size
          
            self.videoStatus = .pause
        case .pause:
            playButton.setImage(UIImage(named: "play"), for: .normal)
            self.videoStatus = .play
            videoWebView.evaluateJavaScript("ytplayer.pauseVideo()", completionHandler: nil)
        }
    }
    
    
    func update(title : String,videoUrl : URL, videoId: String){
        self.titleLabel.text = title
        self.playButton.setImage(UIImage(named: "play"), for: .normal)
        self.url = videoUrl
        self.videoId = videoId
    }
    

}
