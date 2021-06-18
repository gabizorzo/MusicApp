//
//  LibraryTableView.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 18/06/21.
//

import UIKit

class LibraryTableView: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var musicCollections: [MusicCollection] = try! MusicService().loadLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
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
    
    
}
