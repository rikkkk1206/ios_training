//
//  Training_2Tests.swift
//  Training-2Tests
//
//  Created by RIKU on 2022/01/16.
//

import XCTest
@testable import Training_2

class Training_2Tests: XCTestCase {
    
    let weatherViewController = ViewController()
    let entryViewController = EntryViewController()

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSetWeatherImage() {
        var testWeather: String = "sunny"
        XCTAssertEqual(weatherViewController.setWeatherImage(weather: testWeather), UIImage(imageLiteralResourceName: "sunny"))
        
        testWeather = "cloudy"
        XCTAssertEqual(weatherViewController.setWeatherImage(weather: testWeather), UIImage(imageLiteralResourceName: "cloudy"))
        
        testWeather = "rainy"
        XCTAssertEqual(weatherViewController.setWeatherImage(weather: testWeather), UIImage(imageLiteralResourceName: "rainy"))
    }
    
    func testSetTempLbl() {
        var maxTemp: Int = 0
        var minTemp: Int = 0
        
        for i in 0 ..< 10 {
            maxTemp = i
            for j in 0 ..< 10 {
                minTemp = j
                
                weatherViewController.setTempLbl(maxTemp: maxTemp, minTemp: minTemp)
                XCTAssertEqual(weatherViewController.maxTempLbl.text, String(i))
                XCTAssertEqual(weatherViewController.minTempLbl.text, String(j))
            }
        }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
