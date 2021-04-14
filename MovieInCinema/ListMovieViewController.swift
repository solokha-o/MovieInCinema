//
//  ListMovieViewController.swift
//  MovieList
//
//  Created by Oleksandr Solokha on 09.04.2021.
//

import Cocoa

class ListMovieViewController: NSViewController {
    
    //create outlet of NSTableView
    @IBOutlet weak var listMovieTableView: NSTableView!
    //create array of MovieModel
    var moviesList = [MovieModel]()
    //create link to now playing movies in cinemas
    let movieLink = "https://api.themoviedb.org/3/movie/now_playing?api_key=7e45f50a39e402a5a28aa506b9dc57da&language=en-US"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate and dataSource of tableView
        listMovieTableView.delegate = self
        listMovieTableView.dataSource  = self
        //load movies' list
        DataLoader.shared.loadData(from: movieLink) { [weak self] movies in
            if let moviesList = movies.results {
                self?.moviesList = moviesList
                self?.listMovieTableView.reloadData()
                print(moviesList)
            }
        }
    }
}
extension ListMovieViewController: NSTableViewDelegate, NSTableViewDataSource {
    //configure number of rows in tableView
    func numberOfRows(in tableView: NSTableView) -> Int {
        return moviesList.count
    }
    //configure cell in tableView
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: nil) as? MovieTableCellView else { return NSTableCellView() }
        cell.setCell(from: moviesList[row])
        return cell
    }
    //configure height of cell
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 150
    }
}
