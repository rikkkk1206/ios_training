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
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    private var requestJsonData: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherImage.image = setWeatherImage(weather: "sunny")
        
        // リクエストデータをセットしJSONにエンコードする
        let requestData = RequestUserData(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
        let requestJson = encodeRequestData(requestData: requestData)
        if let requestJson = requestJson {
            requestJsonData = requestJson
        } else {
            requestJsonData = ""
        }
    }

    @IBAction func touchUpInsideReloadButton(_ sender: Any) {
        var weather: String = ""
        do {
            try weather = YumemiWeather.fetchWeather(self.requestJsonData)
            let weatherData = decodeResponseData(reaponseJson: weather)
            var currentWeatherData: ResponseWeatherData!
            
            if let weatherData = weatherData {
                currentWeatherData = weatherData
            }
            
            weatherImage.image = setWeatherImage(weather: currentWeatherData.weather)
            minTempLbl.text = String(currentWeatherData.min_temp)
            maxTempLbl.text = String(currentWeatherData.max_temp)
        } catch YumemiWeatherError.invalidParameterError {
            print("err")
            showAlert(errMessage: "エラー")
        } catch YumemiWeatherError.unknownError {
            print("unknown")
            showAlert(errMessage: "不明なエラー")
        } catch {
            print("EMERGENCE")
            showAlert(errMessage: "なんだこれあ")
        }
        //let weather: String = YumemiWeather.fetchWeather()
    }
    
    // 地域と時刻をもつ構造体オブジェクトをJson文字列にエンコード
    func encodeRequestData(requestData: RequestUserData) -> String? {
        var jsonString: String?
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
            let jsonData = try encoder.encode(requestData)
            jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString)
        } catch {
            print("エンコードエラー")
        }
        
        if let jsonString = jsonString {
            return jsonString
        } else {
            return nil
        }
    }
    
    // 天気予報APIのレスポンスJsonを構造体型にデコード
    func decodeResponseData(reaponseJson: String) -> ResponseWeatherData? {
        var response: ResponseWeatherData?
        do {
            let jsonData = reaponseJson.data(using: .utf8)!
            let decoder = JSONDecoder()
            response = try decoder.decode(ResponseWeatherData.self, from: jsonData)
            print(response)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
        
        if let response = response {
            return response
        } else {
            return nil
        }
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

