//
//  ContentTypesResponse.swift
//  Pods
//
//  Created by Martin Makarsky on 13/10/2017.
//
//

import ObjectMapper

/// Represents response when getting content types.
public class ContentTypesResponse: Mappable {
    
    /// Response content types.
    public private(set) var contentTypes: [ContentType]?
    
    /// Maps response's json instance of the contet types into strongly typed object representation.
    public required init?(map: Map) {
    }
    
    /// Maps response's json instance of the content types into strongly typed object representation.
    public func mapping(map: Map) {
        contentTypes <- map["types"]
    }
}

