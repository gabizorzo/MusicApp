//
//  FavoritesViewController.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 18/06/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    private var favorites: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favorites = LibraryTableView.service.favoriteMusics
        
        if favorites.isEmpty {
            createEmptyState()
        }

        tableView.dataSource = self
        
    }
    
    func createEmptyState() {
        tableView.removeFromSuperview()
        
        let emptyImage = UIImageView(image: UIImage(named: "emptystatefavorites"))
        
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(emptyImage)
        
        NSLayoutConstraint.activate([emptyImage.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                     emptyImage.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)])
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
        
        let isFavorite: Bool = LibraryTableView.service.favoriteMusics.filter({ $0.id == actualMusic.id}).count > 0
        
        cell.onToggleFavorite = { [weak self] in
            LibraryTableView.service.toggleFavorite(music: actualMusic, isFavorite: !isFavorite)
            self?.favorites.remove(at: indexPath.row)
            self?.tableView.reloadData()
            if let test = self {
                if test.favorites.isEmpty{
                    self?.createEmptyState()
                }
            }
        }
        
        if isFavorite {
            cell.favoriteImage.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        } else {
            cell.favoriteImage.image = UIImage(systemName: "heart")
        }
        
        return cell
    }

}
