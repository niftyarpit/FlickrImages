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

protocol StoreProtocol: class {
    func fetchImagesList(using params: [String: Any], completionHandler: @escaping (_ result: FetchDataResult<PhotosList>) -> Void)
}

class DataWorker {
    var store: StoreProtocol
    init(store: StoreProtocol) {
        self.store = store
    }
    
    func fetchImagesList(using params: [String: Any], completionHandler: @escaping (_ result: FetchDataResult<PhotosList>) -> Void) {
        store.fetchImagesList(using: params) {result in
            switch result {
            case .success(let data):
                completionHandler(FetchDataResult.success(result: data))
            case .failure(let error):
                switch error {
                case .cannotFetch(let errorMessage):
                    completionHandler(FetchDataResult.failure(error: FetchDataError.cannotFetch(errorMessage)))
                }
            }
        }
    }
}
