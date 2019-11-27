//
//  TaxonomyElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

/// Represents Taxonomy element.
public class TaxonomyElement: Mappable {
    
    /// Type of the element.
    public private(set) var type: String?
    /// Name of the element.
    public private(set) var name: String?
    // Value of the element.
    public private(set) var value: [Taxonomy]?
    /// Taxonomy Group of the element.
    public private(set) var taxonomyGroup: String?
    
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
        taxonomyGroup <- map["elements.\(elementName).taxonomy_group"]
        value <- map["elements.\(elementName).value"]
    }
    
    /// Maps response's json instance of the element into strongly typed object representation.
    public func containsCodename(codename: String) -> Bool {
        if let taxonomies = value {
            if taxonomies.contains(where: { taxonomy in taxonomy.codename == codename }) {
                return true
            }
        }
        
        return false
    }
    
    /// Maps response's json instance of the element into strongly typed object representation.
    public func containsName(name: String) -> Bool {
        if let taxonomies = value {
            if taxonomies.contains(where: { taxonomy in taxonomy.name == name }) {
                return true
            }
        }
        
        return false
    }
}
