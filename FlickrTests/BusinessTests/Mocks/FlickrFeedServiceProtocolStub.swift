//
//  FlickrFeedServiceProtocolStub.swift
//  FlickrTests
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

@testable import Flickr

struct FlickrFeedServiceProtocolStub {

    private let getFlickFeedResult: Void

    init(getFlickFeedResult: Void) {
        self.getFlickFeedResult = getFlickFeedResult
    }
}

extension FlickrFeedServiceProtocolStub: FlickrFeedServiceProtocol {

    func getFlickFeedFromService(with path: String, completion: @escaping (ReturnType) -> Void) {
        return getFlickFeedResult
    }
}
