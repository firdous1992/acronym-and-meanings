//
//  HomeViewModelTests.swift
//  Acronym And MeaningsTests
//
//  Created by Fridous hussain on 13/02/22.
//

import XCTest
@testable import Acronym_And_Meanings

class HomeViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchMeaningsForAcronym_successCase() throws {
        let viewModel = HomeViewModel.init(service: MockAcronymService())
        
        viewModel.fetchMeaningsForAcronym(acronym: "iOS") { isSuccess, error in
            XCTAssertTrue(isSuccess)
        }
       
    }
    
    func testFetchMeaningsForAcronym_failureCase() throws {
        let service = MockAcronymService()
        service.callSuccessBlock = false
        let viewModel = HomeViewModel.init(service: service )
        
        viewModel.fetchMeaningsForAcronym(acronym: "iOS") { isSuccess, error in
            XCTAssertFalse(isSuccess)
            XCTAssertNotNil(error)
        }
    }
    
}


