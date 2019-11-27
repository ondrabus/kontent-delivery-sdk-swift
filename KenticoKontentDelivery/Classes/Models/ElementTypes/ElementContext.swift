//
//  ElementContext.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

struct ElementContext: MapContext {
    var elementName: String!
    
    init(elementName: String) {
        self.elementName = elementName
    }
}
