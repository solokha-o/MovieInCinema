//
//  ListMovieViewController.swift
//  MovieList
//
//  Created by Oleksandr Solokha on 09.04.2021.
//

import Cocoa

class ListMovieViewController: NSViewController {

   
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
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: nil) as? NSTableCellView else { return NSTableCellView() }
        cell.textField?.stringValue = String(numberArray[row])
        
        return cell
    }
    
}
