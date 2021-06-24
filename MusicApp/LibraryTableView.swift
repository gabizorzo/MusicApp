//
//  LibraryTableView.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 18/06/21.
//

import UIKit

class LibraryTableView: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    public static var service: MusicService = try! MusicService()
    
    private var musicCollections: [MusicCollection] = service.loadLibrary()
    
    
    @IBOutlet weak var nowPlayingView: NowPlayingView!
    
    @IBOutlet weak var nowPlayingViewLine: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryItem", for: indexPath) as! LibraryTableViewCell
        
        let actualMusic = musicCollections[indexPath.row]
        
        cell.titleLabel.text = actualMusic.title
        cell.artistLabel.text = actualMusic.mainPerson
        cell.coverImage.image = UIImage(named: actualMusic.id)
        cell.typeLabel.text = actualMusic.type.rawValue
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailNavigation", sender: musicCollections[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let collection = sender as? MusicCollection else { return }
        
        guard let nextViewController = segue.destination as? DetailsViewController else { return }
        nextViewController.collection = collection
        
        nextViewController.previousScreen = self
        
    }
    
    
    
}
