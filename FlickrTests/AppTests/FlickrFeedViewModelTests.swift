//
//  FlickrFeedViewModelTests.swift
//  FlickrTests
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

import Quick
import Nimble
@testable import Flickr

final class FlickrFeedViewModelTests: QuickSpec {
    override func spec() {
        describe("Flickr View Model") {
            var viewModel: FlickrFeedViewModel!
            var flickrFeedViewModelDelegateMock: FlickrFeedViewModelDelegateMock!
            var serviceStub: FlickrFeedServiceProtocol!
            beforeEach {
                flickrFeedViewModelDelegateMock = FlickrFeedViewModelDelegateMock()
                serviceStub = FlickrFeedService()
            }
            describe("loadFlickrFeed()") {
                context("fulfilling flickr feed status") {
                    beforeEach {
                        viewModel = FlickrFeedViewModel(viewDelegate: flickrFeedViewModelDelegateMock,
                                                        flickrService: serviceStub)
                        viewModel.loadFlickrFeed(with: APIParams.path)
                    }
                    it("Must call refreshview") {
                        expect(flickrFeedViewModelDelegateMock.methodsCalled).toEventually(equal(["refreshView()"]))
                    }
                }
                context("rejecting flickr feed status") {
                    beforeEach {
                        viewModel = FlickrFeedViewModel(viewDelegate: flickrFeedViewModelDelegateMock,
                                                        flickrService: serviceStub)
                        viewModel.loadFlickrFeed(with: "😎")
                    }
                    it("Must show connection error") {
                        expect(flickrFeedViewModelDelegateMock.methodsCalled).toEventually(equal(["showConnectionError(with:)"]))
                    }
                }
            }
        }
    }
}

