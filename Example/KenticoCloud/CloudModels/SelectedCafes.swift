//
//  SelectedCafes.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 22/09/2017.
//  Copyright © 2017 Kentico Software. All rights reserved
//

import ObjectMapper
import KenticoCloud

class SelectedCafes: Mappable {
    
    // MARK: Properties
    
    var handpickedCafes: LinkedItemsElement?
    
    // MARK: Mapping
    
    required init?(map: Map){
        let mapper = MapElement.init(map: map)
        
        handpickedCafes = mapper.map(elementName: "handpicked_cafes", elementType: LinkedItemsElement.self)
    }
    
    public func mapping(map: Map) {
    }
}
