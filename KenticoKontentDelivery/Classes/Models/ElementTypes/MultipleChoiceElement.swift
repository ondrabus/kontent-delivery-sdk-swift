//
//  MultipleChoiceElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

/// Represents Multiple Choice element.
public class MultipleChoiceElement: Mappable {
    
    /// Type of the element.
    public private(set) var type: String?
    /// Name of the element.
    public private(set) var name: String?
    /// Value of the element.
    public private(set) var value: [MultipleChoice]?
    
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
    
    /**
     Checks if element contains codeName in choices.
     
     - Parameter codename: Codename of choice.
     - Returns: Returns true if element contains codeName in choices, otherwise false.
     */
    public func containsCodename(codename: String) -> Bool {
        if let choices = value {
            if choices.contains(where: { choice in choice.codename == codename }) {
                return true
            }
        }
        
        return false
    }
    
    /**
     Checks if element contains name in choices.
     
     - Parameter name: Name of choice.
     - Returns: Returns true if element contains name in choices, otherwise false.
     */
    public func containsName(name: String) -> Bool {
        if let choices = value {
            if choices.contains(where: { choice in choice.name == name }) {
                return true
            }
        }
        
        return false
    }
}
