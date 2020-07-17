//
//  ListImagesModels.swift
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

enum ListImages {
    // MARK: Use cases
    
    enum Refresh {
        struct Request {
            var searchTerm: String
            var shouldIncreasePageNumber: Bool
        }
        struct Response {
            var photoUrls: [URL]
        }
        struct ViewModel {
            var photoUrls: [URL]
        }
    }
}

struct PhotosList: Decodable {
    let photos: Photos
    let stat: String
}

struct Photos: Decodable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}

struct Photo: Decodable {
    let title, id, owner, secret, server: String
    let farm, ispublic, isfriend, isfamily: Int
}

