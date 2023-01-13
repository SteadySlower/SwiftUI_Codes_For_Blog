//
//  UITest_Quiz_Launch.swift
//  Tests iOS
//
//  Created by Jong Won Moon on 2023/01/10.
//

import XCTest

final class UITests_Quiz_Launch: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-UITesting"]
        app.launchEnvironment = ["-username":"Teddy"]
        app.launch()
    }
    
    // 정답 입력하는 함수
    func inputAnswer(_ name: String) {
        let textField = app.textFields["answer text field"]
        textField.tap()
        let isEnglishCapital = app.keyboards.keys["A"].exists
        let isEnglish = app.keyboards.keys["a"].exists
        
        if !isEnglishCapital && isEnglish {
            app.buttons["shift"].tap()
        } else if !isEnglishCapital && !isEnglish {
            app.buttons["Next keyboard"].tap()
        }
        
        for char in name {
            let key = app.keyboards.keys["\(char)"]
            key.tap()
        }
        
        let inputButton = app.buttons["input answer button"]
        inputButton.tap()
    }
    
    // 퀴즈 정답 입력
    func test_QuizView_inputButton_success() {
        inputAnswer("Apple")
        let alert = app.alerts.firstMatch
        let alertMessageExist = alert.staticTexts["정답입니다."].exists
        XCTAssert(alertMessageExist)
    }
    
    // 퀴즈 오답 입력: 정답입니다 없음
    func test_QuizView_inputButton_failure() {
        inputAnswer("Banana")
        let alert = app.alerts.firstMatch
        let alertMessageExist = alert.staticTexts["정답입니다."].exists
        XCTAssertFalse(alertMessageExist)
    }
    
}
