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
    func fetchImagesList(using params: [String: Any]) async -> FetchDataResult<PhotosList> {
        //https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=YOUR_FLICKR_API_KEY&format=json&nojsoncallback=1&per_page=100&page=1&text=KEYWORD
        let text = params[Constants.searchTerm] ?? EMPTYSTRING
        let page = params[Constants.pageNumber] ?? 1
        let base = Constants.baseUrl
        let apiKey = Constants.apiKey
        let perPage = Constants.perPage
        let url = URL(string: "\(base)&api_key=\(apiKey)&format=json&nojsoncallback=1&per_page=\(perPage)&page=\(page)&text=\(text)")!
        var fetchedData: Data?
        if #available(iOS 15.0, *) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                fetchedData = data
            } catch {
                return FetchDataResult.failure(error: FetchDataError.cannotFetch(error.localizedDescription))
            }
        } else {
            do {
                let (data, _) = try await self.data(from: url)
                fetchedData = data
            } catch {
                return FetchDataResult.failure(error: FetchDataError.cannotFetch(error.localizedDescription))
            }
        }

        guard let fetchedData = fetchedData else {
            return FetchDataResult.failure(error: FetchDataError.cannotFetch("Improper fetchedData"))
        }

        do {
            let decoder = JSONDecoder()
            let photosList = try decoder.decode(PhotosList.self, from: fetchedData)
            return FetchDataResult.success(result: photosList)
        } catch {
            return FetchDataResult.failure(error: FetchDataError.cannotFetch("Improper decoding"))
        }
    }

    private func data(from url: URL) async throws -> (Data, URLResponse) {
         try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                 guard let data = data, let response = response else {
                     let error = error ?? URLError(.badServerResponse)
                     return continuation.resume(throwing: error)
                 }
                 continuation.resume(returning: (data, response))
             }
             task.resume()
        }
    }
}

