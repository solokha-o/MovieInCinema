//
//  ImageLoader.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 14.04.2021.
//

import Foundation
import Cocoa

//configure extension load NSImage
extension NSImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = NSImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
