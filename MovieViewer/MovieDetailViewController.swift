//
//  MovieDetailViewController.swift
//  MovieViewer
//
//  Created by Daniel Ku on 3/22/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var summary: UILabel!
    
    var movie: Movies!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        titleLabel.text = movie.title
        
        releaseDate.text = movie.releaseDate
        
        if let buyPrice = movie.buyPrice {
            buyLabel.text = "\(buyPrice) to Buy"
        }else {
            buyLabel.text = "Not available to Buy"
        }
        
        if let rentPrice = movie.rentPrice {
            rentLabel.text = "\(rentPrice) to Rent"
        }else {
            rentLabel.text = "Not available to Rent"
        }
        
        Alamofire.request(movie.posterURL!).responseImage { (response: DataResponse<Image>) in
            if let image = response.result.value {
                self.moviePoster.image = image
            }
        }
        
        summary.text = movie.summary
    }

    @IBAction func goToITunesStore(_ sender: Any) {
        if let url = URL(string: movie.link!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
