//
//  Constants.swift
//  Flickr
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

enum APIParams {
    static let path = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
}

enum ErrorAlertParams {
    static let title = "Error"
    static let okButton = "Ok"
}

enum RefreshParams {
    static let description = "Pull to refresh"
}

enum FatalErrorParams {
    static let cellNotExists = "Cell not exists in storyboard"
}

enum IdentifersParams {
    static let cellIdentifier = "flickrFeedCell"
}
