//
//  ViewController.swift
//  BostaAssessment
//
//  Created by Adham Samer on 28/02/2023.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet var albumsTable: UITableView! {
        didSet {
            albumsTable.delegate = self
            albumsTable.dataSource = self
        }
    }

    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    var albums: [Album] = []
    var address: Address?
    var vm: ViewModel?
    let dispatch = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        vm = ViewModel()
        vm?.getUser(id: 1)
        dispatch.enter()
        vm?.bindUserToHomeVC = { () in
            self.renderUser()
            self.dispatch.leave()
        }
        vm?.getAlbums(userID: 1)
        dispatch.enter()
        vm?.bindAlbumsToHomeVC = { () in
            self.renderData()
            self.dispatch.leave()
        }
        albumsTable.reloadData()
        dispatch.notify(queue: .main) {
            indicator.stopAnimating()
            self.albumsTable.reloadData()
        }
        
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "My Albums"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let tmp = albums[indexPath.row]
        cell.textLabel?.text = tmp.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumsVC = self.storyboard?.instantiateViewController(withIdentifier: "albumVC") as! AlbumVC
        albumsVC.albumId = albums[indexPath.row].id
        albumsVC.albumName = albums[indexPath.row].title
        self.navigationController?.pushViewController(albumsVC, animated: true)
    }
}

extension HomeVC {
    func renderData() {
        DispatchQueue.main.async {
            self.albums = self.vm?.albums ?? []
        }
    }

    func renderUser() {
        address = vm?.user?.address
        nameLabel.text = "Welcome, " + (vm?.user?.name ?? "")
        addressLabel.text = "Address: " + (address?.city)! + ", " + (address?.street)! + ", " + (address?.suite)! + ", " + (address?.zipcode)!
        // self.viewDidLoad()
//            self.addressLabel.text = self.vm?.user?.address.
    }
}
