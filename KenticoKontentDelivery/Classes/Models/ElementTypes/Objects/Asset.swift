//
//  Asset.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

/// Represents Asset.
public class Asset: Mappable {
    
    /// Name of the Asset.
    public private(set) var name: String?
    /// Type of the Asset.
    public private(set) var type: String?
    /// Size of the Asset.
    public private(set) var size: Int?
    /// Description of the Asset.
    public private(set) var description: String?
    /// Url of the Asset.
    public private(set) var url: String?
    
    /// Maps response's json instance of the Asset into strongly typed object representation.
    required public init?(map: Map) {
    }
    
    /// Maps response's json instance of the Asset into strongly typed object representation.
    public func mapping(map: Map) {
        name <- map["name"]
        type <- map["type"]
        size <- map["size"]
        description <- map["description"]
        url <- map["url"]
    }
}
