//
//  ImageLoader.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 14.04.2021.
//

import Foundation
import Cocoa

//create global NSCache instance for cache image
public var cacheImage = NSCache<NSString, NSImage>()

//configure extension load NSImage
extension NSImageView {
    public func load(url: URL, cache key: String) {
        //set self image to nil before load image from url
        self.image = nil
        //add to NSImageView progressIndicator and configure it
        let progressIndicator = NSProgressIndicator()
        progressIndicator.frame = NSRect(x: self.bounds.origin.x + self.bounds.width/2 - 40, y: self.bounds.origin.y + self.bounds.height/2 - 20, width: 40, height: 40)
        progressIndicator.style = .spinning
        self.addSubview(progressIndicator)
        progressIndicator.startAnimation(nil)
        progressIndicator.isDisplayedWhenStopped = true
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = NSImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        //if image isn't in cache that add it into
                        if cacheImage.object(forKey: key as NSString) == nil {
                            cacheImage.setObject(image, forKey: key as NSString)
                            print("Image \(image) save to cacheImage with key - \(key)")
                            //save cache of images to UserDefaults for offline mode
                            if let data = try? NSKeyedArchiver.archivedData(withRootObject: cacheImage, requiringSecureCoding: false) {
                                UserDefaults.standard.set(data, forKey: "cacheImage")
                            }
                        }
                        progressIndicator.stopAnimation(nil)
                        progressIndicator.isHidden = true
                    }
                } else {
                    fatalError("Image have got error!")
                }
            }
        }
    }
}
