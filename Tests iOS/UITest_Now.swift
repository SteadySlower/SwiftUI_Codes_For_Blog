//
//  UITest_Now.swift
//  Tests iOS
//
//  Created by Jong Won Moon on 2022/12/13.
//

import XCTest

final class UITest_Now: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
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

    func test_inputButton_success_with_valid_name() throws {
        let name = "Teddy"
        inputName(name)
        
        // Then
        let welcomeMessage = app.staticTexts["Let's Quiz, \(name)!"]
        XCTAssert(welcomeMessage.exists)
    }
    
    func test_inputButton_success_with_invalid_name() throws {
        let name = "Tom"
        inputName(name)
        
        // Then
        let welcomeMessage = app.staticTexts["Let's Quiz, \(name)!"]
        XCTAssertFalse(welcomeMessage.exists)
    }

}
