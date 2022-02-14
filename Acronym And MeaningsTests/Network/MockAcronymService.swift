//
//  MockAcronymService.swift
//  Acronym And MeaningsTests
//
//  Created by Bala Obul Reddy on 13/02/22.
//

import Foundation
@testable import Acronym_And_Meanings

class MockAcronymService: AcronymServiceProtocol {
    var callSuccessBlock = true
    var acronym: Acronym = Acronym()
    
    func getMeaningsForURLString(urlString: String, parameters: [String : Any]?, success: @escaping ServiceSuccessBlock, failure: @escaping ServiceFailureBlock) {
        if callSuccessBlock {
            success(URLSessionDataTask(), acronym)
        } else {
            failure(URLSessionDataTask(), NSError.init(domain: "TestCaseFailure", code: 400, userInfo: nil))
        }
    }
    
}
