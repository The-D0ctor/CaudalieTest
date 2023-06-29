//
//  ListMediaViewController.swift
//  CaudalieTest
//
//  Created by Sébastien Rochelet on 30/05/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ListMediaViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = MediaListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        configureTableView()
        bind()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: MediaTableViewCell.Identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MediaTableViewCell.Identifier)
        
    }
    
    private func configureTableView() {
        registerCell()
        tableView.rowHeight = 200
    }
    
    private func bind() {
        _ = viewModel.medias.asObservable().bind(to: tableView.rx.items(cellIdentifier: MediaTableViewCell.Identifier, cellType: MediaTableViewCell.self))
        {
            row, media, cell in
            cell.media = media
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableViewCell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! MediaTableViewCell
        let destinationVC = segue.destination as! MediaDetailsViewController
        destinationVC.popoverPresentationController?.sourceView = tableViewCell
        destinationVC.trackImage = tableViewCell.mediaImage.image
        destinationVC.trackName = tableViewCell.media?.trackName
        destinationVC.trackArtist = tableViewCell.media?.artistName
        destinationVC.trackAlbum = tableViewCell.media?.collectionName
        destinationVC.trackLink = tableViewCell.media?.trackViewUrl
        destinationVC.trackDescription = tableViewCell.media?.longDescription
    }
}

extension ListMediaViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getMediaList(title: searchBar.text)
    }
}

extension ListMediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }
}

