//
//  DetailsViewController.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 21/06/21.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAdaptivePresentationControllerDelegate,UINavigationControllerDelegate  {
    
    var previousScreen: LibraryTableView?
    
    @IBOutlet weak var infoButton: UIBarButtonItem!
    
    @IBAction func goToInfoButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "InfoNavigation", sender: collection)
    }
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var collectionLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var releasedLabel: UILabel!

    var collection: MusicCollection?

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nowPlayingView: NowPlayingView!
    
    @IBOutlet weak var nowPlayingViewLine: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.title = collection?.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current

        collectionLabel.text = collection?.title
        artistLabel.text = collection?.mainPerson
        numberLabel.text = "\(collection?.musics.count ?? 0) songs"
        releasedLabel.text = "Released \(dateFormatter.string(from: collection?.referenceDate ?? Date()))"
        coverImage.image = UIImage(named: collection?.id ?? "0")
        
        if collection?.type != .album {
            infoButton.isEnabled = false
        }
        
        nowPlayingView.isUserInteractionEnabled = true
        nowPlayingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playingTapped(tapGestureRecognizer:))))
        
        if nowPlayingView.music == nil {
            nowPlayingView.isHidden = true
            nowPlayingViewLine.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCollection()
        
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
        performSegue(withIdentifier: "DetailsToPlaying", sender: nowPlayingView.music)
    }
    
    func loadCollection() {
        guard let collection = collection else {return}
        let updatedCollection = LibraryTableView.service.getCollection(id: collection.id)
        self.collection = updatedCollection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection?.musics.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicTableViewCell
        
        guard let actualMusic = collection?.musics[indexPath.row] else { fatalError("Problem with finding collection") }
        let isFavorite: Bool = LibraryTableView.service.favoriteMusics.filter({ $0.id == actualMusic.id}).count > 0
        
        cell.nameLabel.text = actualMusic.title
        cell.artistLabel.text = actualMusic.artist
        cell.coverImage.image = UIImage(named: actualMusic.id)
        cell.onToggleFavorite = { [weak self] in
            LibraryTableView.service.toggleFavorite(music: actualMusic, isFavorite: !isFavorite)
            self?.tableView.reloadData()
        }
        
        if isFavorite {
            cell.favoriteImage.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        } else {
            cell.favoriteImage.image = UIImage(systemName: "heart")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let collection = collection else {return}
        
        let playMusic = collection.musics[indexPath.row]
        
        LibraryTableView.service.startPlaying(music: playMusic)
        
       viewWillAppear(false)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let collection = sender as? MusicCollection? {
        
        guard let nextViewController = segue.destination as? UINavigationController else { return }
        guard let nextScreen = nextViewController.viewControllers.first! as? AboutViewController else {return}
        
        nextScreen.musicCollection = collection
        } else if let music = sender as? Music? {
            
            guard let nextViewController = segue.destination as? UINavigationController else { return }
            guard let nextScreen = nextViewController.viewControllers.first! as? PlayingViewController else {return}
            
            nextViewController.presentationController?.delegate = self
            
            nextScreen.music = music
        }
        
        
        
    }
 
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return collection?.type == .playlist
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            LibraryTableView.service.removeMusic(collection!.musics[indexPath.row], from: collection!)
            loadCollection()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        loadCollection()
        tableView.reloadData()
    }
    

}
