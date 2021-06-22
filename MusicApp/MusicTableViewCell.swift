//
//  FavoritesTableViewCell.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 18/06/21.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    
    var onToggleFavorite: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        favoriteImage.isUserInteractionEnabled = true
        favoriteImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFavoriteClick(tapGestureRecognizer:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func onFavoriteClick(tapGestureRecognizer: UITapGestureRecognizer) {
        onToggleFavorite?()
    }

}
