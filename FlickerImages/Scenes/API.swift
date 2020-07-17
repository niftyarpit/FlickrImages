//
//  API.swift
//  FlickerImages
//
//  Created by Arpit Srivastava on 16/07/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//
import Foundation
class API: StoreProtocol {
    
    /// Implementation of StoreProtocol method
    /// - Parameters:
    ///   - params: request parameters dictionary
    ///   - completionHandler: success or failure handler
    func fetchImagesList(using params: [String: Any], completionHandler: @escaping (_ result: FetchDataResult<PhotosList>) -> Void) {
  //https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=YOUR_FLICKR_API_KEY&format=json&nojsoncallback=1&per_page=100&page=1&text=KEYWORD
        let text = params[Constants.searchTerm] ?? EMPTYSTRING
        let page = params[Constants.pageNumber] ?? 1
        let base = Constants.baseUrl
        let apiKey = Constants.apiKey
        let perPage = Constants.perPage
        let url = URL(string: "\(base)&api_key=\(apiKey)&format=json&nojsoncallback=1&per_page=\(perPage)&page=\(page)&text=\(text)")!
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error {
                completionHandler(FetchDataResult.failure(error: FetchDataError.cannotFetch(error.localizedDescription)))
            } else {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let photosList = try decoder.decode(PhotosList.self, from: data)
                        completionHandler(FetchDataResult.success(result: photosList))
                    } catch {
                        completionHandler(FetchDataResult.failure(error: FetchDataError.cannotFetch("Improper decoding")))
                    }
                } else {
                    completionHandler(FetchDataResult.failure(error: FetchDataError.cannotFetch("Improper data")))
                }
            }
        }
        task.resume()
    }
}
