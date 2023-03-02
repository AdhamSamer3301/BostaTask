//
//  AlbumVC.swift
//  BostaAssessment
//
//  Created by Adham Samer on 28/02/2023.
//

import Kingfisher
import UIKit

class AlbumVC: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var photosCV: UICollectionView! {
        didSet {
            photosCV.dataSource = self
            photosCV.delegate = self

            let nib = UINib(nibName: "PhotoCVCell", bundle: nil)
            photosCV.register(nib, forCellWithReuseIdentifier: "photoCVCell")
        }
    }

    var albumId: Int?
    var photos: [Photo]?
    var searchPhotos: [Photo]?
    var viewModelObj = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        viewModelObj.getPhotos(albumId: albumId ?? 0)
        viewModelObj.bindPhotosToAlbumVC = { () in
            self.renderPhotos()
            indicator.stopAnimating()
            
        }
        // Do any additional setup after loading the view.
    }
    func renderPhotos(){
        DispatchQueue.main.async {
            self.photos = self.viewModelObj.photos
            self.photosCV.reloadData()
        }
    }
}

// MARK: Collection View

extension AlbumVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos?.count ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: photosCV.frame.width / 3, height: photosCV.frame.width / 3)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCVCell", for: indexPath) as! PhotoCVCell
        cell.albumImage.kf.setImage(with: URL(string: photos?[indexPath.row].url ?? ""))
        return cell
    }
}

// MARK: Search

extension AlbumVC: UISearchBarDelegate {
}
