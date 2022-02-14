//
//  HomeViewControllerTests.swift
//  Acronym And MeaningsTests
//
//  Created by Fridous hussain on 13/02/22.
//

import XCTest
@testable import Acronym_And_Meanings

class HomeViewControllerTests: XCTestCase {
    
    var viewController: HomeViewController?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        viewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        XCTAssertNotNil(viewController)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewDidLoad_withNilAcronym() {
        let _ = viewController?.view // calls the viewdidload
        
        XCTAssertTrue(viewController?.meaningsTableView.isHidden ?? true);
        
        XCTAssertTrue(viewController?.meaningsTableView.numberOfRows(inSection: 0) == 0)
    }
    
    

}
