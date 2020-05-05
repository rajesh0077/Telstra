//
//  TelstraDemoAppTests.swift
//  TelstraDemoAppTests
//
//  Created by RajeshDeshmukh on 30/04/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import XCTest
@testable import TelstraDemoApp

/// Variables


var viewModelObj = {
  return AboutCandaViewModel()
}()

class TelstraDemoAppTests: XCTestCase {
  
  override func setUp() {
    self.readlocalJson()
    XCTAssertEqual(viewModelObj.navTitle, "About Canada")
    XCTAssertTrue(viewModelObj.displayAboutCanda?.count != 0)
    
    let objectAtFirstIndex = viewModelObj.displayAboutCanda?[0]
    XCTAssertTrue(objectAtFirstIndex != nil)
    XCTAssertTrue(objectAtFirstIndex?.title != nil)
    XCTAssertTrue(objectAtFirstIndex?.description != nil)
    XCTAssertTrue(objectAtFirstIndex?.imageHref != nil)
    XCTAssertEqual(objectAtFirstIndex?.title, "Beavers")
    XCTAssertEqual(objectAtFirstIndex?.description, "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony")
    XCTAssertEqual(objectAtFirstIndex?.imageHref, "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
    
    let objectAtSevenIndex = viewModelObj.displayAboutCanda?[7]
    XCTAssertTrue(objectAtSevenIndex != nil)
    XCTAssertTrue(objectAtSevenIndex?.title == nil)
    XCTAssertTrue(objectAtSevenIndex?.description == nil)
    XCTAssertTrue(objectAtSevenIndex?.imageHref == nil)
    
    let countofAboutCanda = viewModelObj.displayAboutCanda?.count
    XCTAssertTrue(countofAboutCanda == 14)
  }
  
  ///  function to get viewmodel from local json file for XCTest
  func readlocalJson() {
    if let path = Bundle.main.path(forResource: "localJSON", ofType: "json") {
      do {
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let jsonStr = String(decoding: data, as: UTF8.self)
        
        do {
          let results = try JSONDecoder().decode(AboutCandaModel.self, from: jsonStr.data(using: .utf8)!)
          viewModelObj.navTitle = results.title
          viewModelObj.displayAboutCanda  = results.rows
        } catch {
          print(error.localizedDescription)
        }
        
      } catch {
        print("parse error: \(error.localizedDescription)")
      }
    }
    else {
      print("Invalid filename/path.")
    }
  }
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
