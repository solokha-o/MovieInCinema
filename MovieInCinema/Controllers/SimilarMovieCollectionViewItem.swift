//
//  SimilarMovieCollectionViewItemTrue.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 23.04.2021.
//

import Cocoa

class SimilarMovieCollectionViewItem: NSCollectionViewItem {
    
    //create outlet from all views in item
    @IBOutlet weak var similarMoviePoster: NSImageView! {
        didSet {
            similarMoviePoster.wantsLayer = true
            similarMoviePoster.layer?.cornerRadius = 20.0
        }
    }
    @IBOutlet weak var similarMovieTitleTextField: NSTextField!
    
    //set outlets of item
    func setItem(from movieModel: MovieModel) {
        similarMovieTitleTextField.stringValue = movieModel.title ?? "No title"
        guard let poster = movieModel.posterPath else { fatalError("No poster") }
        guard let link = URL(string: "https://image.tmdb.org/t/p/original" + poster) else { fatalError("Image link is not correct!") }
        //check if image in cache, if not - load it
        if cacheImage[poster] == nil {
            similarMoviePoster.load(url: link, cache: poster)
        } else {
            similarMoviePoster.image = cacheImage[poster]
        }
        print("The item with movie \(String(describing: movieModel.title)) was set.")
    }
}
