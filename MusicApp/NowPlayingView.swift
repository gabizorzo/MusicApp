//
//  NowPlayingView.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 24/06/21.
//

import UIKit

class NowPlayingView: UIView {
    
    let nibName = "NowPlayingView"
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var playButton: UIImageView!
    
    var music: Music?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        self.view = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}
