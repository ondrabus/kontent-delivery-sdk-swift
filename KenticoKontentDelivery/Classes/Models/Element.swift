//
//  Element.swift
//  Pods
//
//  Created by Martin Makarsky on 13/10/2017.
//
//

import ObjectMapper

/// Represents Element object nested in Content Type.
public class Element: Mappable {
    
    /// Type of the element.
    public private(set) var type: String?
    /// Name of the element.
    public private(set) var name: String?
    
    /// Maps response's json instance of the element into strongly typed object representation.
    public required init?(map: Map) {
    }
    
    /// Maps response's json instance of the element into strongly typed object representation.
    public func mapping(map: Map) {
        type <- map["type"]
        name <- map["name"]
    }
}
