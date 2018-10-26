//
//  FlickrFeedServiceTests.swift
//  FlickrTests
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

import Quick
import Nimble
@testable import Flickr

final class FlickrFeedServiceTests: QuickSpec {
    override func spec() {
        describe("Flickr Service Tests") {
            let flickrFeedService = FlickrFeedService()
            describe("getFlickFeedFromService(with:)") {
                context("fulfilling network perform()") {

                    context("code with single flickr feed") {
                        it("must fulfill with flickr feed") {
                            waitUntil(timeout: 5) { done in
                                flickrFeedService.getFlickFeedFromService(with: APIParams.path) { (value) in
                                    expect(value).toNot(beNil())
                                    done()
                                }
                            }

                        }
                    }
                }
            }
        }
    }
}
