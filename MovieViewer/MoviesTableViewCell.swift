//
//  MoviesTableViewCell.swift
//  MovieViewer
//
//  Created by Daniel Ku on 3/22/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var movie: Movies! {
        didSet {
            Alamofire.request(movie.posterURL!).responseImage { (response: DataResponse<Image>) in
                if let image = response.result.value {
                    self.moviePoster.image = image
                }
            }
            title.text = movie.title
            releaseDate.text = movie.releaseDate
            genre.text = movie.category
            price.text = movie.buyPrice
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
