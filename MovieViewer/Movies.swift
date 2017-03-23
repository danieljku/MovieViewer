//
//  Movies.swift
//  MovieViewer
//
//  Created by Daniel Ku on 3/22/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class Movies: NSObject {
    var title: String?
    var posterURL: String?
    var summary: String?
    var buyPrice: String?
    var rentPrice: String?
    var link: String?
    var artist: String?
    var releaseDate: String?
    var category: String?
    
    init(movie: NSDictionary) {
        if let movieTitle = movie["im:name"] as? NSDictionary {
            title = movieTitle["label"] as? String
        }
        
        let imageArray = movie["im:image"] as! NSArray
        if let url = imageArray.object(at: 2) as? NSDictionary {
            posterURL = url["label"] as? String
        }
        
        if let movieSummary = movie["summary"] as? NSDictionary {
            summary = movieSummary["label"] as? String
        }
        
        if let moviePrice = movie["im:price"] as? NSDictionary {
            buyPrice = moviePrice["label"] as? String
        }
        
        if let movieRentPrice = movie["im:rentalPrice"] as? NSDictionary {
            rentPrice = movieRentPrice["label"] as? String
        }
        
        let links = movie["link"] as? NSArray
        if let movieDetailLink = links?.object(at: 0) as? NSDictionary {
            if let attributes = movieDetailLink["attributes"] as? NSDictionary {
                link = attributes["href"] as? String
            }
        }
        
        if let movieArtist = movie["im:artist"] as? NSDictionary {
            artist = movieArtist["label"] as? String
        }
        
        if let movieReleaseDate = movie["im:releaseDate"] as? NSDictionary {
            if let attributes = movieReleaseDate["attributes"] as? NSDictionary {
                releaseDate = attributes["label"] as? String
            }
        }
        
        if let movieCategory = movie["category"] as? NSDictionary {
            if let attributes = movieCategory["attributes"] as? NSDictionary {
                category = attributes["label"] as? String
            }
        }
    }
}
