//
//  FavoritesViewController.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 18/06/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var favorites: [Music] = try! MusicService().favoriteMusics
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if favorites.isEmpty {
            tableView.removeFromSuperview()
            
            let emptyImage = UIImageView(image: UIImage(named: "emptystatefavorites"))
            
            emptyImage.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(emptyImage)
            
            NSLayoutConstraint.activate([emptyImage.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                         emptyImage.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)])
        }

        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! MusicTableViewCell
        
        let actualMusic = favorites[indexPath.row]
        
        cell.nameLabel.text = actualMusic.title
        cell.artistLabel.text = actualMusic.artist
        cell.coverImage.image = UIImage(named: actualMusic.id)
        
        return cell
    }

}
