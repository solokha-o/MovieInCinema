//
//  MovieTableCellView.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 10.04.2021.
//

import Cocoa
import Foundation

class MovieTableCellView: NSTableCellView {
    
    //create outlet from all views in cell
    @IBOutlet weak var moviePosterImageView: NSImageView! {
        didSet {
            moviePosterImageView.wantsLayer = true
            moviePosterImageView.layer?.cornerRadius = 10.0
            moviePosterImageView.layer?.shadowOpacity = 1.0
            moviePosterImageView.layer?.shadowOffset = NSMakeSize(0, -3)
            moviePosterImageView.layer?.shadowColor = .black
            moviePosterImageView.layer?.shadowRadius = 20.0
        }
    }
    @IBOutlet weak var movieTitleTextField: NSTextField!
    @IBOutlet weak var voteAverageTextField: NSTextField!
    @IBOutlet weak var isWantWatchImageView: NSImageView!
    
    //set outlets of cell
    func setCell(from movieModel: MovieModel) {
        movieTitleTextField.stringValue = movieModel.title ?? "No title"
        voteAverageTextField.stringValue = "TMDB - " + String(movieModel.voteAverage ?? 0.0)
        guard let poster = movieModel.posterPath else { fatalError("No poster") }
        guard let link = URL(string: "https://image.tmdb.org/t/p/original" + poster) else { fatalError("Image link is not correct!") }
        //check if image in cache, if not - load it
        if cacheImage.object(forKey: poster as NSString) == nil {
            moviePosterImageView.load(url: link, cache: poster)
        } else {
            cacheImage.object(forKey: poster as NSString)
        }
        if movieModel.isWantWatch {
            isWantWatchImageView.image = NSImage(systemSymbolName: "heart.fill", accessibilityDescription: nil)
        } else {
            isWantWatchImageView.image = NSImage(systemSymbolName: "heart", accessibilityDescription: nil)
        }
        print("The cell with movie \(String(describing: movieModel.title))was set.")
    }
}
