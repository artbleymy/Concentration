//
//  Theme.swift
//  Concentration
//
//  Created by Stanislav on 04.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import Foundation

struct Theme {
    var emojiTheme : [String]
    var themeTitle : String
    
    init(for nameTheme: String, include emojis: [String]) {
        self.themeTitle = nameTheme
        self.emojiTheme = emojis
    }
}
