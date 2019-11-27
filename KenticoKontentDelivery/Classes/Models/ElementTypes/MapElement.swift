//
//  MapElement.swift
//  Pods
//
//  Created by Martin Makarsky on 04/09/2017.
//
//

import ObjectMapper

/**
 MapElement object provides encapsulation of ElementContext which contains elementName.
 This provides easier mapping of elements into strongly typed objects.
 */
public class MapElement {
    
    private var map: Map?
    
    /// Maps response's json instance of the element into strongly typed object representation.
    public init(map: Map) {
        self.map = map
    }
    
    /**
     Adds ElementContext into mapping lifecycle.
     
     - Parameter elementName: Identifier of the element.
     - Parameter elementType: Type of the element. Must conform to Mappable protocol.
     - Returns: Strongly typed object of the elementType's type.
     */
    public func map<T>(elementName: String, elementType: T.Type) -> T where T: Mappable {
        let context = ElementContext(elementName: elementName)
        return Mapper<T>(context: context).map(JSON: self.map!.JSON)!
    }
    
}
