//
//  DataWorker.swift
//  FlickerImages
//
//  Created by Arpit Srivastava on 16/07/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//

enum FetchDataResult<U> {
    case success(result: U)
    case failure(error: FetchDataError)
}

enum FetchDataError {
    case cannotFetch(String)
}

protocol StoreProtocol: AnyObject {
    func fetchImagesList(using params: [String: Any]) async -> FetchDataResult<PhotosList>
}

class DataWorker {
    var store: StoreProtocol
    init(store: StoreProtocol) {
        self.store = store
    }
    
    func fetchImagesList(using params: [String: Any]) async -> FetchDataResult<PhotosList> {
        await store.fetchImagesList(using: params)
    }
}
