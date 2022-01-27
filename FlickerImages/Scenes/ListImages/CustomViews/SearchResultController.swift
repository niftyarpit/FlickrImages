//
//  SearchResultController.swift
//  FlickerImages
//
//  Created by Arpit Srivastava on 17/07/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//

import UIKit

protocol SearchResultControllerDelegate: AnyObject {
    func didTapSearchBar(withText searchText: String)
}

class SearchResultController: UIViewController {

    weak var searchDelegate: SearchResultControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
    }
}

extension SearchResultController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        searchBar.text = text
        searchBar.resignFirstResponder()
        searchDelegate?.didTapSearchBar(withText: text)
    }
}
