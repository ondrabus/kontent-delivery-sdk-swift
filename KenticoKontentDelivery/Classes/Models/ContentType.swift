//
//  ContentType.swift
//  Pods
//
//  Created by Martin Makarsky on 13/10/2017.
//
//

import ObjectMapper

/// Represents Content Type.
public class ContentType: Mappable {
    
    /// Name of the content type.
    public private(set) var name: String?
    /// Codename of the content type.
    public private(set) var codename: String?
    /// Contentype's elements.
    public private(set) var elements: Dictionary<String, Element>?
    
    /// Maps response's json instance of the content type into strongly typed object representation.
    public required init?(map: Map) {
    }
    
    /// Maps response's json instance of the content type into strongly typed object representation.
    public func mapping(map: Map) {
        name <- map["system.name"]
        codename <- map["system.codename"]
        elements <- map["elements"]
    }
}
