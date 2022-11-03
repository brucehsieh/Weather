//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by Bruce Hsieh on 2022/10/26.
//

import UIKit

class ViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)

    let mainPageView = MainPageView()
    
    var weatherInfo: WeatherData? {
        didSet{
            
        }
    }
    
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
    
    func getWeatherPNG(png: String) -> Data{
        var imageData: Data!
        if let url = URL(string: "http://openweathermap.org/img/wn/\(png).png"){
            let data = try? Data(contentsOf: url)
            if let image = data{
                imageData = image
            }
        }
        return imageData
    }
    

    func getWeatherData(city: String) {
        guard var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") else { return }
        let params: [String: String] = [
            "appid": "4a73261bd7f25c8b983715a2a9f1874a",
            "q": city
        ]
        urlComponents.queryItems = params.map {URLQueryItem(name: $0.key, value: $0.value)}
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    print("============== Weather data ==============")
                    print(weatherData)
                    print("============== Weather data ==============")
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    //MARK: - lifecycle
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        print(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("see ya")
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
