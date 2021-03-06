//
//  ListImagesInteractor.swift
//  FlickerImages
//
//  Created by Arpit Srivastava on 16/07/20.
//  Copyright (c) 2020 Arpit Srivastava. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
import Foundation

protocol ListImagesBusinessLogic {
    func refresh(request: ListImages.Refresh.Request)
}

class ListImagesInteractor: ListImagesBusinessLogic {
    var presenter: ListImagesPresentationLogic?
    var worker = DataWorker(store: API())
    private var photoUrls: [URL] = []
    private var pageNumber = 1
    private var searchTerm = EMPTYSTRING
    
    //MARK: ListImagesBusinessLogic
    func refresh(request: ListImages.Refresh.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            // business logic
            if request.shouldIncreasePageNumber {
                self.pageNumber += 1
                print(self.pageNumber)
            }
            if request.searchTerm.lowercased() != self.searchTerm.lowercased() {
                self.resetStates()
                self.searchTerm = request.searchTerm
            }
            let params: [String: Any] = [Constants.searchTerm: self.searchTerm,
                                         Constants.pageNumber: self.pageNumber]
            // API call
            self.worker.fetchImagesList(using: params) { [weak self] (result: FetchDataResult) in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let fetchedData):
                    strongSelf.photoUrls.append(contentsOf: strongSelf.getPhotoUrls(from: fetchedData))
                case .failure(let error):
                    switch error {
                    case .cannotFetch(let errorMessage):
                        print(errorMessage)
                    }
                }
                DispatchQueue.main.async {
                    let response = ListImages.Refresh.Response(photoUrls: strongSelf.photoUrls)
                    strongSelf.presenter?.presentRefresh(response: response)
                }
            }
        }
    }
    
    // MARK: Private
    private func getPhotoUrls(from data: PhotosList) -> [URL] {
        let photoUrls = data.photos.photo.map { photo -> URL in
            return URL(string: "https://farm\(photo.farm).staticFlickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_m.jpg")!
        }
        return photoUrls
    }
    
    private func resetStates() {
        self.photoUrls.removeAll()
        self.pageNumber = 1
    }
}
