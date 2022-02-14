//
//  HomeViewModel.swift
//  Acronym And Meanings
//
//  Created by Fridous hussain on 12/02/22.
//

import Foundation

class HomeViewModel: NSObject {
    var acronym: Acronym?
    private let acrnonymURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py?"
    private var service: AcronymServiceProtocol!
    
    init(service: AcronymServiceProtocol = AcronymService.shared) {
        self.service = service
    }
    
    func fetchMeaningsForAcronym(acronym: String, completionHanlder: @escaping (_ success : Bool, _ error : Error?) -> ())  {
        let parameters = ["sf" : acronym]
        service.getMeaningsForURLString(urlString: acrnonymURL, parameters: parameters) { task, acronym in
            self.acronym = acronym
            completionHanlder(true, nil)
        } failure: { task, error in
            completionHanlder(false, error)
        }
    }
}
