//
//  TableViewCell.swift
//  CaudalieTest
//
//  Created by Sébastien Rochelet on 31/05/2023.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    static var Identifier = "MediaTableViewCell"
    
    @IBOutlet weak var mediaImage: UIImageView!
    
    let viewModel = MediaImageViewModel()
    
    var media: Media? {
        didSet {
            guard let media = media else { return }
            if (media.artworkUrl100 != nil) {
                viewModel.getImage(imageUrl: media.artworkUrl100!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bind()
    }

    private func bind() {
        _ = viewModel.image.asObservable().bind(to: mediaImage.rx.image)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
