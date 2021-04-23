//
//  MovieDetailViewController.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 15.04.2021.
//

import Cocoa

class MovieDetailViewController: NSViewController {
    
    //add all components of view
    @IBOutlet weak var moviePosterImageView: NSImageView! {
        didSet {
            moviePosterImageView.wantsLayer = true
            moviePosterImageView.shadow = NSShadow()
            moviePosterImageView.layer?.cornerRadius = 10.0
            moviePosterImageView.layer?.shadowOpacity = 1.0
            moviePosterImageView.layer?.shadowColor = NSColor.black.cgColor
            moviePosterImageView.layer?.shadowOffset = NSMakeSize(0, -10)
            moviePosterImageView.layer?.shadowRadius = 20
        }
    }
    @IBOutlet weak var movieTitleTextField: NSTextField!
    @IBOutlet weak var releaseDateTextField: NSTextField!
    @IBOutlet weak var overViewMovieTextField: NSTextField!
    @IBOutlet weak var similarMoviesCollectionView: NSCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get movie from notification centre
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: .movieDetailNotificationKay, object: nil)
    }
    //configure setup movie detail from notification centre
    @objc private func notificationReceived(_ notification: Notification) {
        guard let movie = notification.userInfo?["movieDetail"] as? MovieModel else { return }
        if let posterPath = movie.posterPath, let title = movie.title, let releaseDate = movie.releaseDate, let overview = movie.overview {
            guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original" + posterPath) else { fatalError("No correct poster link") }
            moviePosterImageView.load(url: posterURL)
            movieTitleTextField.stringValue = title
            releaseDateTextField.stringValue = releaseDate
            overViewMovieTextField.stringValue = overview
            print(movieTitleTextField.stringValue)
            print(releaseDateTextField.stringValue)
            print(overViewMovieTextField.stringValue)
        }
    }
    //deinitialisation notification centre
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
