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
    
    let numberArray = [1, 2, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        listMovieTableView.delegate = self
        listMovieTableView.dataSource  = self
        
        
    }
    
}
extension ListMovieViewController: NSTableViewDelegate, NSTableViewDataSource {
    //configure number of rows in tableView
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 3
    }
    //configure cell in tableView
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: nil) as? MovieTableCellView else { return NSTableCellView() }
        cell.movieTitleLable.stringValue = String(numberArray[row])
        cell.voteAverageLabel.stringValue = String(numberArray[row])
        return cell
    }
    //configure height of cell
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
    
}
