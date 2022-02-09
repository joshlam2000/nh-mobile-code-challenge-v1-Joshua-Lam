//
//  NiceClinicianDriveCalculatorUITests.swift
//  NiceClinicianDriveCalculatorUITests
//
//  Created by Josh Lam on 2/8/22.
//

import XCTest

class NiceClinicianDriveCalculatorUITests: XCTestCase {
    
    var app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFillUpForm() throws {
        // UI tests must launch the application that they test.

        // Retrieve all the widgets on form
        let tablesQuery = app.tables
        let resetButton = tablesQuery.buttons["calFormResetButton"]
        let addr1TextField = tablesQuery.textFields["calFormAddr1TextField"]
        let cityTextField = tablesQuery.textFields["calFormCityTextField"]
        let zipTextField = tablesQuery.textFields["calFormZipTextField"]
        let submitButton = tablesQuery.buttons["calFormOptimalClinicanButton"]

        // Reset just in case there are stuff on the form
        XCTAssertTrue(resetButton.waitForExistence(timeout: 2))
        resetButton.tap()

        // Enter Patient Info and then submit
        XCTAssertTrue(addr1TextField.waitForExistence(timeout: 2))
        addr1TextField.tap()
        addr1TextField.typeText("123 Main St")
        cityTextField.tap()
        cityTextField.typeText("Boulder")
        tablesQuery.cells["State, Zip, Include Lab"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["CO"]/*[[".cells[\"CO\"].switches[\"CO\"]",".switches[\"CO\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        zipTextField.tap()
        zipTextField.typeText("80309")
        XCTAssertTrue(submitButton.waitForExistence(timeout: 2))
        submitButton.tap()
        
        // If successfully. should see the dismiss button on resulting page
        let dismissButton = app.buttons["clinicanViewIdealDismissButton"]
        XCTAssertTrue(dismissButton.waitForExistence(timeout: 2))
        
        // Tap dismiss button to come back to main page so reset button should be visible
        dismissButton.tap()
        XCTAssertTrue(resetButton.waitForExistence(timeout: 2))
   
    }
    
}
