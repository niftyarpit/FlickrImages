//
//  StaticJson.swift
//  FlickerImages
//
//  Created by Arpit Srivastava on 16/07/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//
import Foundation

class StaticJson: StoreProtocol {
    /// Implementation of StoreProtocol method
    /// - Parameters:
    ///   - params: request parameters dictionary
    ///   - completionHandler: success or failure handler
    func fetchImagesList(using params: [String: Any], completionHandler: @escaping (_ result: FetchDataResult<PhotosList>) -> Void) {
        if let path = Bundle.init(for: StaticJson.self).path(forResource: "PhotosListData", ofType: "json") {
            do {
                let data = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let decoder = JSONDecoder()
                    let photosList = try decoder.decode(PhotosList.self, from: data as Data)
                    completionHandler(FetchDataResult.success(result: photosList))
                } catch {
                    completionHandler(FetchDataResult.failure(error: FetchDataError.cannotFetch(error.localizedDescription)))
                }
            } catch {
                completionHandler(FetchDataResult.failure(error: FetchDataError.cannotFetch(error.localizedDescription)))
            }
        } else {
            completionHandler(FetchDataResult.failure(error: FetchDataError.cannotFetch("File not found at path")))
        }
    }
}
