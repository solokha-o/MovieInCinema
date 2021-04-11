//
//  MovieTableCellView.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 10.04.2021.
//

import Cocoa

class MovieTableCellView: NSTableCellView {

    //create outlet from all views in cell
    @IBOutlet weak var moviePosterImageView: NSImageView!
    @IBOutlet weak var movieTitleLable: NSTextField!
    @IBOutlet weak var voteAverageLabel: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    //set outlet of cell
    func setCell(from movieModel: MovieModel) {
        
    }
    
}
