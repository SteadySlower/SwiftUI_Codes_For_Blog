//
//  UITests_Quiz.swift
//  Tests iOS
//
//  Created by Jong Won Moon on 2022/12/12.
//

import XCTest

/*
 시연 순서
 1. 정답 입력하기
 2. 오답 입력하기 (정답입니다 없음)
 3. 오답 입력하기 (오답입니다 있음)
 4. 오답 입력하고 수정하기 (초기화 코드 없어서 오답이 나는 경우 보여주기)
 5. 다음 문제 풀기
 6. 문제 끝까지 풀기
 7. Navigation 넘어가는 것 (Navigation Link도 결국 버튼이다)
 8. 넘어가서 그림으로 확인하는 것
 9. 넘어가서 돌아오는 것
 */

final class UITests_Quiz: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    // 정답 입력하는 함수
    func inputAnswer(_ name: String) {
        let textField = app.textFields["정답"]
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
        
        let inputButton = app.buttons["입력"]
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
    
    // 퀴즈 오답 입력: 오답입니다 있음
    func test_QuizView_inputButton_failure2() {
        inputAnswer("Banana")
        let alert = app.alerts.firstMatch
        let alertMessageExist = alert.staticTexts["오답입니다."].exists
        XCTAssertFalse(alertMessageExist)
    }
    
    // 퀴즈 오답 입력 후 재입력
    func test_QuizView_inputButton_success_after_failure() {
        inputAnswer("Banana")
        
        let wrongAlert = app.alerts.firstMatch
        let wrongAlertButton = wrongAlert.buttons["다시 풀기"]
        wrongAlertButton.tap()
        
        inputAnswer("Apple")
        let rightAlert = app.alerts.firstMatch
        let alertMessageExist = rightAlert.staticTexts["정답입니다."].exists
        XCTAssert(alertMessageExist)
    }
    
    
    // 퀴즈 풀고 다음 문제로 넘어가기
    func test_QuizView_inputButton_success_and_next() {
        inputAnswer("Apple")
        let alert = app.alerts.firstMatch
        let alertButton = alert.buttons.firstMatch
        alertButton.tap()
        
        let nextButton = app.buttons["다음 문제"]
        nextButton.tap()
        
        let nextQuestion = app.staticTexts["바나나를(을) 영어로?"]
        XCTAssert(nextQuestion.exists)
    }
    
    // 문제 끝까지 풀기
    func test_QuizView_inputButton_success_to_the_end() {
        inputAnswer("Apple")
        let alert = app.alerts.firstMatch
        let alertButton = alert.buttons.firstMatch
        alertButton.tap()
        
        let nextButton = app.buttons["다음 문제"]
        nextButton.tap()
        
        inputAnswer("Banana")
        alertButton.tap()
        nextButton.tap()
        
        inputAnswer("Car")
        alertButton.tap()
        nextButton.tap()
        
        let nextQuestion = app.staticTexts["사과를(을) 영어로?"]
        XCTAssert(nextQuestion.exists)
    }
    
    // 다음 페이지로 넘어가기 (Navigation Bar로 확인)
    func test_QuizView_pictureHintNavigationLink_success() {
        let navigationLink = app.buttons["그림 힌트"]
        navigationLink.tap()
        
        let navigationBar = app.navigationBars["사과의 그림 힌트"]
        XCTAssert(navigationBar.exists)
    }
    
    // 다음 페이지로 넘어가기 (Image로 확인)
    func test_QuizView_pictureHintNavigationLink_success_image() {
        let navigationLink = app.buttons["그림 힌트"]
        navigationLink.tap()
        
        let image = app.images["사과"]
        XCTAssert(image.exists)
    }
    
    // 다시 돌아오기
    func test_QuizView_pictureHintNavigationLink_return() {
        let navigationLink = app.buttons["그림 힌트"]
        navigationLink.tap()
        
        let navigationBar = app.navigationBars["사과의 그림 힌트"]
        let navigationBackButton = navigationBar.buttons["Back"]
        navigationBackButton.tap()
        
        let textField = app.textFields["정답"]
        XCTAssert(textField.exists)
    }
}
