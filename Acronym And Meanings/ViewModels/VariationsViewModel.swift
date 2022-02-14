//
//  VariationsViewModel.swift
//  Acronym And Meanings
//
//  Created by Fridous hussain on 13/02/22.
//

import Foundation

class VariationsViewModel: NSObject {
    
    var variations: [Meaning] = []
    private var meaning: Meaning?
    
    var noResultsText: String {
       return String(format: NSLocalizedString("NoVariationsLabelText", comment: ""), self.meaning?.meaning ?? "")
    }
    
    init(meaning: Meaning) {
        self.meaning = meaning
        self.variations = meaning.variations
    }
    
}
