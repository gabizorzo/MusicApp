//
//  FavoritesTableViewCell.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 18/06/21.
//

import UIKit
protocol FavoriteMusicDelegate {
    func toggleFavorite()
}

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    
    var delegate: FavoriteMusicDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        favoriteImage.isUserInteractionEnabled = true
        favoriteImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFavoriteClick(tapGestureRecognizer:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func onFavoriteClick(tapGestureRecognizer: UITapGestureRecognizer) {
        delegate?.toggleFavorite()
    }

}
