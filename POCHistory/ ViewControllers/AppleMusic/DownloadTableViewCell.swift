//
//  DownloadTableViewCell.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2019-01-03.
//  Copyright © 2019 Shalu Scaria. All rights reserved.
//

import UIKit
import Alamofire

class DownloadTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    weak var delegate: DownloadTableViewCellDelegate?
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        Alamofire.download(
            url,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil,
            to: destination).downloadProgress(closure: { (progress) in
            }).response(completionHandler: { (DefaultDownloadResponse) in
                self.delegate?.downloadDidFinished()
            })
    }
    
    var url = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
