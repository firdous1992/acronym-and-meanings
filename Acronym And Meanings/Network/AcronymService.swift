//
//  AcronymService.swift
//  Acronym And Meanings
//
//  Created by Fridous hussain on 13/02/22.
//

import Foundation
import AFNetworking

typealias ServiceSuccessBlock = (_ task: URLSessionDataTask, _ acronym: Acronym) -> ()
typealias ServiceFailureBlock = (_ task: URLSessionDataTask, _ error: Error) -> ()

protocol AcronymServiceProtocol {
    func getMeaningsForURLString(urlString: String, parameters: [String : Any]?,success: @escaping ServiceSuccessBlock, failure: @escaping ServiceFailureBlock);
}

class AcronymService: NSObject, AcronymServiceProtocol {
    //singleton instance
    static let shared = AcronymService()
    
    private override init() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getMeaningsForURLString(urlString: String, parameters: [String : Any]?,success: @escaping ServiceSuccessBlock, failure: @escaping ServiceFailureBlock) {
        
        let sessionManager = AFHTTPSessionManager.init()
        sessionManager.responseSerializer  = AFJSONResponseSerializer()
        sessionManager.requestSerializer  = AFJSONRequestSerializer()
        sessionManager.responseSerializer.acceptableContentTypes = nil;
        
        sessionManager.get(urlString, parameters: parameters, headers: nil) { _ in
            
        } success: { task, response in
            success(task, self.parseResponseObject(responseObject: response))
        } failure: { task, error in
            failure(task!, error)
        }
    }
    
    func parseResponseObject(responseObject: Any?) -> Acronym {
        let acronym = Acronym()
        if let response = responseObject as? Array<Any>,  let dict = response[0] as? [String : Any] {
            acronym.shortForm = dict["sf"] as! String
            acronym.meanings = getMeanings(lfsArray: dict["lfs"] as? [[String : Any]])
            return acronym
        }
        return acronym
    }
    
    func getMeanings(lfsArray responseArray : [[String : Any]]?) -> [Meaning] {
        guard let lfsArray = responseArray else {
            return []
        }
        
        var meanings: [Meaning] = []
        
        for dict in lfsArray {
            let meaning = Meaning()
            
            meaning.meaning = dict["lf"] as! String
            meaning.frequency = dict["freq"] as! Int
            meaning.since = dict["since"] as! Int
            meaning.variations = self.getVariations(responseArray: dict["vars"] as? [[String : Any]])
            meanings.append(meaning)
        }
        
        return meanings
    }
    
    func getVariations(responseArray: [[String : Any]]?) -> [Meaning] {
        guard let lfsArray = responseArray else {
            return []
        }
        
        var variations: [Meaning] = []
        
        for dict in lfsArray {
            let meaning = Meaning()
            meaning.meaning = dict["lf"] as! String
            meaning.frequency = dict["freq"] as! Int
            meaning.since = dict["since"] as! Int
            variations.append(meaning)
        }
        return variations
    }
    
}
