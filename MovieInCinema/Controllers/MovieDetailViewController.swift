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
    //create array with similar movies
    private var similarMovies = [MovieModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get movie from notification centre
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: .movieDetailNotificationKay, object: nil)
        //delegate and dataSource of collection view
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.dataSource = self
    }
    //configure setup movie detail from notification centre
    @objc private func notificationReceived(_ notification: Notification) {
        guard let movie = notification.userInfo?["movieDetail"] as? MovieModel else { return }
        if let posterPath = movie.posterPath, let title = movie.title, let releaseDate = movie.releaseDate, let overview = movie.overview, let id = movie.id{
            guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original" + posterPath) else { fatalError("No correct poster link") }
            //check if image in cache, if not - load it
            if cacheImage[posterPath] == nil {
                moviePosterImageView.load(url: posterURL, cache: posterPath)
            } else {
                moviePosterImageView.image = cacheImage[posterPath]
            }
            movieTitleTextField.stringValue = title
            releaseDateTextField.stringValue = releaseDate
            overViewMovieTextField.stringValue = overview
            //create link to similar movie
            let similarMoviesLink = "https://api.themoviedb.org/3/movie/" + String(id) + "/similar?api_key=7e45f50a39e402a5a28aa506b9dc57da&language=en-US"
            //load similar movies
            DataLoader.shared.loadData(from: similarMoviesLink) { [weak self] movies in
                if let moviesList = movies.results {
                    self?.similarMovies = moviesList
                    self?.similarMoviesCollectionView.reloadData()
                    print(moviesList)
                }
            }
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
//configure extension for collection view
extension MovieDetailViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    //configure number of items in collection view
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        similarMovies.count
    }
    //configure item in collection view
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SimilarMovieCollectionViewItem"), for: indexPath) as? SimilarMovieCollectionViewItem else { return NSCollectionViewItem()}
        item.setItem(from: similarMovies[indexPath.item])
        return item
    }
}
