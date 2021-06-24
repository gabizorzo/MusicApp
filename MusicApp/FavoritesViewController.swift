//
//  FavoritesViewController.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 18/06/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIAdaptivePresentationControllerDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var favorites: [Music] = []
    
    @IBOutlet weak var nowPlayingView: NowPlayingView!
    
    @IBOutlet weak var nowPlayingViewLine: UIView!
    
    
    var playingMusic: Music?
    
    let emptyImage = UIImageView(image: UIImage(named: "emptystatefavorites"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        nowPlayingView.isUserInteractionEnabled = true
        nowPlayingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playingTapped(tapGestureRecognizer:))))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadFavorites()
        
        guard let playMusic = LibraryTableView.service.queue.nowPlaying else {
            nowPlayingViewLine.isHidden = true
            nowPlayingView.isHidden = true
            return
        }
        
        nowPlayingViewLine.isHidden = false
        nowPlayingView.isHidden = false
        nowPlayingView.music = playMusic
        nowPlayingView.artistLabel.text = playMusic.artist
        nowPlayingView.coverImage.image = UIImage(named: playMusic.id)
        nowPlayingView.songLabel.text = playMusic.title
        
        tableView.reloadData()
    }
    
    @objc func playingTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "FavoritesToPlaying", sender: nowPlayingView.music)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadFavorites()
        
        if !searchText.isEmpty {
            self.favorites = self.favorites.filter({ music in
                return music.title.lowercased().contains(searchText.lowercased()) ||  music.artist.lowercased().contains(searchText.lowercased())
            })
        }

        tableView.reloadData()
    }
    
    func loadFavorites(){
        favorites = LibraryTableView.service.favoriteMusics
        
        emptyState()
    }
    
    func emptyState() {

        if(favorites.isEmpty) {
            emptyImage.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(emptyImage)
            
            NSLayoutConstraint.activate([emptyImage.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                         emptyImage.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)])
        } else {
            emptyImage.removeFromSuperview()
        }
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
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.emptyState()
        }
        
        if isFavorite {
            cell.favoriteImage.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        } else {
            cell.favoriteImage.image = UIImage(systemName: "heart")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let playMusic = favorites[indexPath.row]
        
        LibraryTableView.service.startPlaying(music: playMusic)
        
        viewWillAppear(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let music = sender as? Music? {
            
            guard let nextViewController = segue.destination as? UINavigationController else { return }
            guard let nextScreen = nextViewController.viewControllers.first! as? PlayingViewController else {return}
            
            nextViewController.presentationController?.delegate = self
            
            nextScreen.music = music
        }
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        loadFavorites()
        tableView.reloadData()
    }
    
}
