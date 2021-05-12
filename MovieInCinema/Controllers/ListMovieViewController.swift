//
//  ListMovieViewController.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 09.04.2021.
//

import Cocoa
import Network



class ListMovieViewController: NSViewController {
    
    //create outlet of NSTableView
    @IBOutlet weak var listMovieTableView: NSTableView!
    //create array of MovieModel
    private var moviesList = [MovieModel]()
    //create link to now playing movies in cinemas
    private let movieLink = "https://api.themoviedb.org/3/movie/now_playing?api_key=7e45f50a39e402a5a28aa506b9dc57da&language=en-US"
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate and dataSource of tableView
        listMovieTableView.delegate = self
        listMovieTableView.dataSource  = self
        //create monitor for checking network connection
        let monitorConnection = NWPathMonitor()
        let queue = DispatchQueue(label: "MonitorConnection")
        monitorConnection.start(queue: queue)
        //check network for available
        monitorConnection.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Mac have got connected!")
                //load movies' list from API if online
                self.loadMovies(from: self.movieLink)
            } else {
                print("No connection.")
                //get movies' list from UserDefaults if offline
                self.getMovies(for: self.movieLink)
            }
        }
    }
    //configure loading movies from API
    private func loadMovies(from link: String) {
        DataLoader.shared.loadData(from: link) { [weak self] movies in
            if let moviesList = movies.results {
                self?.moviesList = moviesList
                self?.listMovieTableView.reloadData()
                //set in notification centre first movie
                let userInfo : [AnyHashable:Any] = ["movieDetail" : moviesList.first as Any]
                NotificationCenter.default.post(name: .movieDetailNotificationKay, object: nil, userInfo: userInfo)
                print("Array with movies have loaded from API- \(moviesList)")
            }
        }
    }
    //configure getting movies from UserDefaults
    private func getMovies(for key: String) {
        let decoder = JSONDecoder()
        if let decoded = UserDefaults.standard.object(forKey: key) as? Data {
            if let movies = try? decoder.decode(MoviePeriod.self, from: decoded) {
                if let moviesList = movies.results {
                    self.moviesList = moviesList
                    DispatchQueue.main.async {
                        self.listMovieTableView.reloadData()
                        //set in notification centre first movie
                        let userInfo : [AnyHashable:Any] = ["movieDetail" : moviesList.first as Any]
                        NotificationCenter.default.post(name: .movieDetailNotificationKay, object: nil, userInfo: userInfo)
                        print("Array with movies have got from  UserDefaults - \(moviesList)")
                    }
                }
            }
        }
    }
}
extension ListMovieViewController: NSTableViewDelegate, NSTableViewDataSource {
    //configure number of rows in tableView
    internal func numberOfRows(in tableView: NSTableView) -> Int {
        return moviesList.count
    }
    //configure cell in tableView
    internal func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: nil) as? MovieTableCellView else { return NSTableCellView() }
        cell.setCell(from: moviesList[row])
        return cell
    }
    //configure height of cell
    internal func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 150  
    }
    //configure selecting row
    internal func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        // create notification that it send to other view movie
        let userInfo : [AnyHashable:Any] = ["movieDetail" : moviesList[row] as Any]
        NotificationCenter.default.post(name: .movieDetailNotificationKay, object: nil, userInfo: userInfo)
        return true
    }
    //configure movie make want to watch
    internal func tableView(_ tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableView.RowActionEdge) -> [NSTableViewRowAction] {
        switch edge {
            case .trailing, .leading:
                let wantWatchMovieAction = NSTableViewRowAction(style: .destructive, title: "Favourite to watch") { [self] (rowAction, row) in
                    moviesList[row].isWantWatch.toggle()
                    print("Movie with name - \(String(describing: moviesList[row].title)) now have favourite - \(moviesList[row].isWantWatch)")
                    listMovieTableView.reloadData()
                }
                wantWatchMovieAction.image = moviesList[row].isWantWatch ? NSImage(systemSymbolName: "heart.fill", accessibilityDescription: nil) : NSImage(systemSymbolName: "heart", accessibilityDescription: nil)
                wantWatchMovieAction.backgroundColor = moviesList[row].isWantWatch ? .green : .lightGray
                return [wantWatchMovieAction]
            @unknown default:
                fatalError()
        }
    }
}



