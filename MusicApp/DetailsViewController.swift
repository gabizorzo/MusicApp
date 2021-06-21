//
//  DetailsViewController.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 21/06/21.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection?.musics.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicTableViewCell
        
        guard let actualMusic = collection?.musics[indexPath.row] else { fatalError("Problem with finding collection") }
        
        cell.nameLabel.text = actualMusic.title
        cell.artistLabel.text = actualMusic.artist
        cell.coverImage.image = UIImage(named: actualMusic.id)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let collection = sender as? MusicCollection? else { return }
        
        guard let nextViewController = segue.destination as? UINavigationController else { return }
        guard let nextScreen = nextViewController.viewControllers.first! as? AboutViewController else {return}
        
        nextScreen.musicCollection = collection
        
        
    }
 

}
