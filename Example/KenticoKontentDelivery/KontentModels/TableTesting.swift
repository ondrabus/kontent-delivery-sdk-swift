//
//  Coffee.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 Kentico Software. All rights reserved
//

import Foundation
import ObjectMapper
import KenticoKontentDelivery

public class TableTesting: Mappable {
    
    // MARK: Properties
    
    var richtext: RichTextElement?

    // MARK: Mapping
    
    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        
        richtext = mapper.map(elementName: "rich_text", elementType: RichTextElement.self)
    }
    
    public func mapping(map: Map) {
    }
}
