//
//  FlickrFeedViewController.swift
//  Flickr
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

import UIKit

class FlickrFeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    lazy var flickrFeedFlowLayout : FlickrFeedFlowLayout = {
        let layout = FlickrFeedFlowLayout(display: .list)
        return layout
    }()

    lazy var viewModel: FlickrFeedViewModel = {
        return FlickrFeedViewModel(viewDelegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.loadFlickrFeed(with: APIParams.path)
        self.collectionView.collectionViewLayout = flickrFeedFlowLayout
        self.collectionView.dataSource = viewModel.dataSource
        self.refreshControl.attributedTitle = NSAttributedString(string: RefreshParams.description)
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        collectionView!.addSubview(refreshControl)
    }

    @objc func refresh(sender:AnyObject)
    {
        viewModel.loadFlickrFeed(with: APIParams.path)
    }
}

extension FlickrFeedViewController : FlickFeedViewModelDelegate {
    func showConnectionError(with message: String) {
        let alertController = UIAlertController(title: ErrorAlertParams.title,
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: ErrorAlertParams.okButton,
                                        style: .default,
                                        handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func refreshView() {
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
}
