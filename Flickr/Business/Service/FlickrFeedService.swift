//
//  FlickrFeedService.swift
//  Flickr
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

import Foundation

public enum ReturnType {
    case Success(success: [FlickrFeed])
    case Error(error: Error)
}
enum FakeError: Error { case generic }

public protocol FlickrFeedServiceProtocol {
    func getFlickFeedFromService(with path: String, completion: @escaping(ReturnType) -> Void)
}

public final class FlickrFeedService: FlickrFeedServiceProtocol {
    public func getFlickFeedFromService(with path: String, completion: @escaping(ReturnType) -> Void) {

        guard let url = URL(string: path) else {
            print("Error: cannot create URL")
            return completion(ReturnType.Error(error: FakeError.generic))
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                return
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                let item = try JSONSerialization.data(withJSONObject: jsonData["items"]!, options: [])
                let decoder = JSONDecoder()
                let mediaArray = try decoder.decode([FlickrFeed].self, from: item)
                DispatchQueue.main.async {
                    completion(ReturnType.Success(success: mediaArray))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(ReturnType.Error(error: error))
                }
            }
        }
        task.resume()
    }
}
