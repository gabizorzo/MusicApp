//
//  AlbumInfoTableViewCell.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 21/06/21.
//

import UIKit

class AlbumInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var songsLabel: UILabel!
    
    @IBOutlet weak var releasedLabel: UILabel!
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
