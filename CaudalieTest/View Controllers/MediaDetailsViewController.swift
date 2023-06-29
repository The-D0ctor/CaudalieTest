//
//  MediaDetailsViewController.swift
//  CaudalieTest
//
//  Created by Sébastien Rochelet on 31/05/2023.
//

import UIKit

class MediaDetailsViewController: UIViewController {
    var trackImage: UIImage?
    var trackName: String?
    var trackArtist: String?
    var trackAlbum: String?
    var trackLink: String?
    var trackDescription: String?
    
    @IBOutlet weak var mediaImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var albumLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var linkButton: UIButton!
    
    @IBAction func linkButtonAction(_ sender: UIButton) {
        if let url = URL(string: trackLink ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mediaImageView.image = trackImage
        nameLabel.text = trackName
        artistLabel.text = trackArtist
        albumLabel.text = trackAlbum
        descriptionLabel.text = trackDescription
        linkButton.setTitle(trackLink, for: .normal)
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
