//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by Bruce Hsieh on 2022/10/26.
//

import UIKit

class ViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
//    let searchBar = UISearchBar()
    
    let mainPageView = MainPageView()
    
    func configureController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Weather🌤"
        navigationItem.searchController = searchController
//        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = .black
        searchController.searchBar.tintColor = .black
        searchController.searchBar.placeholder = "City, City code or Coordinate"
    }
    
    override func loadView() {
        super.loadView()
        view = mainPageView
    }
    
    override func viewDidLoad() {
        configureController()
    }
}

//MARK: - Extension

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Let's go")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("bye~")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("here we are")
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        <#code#>
//    }
    
}
