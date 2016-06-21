//
//  GroupController.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/19/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import Foundation
import Firebase

class GroupController {
    
    static let kGroup = "groups"
    
    static func groupArray() -> [Group] {
        
        let beerGroup = Group(name: "Beer")
        beerGroup.identifier = "-KKV2E-H-EzMSJvSxo1i"
        
        let homebrewGroup = Group(name: "Homebrew")
        homebrewGroup.identifier = "-KKV2MeUJ2Y3usbNoqum"
        
        let whiskeyGroup = Group(name: "Whiskey")
        whiskeyGroup.identifier = "-KKV2Stv4y38Agixf1e2"
        
        let wineGroup = Group(name: "Wine")
        wineGroup.identifier = "-KKV2WzuCH72IW7rscyS"
        
        let sodaGroup = Group(name: "Coke v Pepsi")
        sodaGroup.identifier = "-KKV2fuVw1lPMePGiS5F"
        
        return [beerGroup, homebrewGroup, whiskeyGroup, wineGroup, sodaGroup]
    }
}