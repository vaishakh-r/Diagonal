//
//  MovieCollectionViewCell.swift
//  Diagonal
//
//  Created by Vaishakh on 4/20/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = UIImage.init(named: "placeholder_for_missing_posters")
    }
    
    
    func reloadEntity(entity: MovieModel) {
        
        if let title = entity.movieName {
            movieNameLabel.text = title
        }
        if let imageName = entity.posterImagePath {
            guard let posterImage = UIImage.init(named: imageName) else {
                movieImageView.image = UIImage.init(named: "placeholder_for_missing_posters")
                return
            }
            movieImageView.image = posterImage
        }
    }

}
