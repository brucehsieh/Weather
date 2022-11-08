//
//  MainPageView.swift
//  SimpleWeatherApp
//
//  Created by Bruce Hsieh on 2022/10/27.
//

import UIKit
import SnapKit

class MainPageView: UIView {
    //MARK: - Properties
    private let gradientLayer = CAGradientLayer()

    var weatherInfo: WeatherData?
    
    //MARK: - UI
    let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = " "
        label.font = UIFont(name: "Arial", size: 50)
        label.textAlignment = .center
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = " "
        label.font = UIFont(name: "Arial", size: 25)
        label.textAlignment = .center
        return label
    }()
    
    let weatherImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: "01.jpg")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let currentTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        //        label.text = "30°C"
        label.font = UIFont(name: "Arial", size: 50)
        label.textAlignment = .center
        return label
    }()
    
    let minLabel:UILabel = {
        let label = UILabel()
        label.text =  "Temp Min"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let tempMinLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var tempMinStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minLabel, tempMinLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let maxLabel:UILabel = {
        let label = UILabel()
        label.text =  "Temp Max"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    lazy var tempMaxStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [maxLabel, tempMaxLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let riseLabel:UILabel = {
        let label = UILabel()
        label.text =  "Sunrise"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var sunriseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [riseLabel, sunriseTimeLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let setLabel:UILabel = {
        let label = UILabel()
        label.text =  "Sunset"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var sunsetStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [setLabel, sunsetTimeLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempMinStackView, tempMaxStackView, sunriseStackView, sunsetStackView])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let items = ["°C", "°F"]
    
    lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 9
        control.layer.borderWidth = 1
        control.layer.masksToBounds = true
        control.layer.borderColor = UIColor.white.cgColor
        control.tintColor = UIColor.white
        control.addTarget(self, action: #selector(tempUnitChanged), for: .valueChanged)
        return control
    }()
    
    @objc func tempUnitChanged(_ segmentControl: UISegmentedControl) {
        if let weatherInfo = weatherInfo{
        if segmentControl.selectedSegmentIndex == 0 {
            cityLabel.text = weatherInfo.name
            currentTempLabel.text = "\(weatherInfo.main.temp.rounded())°C"
            tempMaxLabel.text = "\(weatherInfo.main.tempMax)°C"
            tempMinLabel.text = "\(weatherInfo.main.tempMin)°C"
        }else{
            cityLabel.text = weatherInfo.name
            currentTempLabel.text = "\((weatherInfo.main.temp * 9/5 + 32).rounded())°F"
            tempMaxLabel.text = "\((weatherInfo.main.tempMax * 9/5 + 32).rounded())°F"
            tempMinLabel.text = "\((weatherInfo.main.tempMin * 9/5 + 32).rounded())°F"
        }
    }
}
    private func setGradientLayer() {
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.white.cgColor
        ]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    //MARK: - Functions
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
        setGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    //MARK: - Autolayouts
    func setLayouts() {
        addSubview(cityLabel)
        cityLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(240)
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints{ make in
            make.top.equalTo(cityLabel.snp.bottom)
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(weatherImage)
        weatherImage.snp.makeConstraints{ make in
            make.top.equalTo(timeLabel.snp.bottom).offset(40)
            make.height.equalTo(300)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(currentTempLabel)
        currentTempLabel.snp.makeConstraints{ make in
            make.top.equalTo(weatherImage.snp.bottom).offset(40)
            make.height.equalTo(64)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(segmentControl)
        segmentControl.snp.makeConstraints{ make in
            make.top.equalTo(currentTempLabel.snp.bottom)
            make.height.equalTo(24)
            make.centerX.equalToSuperview()
        }
        
        addSubview(labelStackView)
        labelStackView.snp.makeConstraints{ make in
            make.top.equalTo(segmentControl.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
