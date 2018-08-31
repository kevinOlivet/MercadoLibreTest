//
//  MercadoLibreTestUITests.swift
//  MercadoLibreTestUITests
//
//  Created by Jon Olivet on 8/28/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest

class MercadoLibreTestUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testLoadSuccess() {
        let navTitle = app.navigationBars["Amount"].otherElements["Amount"]
        let amountLabel = app.staticTexts["Enter amount in Chilean Pesos"]
        let textfield = app.textFields["Enter amount here"]
        let button = app.buttons["Next"]
        XCTAssertNotNil(navTitle)
        XCTAssertNotNil(amountLabel)
        XCTAssertNotNil(textfield)
        XCTAssertNotNil(button)
    }
    
    func testNoAmountEntered() {
        app.buttons["Next"].tap()
        let alert = app.alerts["Enter amount"].buttons["Ok"]
        XCTAssertNotNil(alert)
    }
    
    func testCompletePathWithIssuers() {
        
        let enterAmountHereTextField = app.textFields["Enter amount here"]
        enterAmountHereTextField.tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
        app.buttons["Next"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visa"]/*[[".cells.staticTexts[\"Visa\"]",".staticTexts[\"Visa\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"HSBC").element.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["3 cuotas de $ 18.986,67 ($ 56.960,00)"]/*[[".cells.staticTexts[\"3 cuotas de $ 18.986,67 ($ 56.960,00)\"]",".staticTexts[\"3 cuotas de $ 18.986,67 ($ 56.960,00)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let finishedAlert = app.alerts["Finished"]
        let message = finishedAlert.staticTexts["Amount: $50000\nSelected Payment Method: Visa\nBank Selected: HSBC\n3 cuotas de $ 18.986,67 ($ 56.960,00)"]
        XCTAssertTrue(message.exists)
    }
    
    func testHappyPathNoIssuers() {
        
        app.textFields["Enter amount here"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
 
        app.buttons["Next"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Naranja"]/*[[".cells.staticTexts[\"Naranja\"]",".staticTexts[\"Naranja\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Naranja").element.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["6 cuotas de $ 10.551,67 ($ 63.310,00)"]/*[[".cells.staticTexts[\"6 cuotas de $ 10.551,67 ($ 63.310,00)\"]",".staticTexts[\"6 cuotas de $ 10.551,67 ($ 63.310,00)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let finishedAlert = app.alerts["Finished"]
        
        let message = finishedAlert.staticTexts["Amount: $50000\nSelected Payment Method: Naranja\nBank Selected: Naranja\n6 cuotas de $ 10.551,67 ($ 63.310,00)"]
        XCTAssertTrue(message.exists)
        
    }
    
    func testAmountExceedsMaximum() {
        
        let app = XCUIApplication()
        app.textFields["Enter amount here"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["7"]/*[[".keyboards.keys[\"7\"]",".keys[\"7\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
  
        app.buttons["Next"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Mastercard"]/*[[".cells.staticTexts[\"Mastercard\"]",".staticTexts[\"Mastercard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let chooseAnotherAlert = app.alerts["Choose another"]
        let message = chooseAnotherAlert.staticTexts["Mastercard has a minimum amount of 2.00 and a maximum ammount of 250000.00"]
        XCTAssertTrue(message.exists)
    }
    
}
