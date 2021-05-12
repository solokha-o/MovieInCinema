//
//  MovieDetailViewController.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 15.04.2021.
//

import Cocoa
import Network

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
            if cacheImage.object(forKey: posterPath as NSString) == nil {
                moviePosterImageView.load(url: posterURL, cache: posterPath)
            } else {
                moviePosterImageView.image = cacheImage.object(forKey: posterPath as NSString)
            }
            movieTitleTextField.stringValue = title
            releaseDateTextField.stringValue = releaseDate
            overViewMovieTextField.stringValue = overview
            //create link to similar movie
            let similarMoviesLink = "https://api.themoviedb.org/3/movie/" + String(id) + "/similar?api_key=7e45f50a39e402a5a28aa506b9dc57da&language=en-US"
            //create monitor for checking network connection
            let monitorConnection = NWPathMonitor()
            let queue = DispatchQueue(label: "MonitorConnection")
            monitorConnection.start(queue: queue)
            //check network for available
            monitorConnection.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    print("Mac have got connected!")
                    //load movies' list from API if online
                    self.loadMovies(from: similarMoviesLink)
                } else {
                    print("No connection.")
                    //get movies' list from UserDefaults if offline
                    self.getMovies(for: similarMoviesLink)
                }
            }
            print("MovieDetailViewController have set with movie - \(String(describing: movie.title))")
        }
    }
    //configure loading similar movies from API
    private func loadMovies(from link: String) {
        DataLoader.shared.loadData(from: link) { [weak self] movies in
            if let similarMovies = movies.results {
                self?.similarMovies = similarMovies
                self?.similarMoviesCollectionView.reloadData()
                print("Array with movies have loaded from API- \(similarMovies)")
            }
        }
    }
    //configure getting similar movies from UserDefaults
    private func getMovies(for key: String) {
        let decoder = JSONDecoder()
        if let decoded = UserDefaults.standard.object(forKey: key) as? Data {
            if let movies = try? decoder.decode(MoviePeriod.self, from: decoded) {
                if let similarMovies = movies.results {
                    self.similarMovies = similarMovies
                    DispatchQueue.main.async {
                        self.similarMoviesCollectionView.reloadData()
                    }
                    print("Array with movies have got from  UserDefaults - \(similarMovies)")
                }
            }
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
    internal func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        similarMovies.count
    }
    //configure item in collection view
    internal func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SimilarMovieCollectionViewItem"), for: indexPath) as? SimilarMovieCollectionViewItem else { return NSCollectionViewItem()}
        item.setItem(from: similarMovies[indexPath.item])
        return item
    }
}
