//
//  VariationsViewControllerTests.swift
//  Acronym And MeaningsTests
//
//  Created by Fridous hussain on 13/02/22.
//

import XCTest
@testable import Acronym_And_Meanings

class VariationsViewControllerTests: XCTestCase {

    var viewController: VariationsViewController?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        viewController = mainStoryBoard.instantiateViewController(withIdentifier: "VariationsViewController") as? VariationsViewController
        XCTAssertNotNil(viewController)
    }
   

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testViewDidLoad_withEmptyMeaningObject() {
        viewController?.meaning = Meaning()
        let _ = viewController?.view
        
        XCTAssertTrue(viewController?.variationsTableView.isHidden ?? false)
        XCTAssertFalse(viewController?.noResultsLabel.isHidden ?? false)
        
        XCTAssertTrue(viewController?.variationsTableView.numberOfRows(inSection: 0) == 0)
    }
    
    func testViewDidLoad_withValidMeaningObject() {
        
       
        
        let variation1 = Meaning()
        variation1.meaning = "variation1"
        variation1.frequency = 10
        variation1.since = 1970
        
        let variation2 = Meaning()
        variation2.meaning = "variation2"
        variation2.frequency = 45
        variation2.since = 1921
        
        let meaning = Meaning()
        meaning.meaning = "test"
        meaning.variations = [variation1, variation2];
        viewController?.meaning = meaning
        let _ = viewController?.view
        
        XCTAssertFalse(viewController?.variationsTableView.isHidden ?? false)
        XCTAssertTrue(viewController?.noResultsLabel.isHidden ?? false)
        
        XCTAssertTrue(viewController?.variationsTableView.numberOfRows(inSection: 0) == 2)
    }


}
