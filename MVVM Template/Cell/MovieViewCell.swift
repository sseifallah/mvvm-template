//
//  MovieViewCell.swift
//  MVVMDemo
//
//  Created by Seifallah Selmi on 17/06/20.
//  Copyright © 2020 Seifallah Selmi All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    var movieItem: Movie? {
        
        didSet {
            
            if let movie = movieItem {
                
                self.titleLabel.text = movie.title ?? ""
                
                self.overviewLabel.text = movie.overview ?? ""
                
                self.picture.kf.indicatorType = .activity
                self.picture.kf.setImage(with: URL(string: Domain.assest + (movie.posterPath ?? "")), placeholder: #imageLiteral(resourceName: "placeholder"), options: [.transition(.fade(1))], progressBlock: nil
                ){ (result) in
                }
            }
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
