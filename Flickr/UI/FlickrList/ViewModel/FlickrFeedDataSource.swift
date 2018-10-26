//
//  FlickrFeedDataSource.swift
//  Flickr
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

import Foundation
import UIKit

final class FlickrFeedDataSource: NSObject {

    weak var viewModel: FlickrFeedViewModel!
    private let dateFormatter = DateFormatter()

    init(viewModel: FlickrFeedViewModel) {
        self.viewModel = viewModel
    }
}

extension FlickrFeedDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdentifersParams.cellIdentifier,
                                                            for: indexPath) as? FlickrFeedCell
            else { fatalError(FatalErrorParams.cellNotExists) }
        let rowItems = viewModel.items[indexPath.row]
        cell.title.text = rowItems.title
        if let imageLink = URL(string: rowItems.mLink) {
            cell.imageView.setImageViewWithUrl(url: imageLink)
            let imageData = try? Data(contentsOf: imageLink)
            if let imageMetaData = viewModel.getImageMetaData(data: imageData! as NSData) {
                cell.densityRGB.text = imageMetaData.colorModel + " D:" + String(imageMetaData.depth)
                cell.widthHeight.text = String(imageMetaData.pixelWidth) + "x" + String(imageMetaData.pixelHeight)
                print(imageMetaData)
            }
        } else {
            // MARK: Show PlaceHolder Image
        }
        dateFormatter.dateFormat = Date.DateFormatType.isoDate.rawValue
        if let date_taken = rowItems.dateTaken {
            cell.dateTaken.text = dateFormatter.string(from: date_taken)
        }
        cell.backgroundColor = UIColor.green
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
}
