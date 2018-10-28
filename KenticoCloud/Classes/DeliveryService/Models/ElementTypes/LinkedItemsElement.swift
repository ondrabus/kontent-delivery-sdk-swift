//
//  LinkedItemsElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

/// Represents Linked Items element.
public class LinkedItemsElement: Mappable {
    
    /// Type of the element.
    public private(set) var type: String?
    /// Name of the element.
    public private(set) var name: String?
    // Value of the element.
    public private(set) var value: [String]?
    
    /// Maps response's json instance of the element into strongly typed object representation.
    public required init?(map: Map){
    }
    
    /// Maps response's json instance of the element into strongly typed object representation.
    public func mapping(map: Map) {
        var elementName = ""
        if let context = map.context as? ElementContext {
            elementName = context.elementName
        }
        
        type <- map["elements.\(elementName).type"]
        name <- map["elements.\(elementName).name"]
        value <- map["elements.\(elementName).value"]
    }
}
