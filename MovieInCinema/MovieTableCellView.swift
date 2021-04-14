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
    @IBOutlet weak var moviePosterImageView: NSImageView!
    @IBOutlet weak var movieTitleLable: NSTextField!
    @IBOutlet weak var voteAverageLabel: NSTextField!
    //create progressive indicator
    var progressIndicator = NSProgressIndicator()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    //set outlet of cell
    func setCell(from movieModel: MovieModel) {
//        setupProgressIndicator()
        movieTitleLable.stringValue = movieModel.title ?? "No title"
        voteAverageLabel.stringValue = "TMDB - " + String(movieModel.voteAverage ?? 0.0)
        guard let poster = movieModel.posterPath else { fatalError("No poster") }
        guard let link = URL(string: "https://image.tmdb.org/t/p/original" + poster) else { fatalError("Image link is not correct!") }
        moviePosterImageView.load(url: link)
        moviePosterImageView.layer?.cornerRadius = 10.0
        moviePosterImageView.layer?.shadowOpacity = 1.0
        moviePosterImageView.layer?.shadowOffset = NSMakeSize(0, -10)
        moviePosterImageView.layer?.shadowColor = .black
        moviePosterImageView.layer?.shadowRadius = 20.0
    }
    //setup progressive indicator
    func setupProgressIndicator() {
        progressIndicator = NSProgressIndicator(frame: NSRect(x: 0, y: 0, width: 20, height: 20))
        progressIndicator.layer?.cornerRadius = 10.0
        progressIndicator.controlSize = .large
        progressIndicator.style = .spinning
        progressIndicator.frame.origin = CGPoint(x: moviePosterImageView.frame.height / 2 - 20, y: moviePosterImageView.frame.width / 2 - 20)
        moviePosterImageView.addSubview(progressIndicator)
        progressIndicator.startAnimation(nil)
    }
}
