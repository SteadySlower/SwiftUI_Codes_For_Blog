//
//  UITests_Name_Accessibility.swift
//  Tests iOS
//
//  Created by Jong Won Moon on 2023/01/09.
//

import XCTest

final class UITests_Name_Accessibility: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func inputName(_ name: String) {
        let textField = app.textFields["name field"]
        textField.tap()
        
        let isKeyboardEngish = app.keyboards.keys["A"].exists
        
        if !isKeyboardEngish {
            app.buttons["Next keyboard"].tap()
        }
        
        for char in name {
            let key = app.keyboards.keys["\(char)"]
            key.tap()
        }
        
        let inputButton = app.buttons["input button"]
        inputButton.tap()
    }
    
    func test_NameView_inputButton_success() {
        let name = "Teddy"
        inputName(name)
        
        let welcomeMessage = app.staticTexts["Let's Quiz, \(name)!"]
        XCTAssert(welcomeMessage.exists)
    }
    
    func test_NameView_inputButton_failure() {
        let name = "Uma"
        inputName(name)
        let isAlertExist = app.alerts.firstMatch.waitForExistence(timeout: 5)
        XCTAssert(isAlertExist)
    }
    
    func test_NameView_inputButton_retry() {
        let invalidName = "Uma"
        inputName(invalidName)
        
        let alert = app.alerts.firstMatch
        let alertButton = alert.buttons["alert button"]
        alertButton.tap()
        
        let validName = "Teddy"
        inputName(validName)
        
        let welcomeMessage = app.staticTexts["welcome message label of \(validName)"]
        XCTAssert(welcomeMessage.exists)
        
    }
}


