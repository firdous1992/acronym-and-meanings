//
//  Meaning.swift
//  Acronym And Meanings
//
//  Created by Fridous hussain on 13/02/22.
//

import Foundation

class Meaning: NSObject {
    var meaning: String = ""
    var frequency: Int = 0
    var since: Int = 0
    var variations: [Meaning] = []
    
    var detailText: String {
        return String(format: NSLocalizedString("MeaningsSubtitleText", comment: ""), since , frequency )
    }
}
