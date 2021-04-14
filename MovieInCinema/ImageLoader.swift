//
//  ImageLoader.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 14.04.2021.
//

import Foundation
import Cocoa
import Combine

class ImageLoader: ObservableObject {
    //create NSImage
    @Published var downloadedImage: NSImage?
    //create instance for check if downloadedImage was change
    private let didChange = PassthroughSubject<ImageLoader?, Never>()
    //static link don't change
    private static let link = "https://image.tmdb.org/t/p/original"
    
    //create static instance of singleton class
    static let shared = ImageLoader()
    
    //load image from url
    func loadImage(from posterPath: String) {
        
        //create url from link
        let imageLink = ImageLoader.link + posterPath
        
        guard let imageURL = URL(string: imageLink) else {
            fatalError("Image link is not correct!")
        }
        //configure dataTask
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else {
                self.didChange.send(nil)
                print("Image not load!")
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            switch response.statusCode {
                case 200: self.downloadedImage = NSImage(data: data)
                    self.didChange.send(self)
                default:
                    print(response.statusCode)
            }
        }.resume()
    }
}
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
