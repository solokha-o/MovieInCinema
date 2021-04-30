//
//  ImageLoader.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 14.04.2021.
//

import Foundation
import Cocoa

//create global dictionary for cache image
var cacheImage = [String : NSImage]()

//configure extension load NSImage
extension NSImageView {
    func load(url: URL, cache key: String) {
        //add to NSImageView progressIndicator and configure it
        let progressIndicator = NSProgressIndicator()
        progressIndicator.frame = NSRect(x: 0, y: 0, width: 40, height: 40)
        progressIndicator.layer?.position = NSPoint(x: self.frame.origin.x + self.frame.width/2, y: self.frame.origin.y + self.frame.height/2)
        progressIndicator.style = .spinning
        self.addSubview(progressIndicator)
        progressIndicator.startAnimation(nil)
        progressIndicator.isDisplayedWhenStopped = true
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = NSImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        //if image isn't in cache dictionary that add it into
                        if cacheImage[key] == nil {
                            cacheImage.updateValue(image, forKey: key)
                            print(cacheImage)
                        }
                        progressIndicator.stopAnimation(nil)
                        progressIndicator.isHidden = true
                    }
                }
            }
        }
    }
}
