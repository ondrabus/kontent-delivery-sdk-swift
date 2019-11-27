//
//  Taxonomy.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

/// Represents Taxonomy.
public class Taxonomy: Mappable {
    
    /// Name of taxonomy.
    public private(set) var name: String?
    /// Codename of taxonomy.
    public private(set) var codename: String?

    /// Maps response's json instance of the taxonomy into strongly typed object representation.
    required public init?(map: Map) {
    }
    
    /// Maps response's json instance of the taxonomy into strongly typed object representation.
    public func mapping(map: Map) {
        name <- map["name"]
        codename <- map["codename"]
    }
}
