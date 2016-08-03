// =====================================================================================================================
//
//  File:       SwifterLogUnitTests.swift
//  Project:    SwifterLog
//
//  Version:    0.9.9
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/pages/projects/swifterlog/
//  Blog:       http://swiftrien.blogspot.com
//  Git:        https://github.com/Swiftrien/SwifterLog
//
//  Copyright:  (c) 2014-2016 Marinus van der Lugt, All rights reserved.
//
//  License:    Use or redistribute this code any way you like with the following two provision:
//
//  1) You ACCEPT this source code AS IS without any guarantees that it will work as intended. Any liability from its
//  use is YOURS.
//
//  2) You WILL NOT seek damages from the author or balancingrock.nl.
//
//  I also ask you to please leave this header with the source code.
//
//  I strongly believe that the Non Agression Principle is the way for societies to function optimally. I thus reject
//  the implicit use of force to extract payment. Since I cannot negotiate with you about the price of this code, I
//  have choosen to leave it up to you to determine its price. You pay me whatever you think this code is worth to you.
//
//   - You can send payment via paypal to: sales@balancingrock.nl
//   - Or wire bitcoins to: 1GacSREBxPy1yskLMc9de2nofNv2SNdwqH
//
//  I prefer the above two, but if these options don't suit you, you might also send me a gift from my amazon.co.uk
//  whishlist: http://www.amazon.co.uk/gp/registry/wishlist/34GNMPZKAQ0OO/ref=cm_sw_em_r_wsl_cE3Tub013CKN6_wb
//
//  If you like to pay in another way, please contact me at rien@balancingrock.nl
//
//  (It is always a good idea to visit the website/blog/google to ensure that you actually pay me and not some imposter)
//
//  For private and non-profit use the suggested price is the price of 1 good cup of coffee, say $4.
//  For commercial use the suggested price is the price of 1 good meal, say $20.
//
//  You are however encouraged to pay more ;-)
//
//  Prices/Quotes for support, modifications or enhancements can be obtained from: rien@balancingrock.nl
//
// =====================================================================================================================
//
// History:
//
// v0.9.9 - Initial release
//
// =====================================================================================================================

import XCTest

class SwifterLogUnitTests: XCTestCase, SwifterlogCallbackProtocol {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        log.callbackAtAndAboveLevel = SwifterLog.Level.debug
        log.stdoutPrintAtAndAboveLevel = SwifterLog.Level.debug
        log.aslFacilityRecordAtAndAboveLevel = SwifterLog.Level.none
        log.networkTransmitAtAndAboveLevel = SwifterLog.Level.none
        log.fileRecordAtAndAboveLevel = SwifterLog.Level.none
        log.registerCallback(self)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // Will be set in callback protocol
    
    var resultMessage: String?
    
    
    // Will be set in callback protocol
    
    var resultLevel: SwifterLog.Level?
    
    
    // Will be set in callback protocol
    
    var resultSource: String?

    
    // Callback protocol
    
    func logInfo(_ time: Date, level: SwifterLog.Level, source: String, message: String) {
        resultLevel = level
        resultMessage = message
        resultSource = source
    }
    
    func testNoMessageLog() {
        
        resultMessage = nil
        
        log.atLevelDebug(source: "test")
        
        sleep(1) // Give the callback some time
        
        XCTAssertEqual(resultSource, "test")
        XCTAssertEqual(resultMessage, "")
    }

    func testIntLog() {
        
        let i: Int = 6
        
        log.atLevelDebug(source: "", message: i)
        
        sleep(1) // Give the callback some time
        
        XCTAssertEqual(resultMessage, "\(i)")
    }
    
    func testStringLog() {
        
        let str = "any String really"
        
        log.atLevelWarning(source: "", message: str)
        
        sleep(1) // Give the callback some time
        
        XCTAssertEqual(resultMessage, "\(str)")
    }

    func testClassLog() {
        
        class TestClass: ReflectedStringConvertible {
            var a: Int = 5
            var b: String = "B"
        }
        
        let c = TestClass()
        
        log.atLevelInfo(source: "", message: c)
        
        sleep(1) // Give the callback some time
        
        XCTAssertEqual(resultMessage, "\(c)")
    }
    
    func testArrayLog() {
        
        let arr = [1, 2, 3]
        
        log.atLevelInfo(source: "", message: arr)
        
        sleep(1) // Give the callback some time
        
        XCTAssertEqual(resultMessage, "\(arr)")
    }

    func testDictLog() {
        
        let dict = ["MyKey" : 12.34]
        
        log.atLevelInfo(source: "", message: dict)
        
        sleep(1) // Give the callback some time
        
        XCTAssertEqual(resultMessage, "\(dict)")

    }
}