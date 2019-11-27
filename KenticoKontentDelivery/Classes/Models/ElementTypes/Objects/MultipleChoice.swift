//
//  MultipleChoice.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

/// Represents MultipleChoice.
public class MultipleChoice: Mappable {
    
    /// Name of the MultipleChoice.
    public private(set) var name: String?
    // Codename of the MultipleChoice
    public private(set) var codename: String?
    
    /// Maps response's json instance of the MultipleChoice into strongly typed object representation.
    required public init?(map: Map) {
    }
    
    /// Maps response's json instance of the MultipleChoice into strongly typed object representation.
    public func mapping(map: Map) {
        name <- map["name"]
        codename <- map["codename"]
    }
}
