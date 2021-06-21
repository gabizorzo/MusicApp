//
//  AboutViewController.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 21/06/21.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBAction func dismissButton(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    var musicCollection: MusicCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


//        coverImage.image = UIImage(named: musicCollection?.id ?? "0")
//        albumLabel.text = musicCollection?.title
//        artistLabel.text = musicCollection?.mainPerson
//        songsLabel.text = "\(musicCollection?.musics.count ?? 0) songs"
//        releasedLabel.text = "Released \(dateFormatter.string(from: musicCollection?.referenceDate ?? Date()))"
//        artistAboutLabel.text = "About \(musicCollection?.mainPerson ?? "")"
//        aboutAlbumLabel.text = musicCollection?.albumDescription
//        aboutArtistLabel.text = musicCollection?.albumArtistDescription
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumInfoTableViewCell
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            
            cell.coverImage.image = UIImage(named: musicCollection?.id ?? "0")
            cell.titleLabel.text = musicCollection?.title
            cell.artistLabel.text = musicCollection?.mainPerson
            cell.songsLabel.text = "\(musicCollection?.musics.count ?? 0) songs"
            cell.releasedLabel.text = "Released \(dateFormatter.string(from: musicCollection?.referenceDate ?? Date()))"
            cell.aboutLabel.text = musicCollection?.albumDescription
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! AristInfoTableViewCell
            
            cell.artistLabel.text = "About \(musicCollection?.mainPerson ?? "")"
            cell.aboutLabel.text = musicCollection?.albumArtistDescription

            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
