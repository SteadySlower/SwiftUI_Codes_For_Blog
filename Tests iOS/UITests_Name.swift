//
//  Tests_iOSLaunchTests.swift
//  Tests iOS
//
//  Created by Jong Won Moon on 2022/05/04.
//

/*
 시연 순서
 1. 이름 제대로 입력 (녹화 기능 시연)
 2. 이름 틀리게 입력 (1번 코드 수정해서)
 3. inputName 함수로 리팩토링
 4. 이름 틀리게 입력 (alert 존재 확인하기)
 5. 이름 틀리게 입력하고 다시 제대로 입력하기
 */

import XCTest

class UITests_Name: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    // 이름 입력: 자동으로 만드는 코드를 정리한 코드
    func test_NameView_inputButton_success() {
        // Given
        let textField = app.textFields["이름"]
        textField.tap()
        
        // When
        let tKey = app/*@START_MENU_TOKEN@*/.keyboards.keys["T"]/*[[".keyboards.keys[\"T\"]",".keys[\"T\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keyboards.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keyboards.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        dKey.tap()
        dKey.tap()
        
        let yKey = app/*@START_MENU_TOKEN@*/.keyboards.keys["y"]/*[[".keyboards.keys[\"y\"]",".keys[\"y\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        yKey.tap()
        
        let inputButton = app.buttons["입력"]
        inputButton.tap()
        
        // Then
        let welcomeMessage = app.staticTexts["Let's Quiz, Teddy!"]
        XCTAssert(welcomeMessage.exists)
        
    }
    
    // 이름 입력: 리팩토링 한 코드
    func test_NameView_inputButton_success2() {
        let name = "Teddy"
        inputName(name)
        
        let welcomeMessage = app.staticTexts["Let's Quiz, \(name)!"]
        XCTAssert(welcomeMessage.exists)
    }
    
    func inputName(_ name: String) {
        let textField = app.textFields["이름"]
        textField.tap()
        
        let isKeyboardEngish = app.keyboards.keys["A"].exists
        
        if !isKeyboardEngish {
            app.buttons["Next keyboard"].tap()
        }
        
        for char in name {
            let key = app.keyboards.keys["\(char)"]
            key.tap()
        }
        
        let inputButton = app.buttons["입력"]
        inputButton.tap()
    }
    
    // 이름 입력 실패 case : 웰컴 메시지 없음
    func test_NameView_inputButton_failure() {
        let name = "Uma"
        inputName(name)
        let welcomeMessage = app.staticTexts["Let's Quiz, \(name)!"]
        XCTAssertFalse(welcomeMessage.exists)
    }
    
    // 이름 입력 실패 case : alert의 존재 확인
    
    func test_NameView_inputButton_failure2() {
        let name = "Uma"
        inputName(name)
        let isAlertExist = app.alerts.firstMatch.waitForExistence(timeout: 5)
        XCTAssert(isAlertExist)
    }
    
    // 이름 입력: 실패 후 재시도 case
    
    func test_NameView_inputButton_retry() {
        let invalidName = "Uma"
        inputName(invalidName)
        
        let alert = app.alerts.firstMatch
        let alertButton = alert.buttons["OK"]
        alertButton.tap()
        
        let validName = "Teddy"
        inputName(validName)
        
        app.staticTexts["Let's Quiz, Teddy!"].tap()
        
    }
}
