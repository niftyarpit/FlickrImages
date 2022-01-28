//
//  ImageDetailsRouter.swift
//  FlickerImages
//
//  Created by Arpit Srivastava on 28/01/22.
//  Copyright (c) 2022 Arpit Srivastava. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ImageDetailsRoutingLogic: AnyObject {
}

protocol ImageDetailsDataPassing: AnyObject {
    var dataStore: ImageDetailsDataStore? { get }
}

final class ImageDetailsRouter: ImageDetailsRoutingLogic, ImageDetailsDataPassing {
    weak var viewController: ImageDetailsViewController?
    var dataStore: ImageDetailsDataStore?
}
