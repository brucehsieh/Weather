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
            convertTime()
            setLabels()
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
    
    //MARK: - Setup tempMin & tempMax label
    func setLabels() {
        if let weatherInfo = weatherInfo {
            switch mainPageView.segmentControl.selectedSegmentIndex {
            case 0:
                mainPageView.cityLabel.text = weatherInfo.name
                mainPageView.currentTempLabel.text = "\(weatherInfo.main.temp.rounded())"
                mainPageView.tempMaxLabel.text = "\(weatherInfo.main.tempMax)°C"
                mainPageView.tempMinLabel.text = "\(weatherInfo.main.tempMin)°C"
            case 1:
                mainPageView.cityLabel.text = weatherInfo.name
                mainPageView.currentTempLabel.text = "\((weatherInfo.main.temp * 9/5 + 32).rounded())"
                mainPageView.tempMaxLabel.text = "\((weatherInfo.main.tempMax * 9/5 + 32).rounded())°F"
                mainPageView.tempMinLabel.text = "\((weatherInfo.main.tempMin * 9/5 + 32).rounded())°F"
            default:
                mainPageView.cityLabel.text = weatherInfo.name
                mainPageView.currentTempLabel.text = "\(weatherInfo.main.temp.rounded())"
                mainPageView.tempMaxLabel.text = "\(weatherInfo.main.tempMax)°C"
                mainPageView.tempMinLabel.text = "\(weatherInfo.main.tempMin)°C"
            }
        }
    }
    
    //MARK: - Time
    func convertTime() {
        if let weatherInfo = weatherInfo {
            let date = Date(timeIntervalSince1970: TimeInterval((weatherInfo.dt)))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            let localTime = dateFormatter.string(from: date as Date)
            mainPageView.timeLabel.text = "\(localTime)"
            
            let sunrise = Date(timeIntervalSince1970: TimeInterval((weatherInfo.sys.sunrise)))
            let sunriseDateFormatter = DateFormatter()
            sunriseDateFormatter.timeStyle = .short
            let sunrisetime = sunriseDateFormatter.string(from: sunrise as Date)
            mainPageView.sunriseTimeLabel.text = "\(sunrisetime)"
            
            let sunset = Date(timeIntervalSince1970: TimeInterval((weatherInfo.sys.sunrise)))
            let sunsetDateFormatter = DateFormatter()
            sunriseDateFormatter.timeStyle = .short
            let sunsettime = sunsetDateFormatter.string(from: sunset as Date)
            mainPageView.sunsetTimeLabel.text = "\(sunsettime)"
        }
    }
    
    //MARK: - Get data
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

