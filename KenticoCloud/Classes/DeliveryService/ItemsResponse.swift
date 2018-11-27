//
//  ItemsResponse.swift
//  Pods
//
//  Created by Martin Makarsky on 9/23/17.
//
//

import ObjectMapper

/// Represents response when getting multiple items.
public class ItemsResponse<T>: Mappable where T: Mappable {
    
    /// Response items.
    public private(set) var items: [T]?
    
    private var map: Map
    
    /// Maps response's json instance of the items into strongly typed object representation.
    public required init?(map: Map) {
        self.map = map
    }
    
    /// Maps response's json instance of the items into strongly typed object representation.
    public func mapping(map: Map) {
        items <- map["items"]
    }
    
    /**
     Gets linked items from the response.
     
     - Parameter codename: Identifier of the linked item.
     - Parameter type: Type of the item. Must conform to Mappable protocol.
     - Returns: Strongly typed linked item.
     */
    public func getLinkedItems<T>(codename: String, type: T.Type) -> T? where T: Mappable {
        if let linkedItemsJson = self.map["modular_content.\(codename)"].currentValue {
            let linkedItem = Mapper<T>().map(JSONObject: linkedItemsJson)
            return linkedItem
        }
        
        return nil
    }
}
