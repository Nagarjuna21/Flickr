//
//  FlickrFeed.swift
//  Flickr
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

import Foundation

public struct FlickrFeed: Decodable {
    public let title: String
    public let link: String
    public let mLink: String
    public let dateTaken: Date?
    public let description: String
    public let published: String?
    public let author: String?
    public let authorId: String?
    public let tags: String?

    private enum CodingKeys: CodingKey {
        case title
        case link
        case media
        case date_taken
        case description
        case published
        case author
        case author_id
        case tags
    }

    private enum SubLevelKeys: CodingKey {
        case m
    }

    public init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try map.decode(String.self, forKey: .title)
        self.link = try map.decode(String.self, forKey: .link)
        let nestedContainer = try map.nestedContainer(keyedBy: SubLevelKeys.self, forKey: .media)
        self.mLink = try nestedContainer.decode(String.self, forKey: .m)
        let dateTaken = try map.decodeIfPresent(String.self, forKey: .date_taken)
        self.dateTaken = Date.date(from: dateTaken!, formatType: .isoDateTimeSec)
        self.description = try map.decode(String.self, forKey: .description)
        self.published = try map.decodeIfPresent(String.self, forKey: .published)
        self.author = try map.decodeIfPresent(String.self, forKey: .link)
        self.authorId = try map.decodeIfPresent(String.self, forKey: .link)
        self.tags = try map.decodeIfPresent(String.self, forKey: .link)
    }

    public init(title: String,
                link: String,
                mLink: String,
                dateTaken: Date,
                description: String,
                published: String,
                author: String,
                authorId: String,
                tags: String) {
        self.title = title
        self.link = link
        self.mLink = mLink
        self.dateTaken = dateTaken
        self.description = description
        self.published = published
        self.author = author
        self.authorId = authorId
        self.tags = tags
    }
}

