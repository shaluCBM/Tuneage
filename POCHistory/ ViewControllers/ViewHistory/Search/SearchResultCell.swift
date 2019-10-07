//
//  SearchResultCell.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-20.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(title : String, channelTitle:String, url : URL) {
        DispatchQueue.main.async {
            self.videoImage.getImageFromUrl(url: url)
            self.videoTitle.text = title
            self.channelTitle.text = channelTitle
        }
    }

}
