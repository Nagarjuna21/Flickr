//
//  FlickrFeedViewModelDelegateMock.swift
//  FlickrTests
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

@testable import Flickr

final class FlickrFeedViewModelDelegateMock: FlickFeedViewModelDelegate {

    var methodsCalled = [String]()

    func showConnectionError(with message: String) {
        methodsCalled.append(#function)
    }

    func refreshView() {
        methodsCalled.append(#function)
    }
}
