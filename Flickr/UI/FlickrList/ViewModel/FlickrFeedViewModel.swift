//
//  FlickrFeedViewModel.swift
//  Flickr
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

import Foundation
import UIKit

protocol FlickFeedViewModelDelegate {
    func showConnectionError(with message: String)
    func refreshView()
}

final class FlickrFeedViewModel {
    private lazy var flickrService: FlickrFeedServiceProtocol = {
        return FlickrFeedService()
    }()

    struct ImageMetaData: Codable {
        let colorModel: String
        let depth: Int
        let pixelHeight: Int
        let pixelWidth: Int
    }

    var delegate: FlickFeedViewModelDelegate?
    var items = [FlickrFeed]()
    let numberOfSections: Int = 1

    var numberOfRows: Int {
        return items.count
    }
    lazy var dataSource: FlickrFeedDataSource = {
        return FlickrFeedDataSource(viewModel: self)
    }()

    init(viewDelegate: FlickFeedViewModelDelegate?,
         flickrService: FlickrFeedServiceProtocol? = nil) {
        if let flickrService = flickrService {
            self.flickrService = flickrService
        }
        self.delegate = viewDelegate
    }

    public func loadFlickrFeed(with path: String) {
        flickrService.getFlickFeedFromService(with: path) {
            response in
            switch response {
            case .Success(let section):
                self.items = section
                self.delegate?.refreshView()
            case .Error(let error):
                self.delegate?.showConnectionError(with: error.localizedDescription)
            }
        }
    }

    public func getImageMetaData(data: NSData) -> ImageMetaData? {
        if let source: CGImageSource = CGImageSourceCreateWithData(data, nil) {
            if let imageMetaData: NSDictionary = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) {
                let imageMetaData = ImageMetaData(
                    colorModel: imageMetaData[kCGImagePropertyColorModel] as! String,
                    depth: imageMetaData[kCGImagePropertyDepth] as! Int,
                    pixelHeight: imageMetaData[kCGImagePropertyPixelHeight] as! Int,
                    pixelWidth: imageMetaData[kCGImagePropertyPixelWidth] as! Int)
                return imageMetaData
            }
        }
        return nil
    }
}
