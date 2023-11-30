//
//  IntExtentionTests.swift
//  RecipleaseTests
//
//  Created by Melvin Poutrel on 29/11/2023.
//

import XCTest
@testable import Reciplease

final class IntExtensionTests: XCTestCase {
    
    func testFormatToStringTime() {
        XCTAssertEqual(0.formatToStringTime, "N/A")
        XCTAssertEqual(30.formatToStringTime, "30min")
        XCTAssertEqual(60.formatToStringTime, "1h")
        XCTAssertEqual(90.formatToStringTime, "1h 30min")
    }
    
    func testFormatToStringTimeAccessibilityLabel() {
        XCTAssertEqual(0.formatToStringTimeAccessibilityLabel, "No time provided to prepare this recipe")
        XCTAssertEqual(30.formatToStringTimeAccessibilityLabel, "30 minutes")
        XCTAssertEqual(60.formatToStringTimeAccessibilityLabel, "1 hours")
        XCTAssertEqual(90.formatToStringTimeAccessibilityLabel, "1 hours and 30 minutes")
    }
}
