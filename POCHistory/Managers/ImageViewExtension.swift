//
//  ImageViewExtension.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-21.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func getImageFromUrl(url : URL) {
        Services.shared.connectionManager.imageRequest(url: url, completion: { image, errorMsg in
            self.image = image
        })
    }
}
