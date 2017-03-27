//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Daniel Ku on 3/21/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Alamofire

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!

    var moviesList = [Movies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        self.navigationItem.backBarButtonItem = backItem
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        moviesTableView.estimatedRowHeight = 100
        moviesTableView.rowHeight = UITableViewAutomaticDimension
        
        requestMovies()
    }
    
    func requestMovies() {
        Alamofire.request("https://itunes.apple.com/us/rss/topmovies/limit=25/json").responseJSON { (response: DataResponse<Any>) in
            let movies = response.result.value as! NSDictionary
            let feedDict = movies["feed"] as! NSDictionary
            let entryDict = feedDict["entry"] as! NSArray
            for entry in entryDict{
                let movie = Movies(movie: entry as! NSDictionary)
                self.moviesList.append(movie)
            }
            self.moviesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetailVC"{
            let indexPath = moviesTableView.indexPathForSelectedRow
            let currentCell = moviesTableView.cellForRow(at: indexPath!) as! MoviesTableViewCell
            
            let movieDetailVC = segue.destination as! MovieDetailViewController
            
            movieDetailVC.movie = currentCell.movie
        }
    }
}


extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesList.count != 0 {
            return moviesList.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell
        
        cell.selectionStyle = .none
        
        let movie = moviesList[indexPath.row]
        cell.movie = movie
        
        return cell
    }
}
