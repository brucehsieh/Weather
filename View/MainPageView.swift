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
    
    //MARK: - UI
    let coutryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
                label.text = "Taiwan"
        label.font = UIFont(name: "Arial", size: 50)
        label.textAlignment = .center
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "3:30 PM"
        label.font = UIFont(name: "Arial", size: 25)
        label.textAlignment = .center
        return label
    }()
    
    let weatherImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: "01.jpg")
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
    
    let tempMinLabel: UILabel = {
        let label = UILabel()
        //        label.text = "TEMP MIN"
        return label
    }()
    
    let tempMaxLabel: UILabel = {
        let label = UILabel()
        //        label.text = "TEMP MAX"
        return label
    }()
    
    let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        //        label.text = "SUNRISE TIME"
        return label
    }()
    
    let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        //        label.text = "SUNSET TIME"
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempMinLabel, tempMaxLabel, sunriseTimeLabel, sunsetTimeLabel])
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
        switch segmentControl.selectedSegmentIndex {
        case 0: currentTempLabel.text = "°C"
        case 1: currentTempLabel.text = "°F"
        default: currentTempLabel.text = "°C"
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
        addSubview(coutryLabel)
        coutryLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(240)
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints{ make in
            make.top.equalTo(coutryLabel.snp.bottom)
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
