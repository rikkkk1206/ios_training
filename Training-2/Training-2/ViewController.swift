//
//  ViewController.swift
//  Training-2
//
//  Created by RIKU on 2022/01/16.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {

    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var weatherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherImage.image = setWeatherImage(weather: "sunny")
    }

    @IBAction func touchUpInsideReloadButton(_ sender: Any) {
        var weather: String = ""
        do {
            try weather = YumemiWeather.fetchWeather(at: "tokyo")
            weatherImage.image = setWeatherImage(weather: weather)
        } catch YumemiWeatherError.unknownError {
            print("err")
            showAlert(errMessage: "エラー")
        } catch {
            print("unknown")
            showAlert(errMessage: "不明なエラー")
        }
        //let weather: String = YumemiWeather.fetchWeather()
    }
    
    func showAlert(errMessage: String) {
        let alert = UIAlertController(title: errMessage, message: "もう一度試してください", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "了解", style: .default) { action in
            print("yes")
        }

        // アクションの追加
        alert.addAction(yesAction)

        // UIAlertControllerの表示
        present(alert, animated: true, completion: nil)
    }
    
    func setWeatherImage(weather: String) -> UIImage {
        var image = UIImage(named: weather)
        
        let color = setWeatherColor(weather: weather)
        image = setTintColor(image: image!, color: color)
        
        return image!
    }
    
    func setWeatherColor(weather: String) -> UIColor {
        var color: UIColor
        switch weather {
        case "sunny":
            color = .orange
        case "cloudy":
            color = .gray
        case "rainy":
            color = .blue
        default:
            color = .white
        }
        return color
    }
    
    func setTintColor(image: UIImage, color: UIColor) -> UIImage {
        return UIGraphicsImageRenderer(size: image.size).image { context in
            let rect = CGRect(origin: .zero, size: image.size)
            image.draw(in: rect) // 元画像を背景画像として描画
            color.setFill()
            context.fill(rect, blendMode: .sourceIn)  // 単色の前景画像として描画
        }
    }
}

