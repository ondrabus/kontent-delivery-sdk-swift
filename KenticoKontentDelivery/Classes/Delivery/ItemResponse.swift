//
//  ItemResponse.swift
//  Pods
//
//  Created by Martin Makarsky on 9/23/17.
//
//

import ObjectMapper

/// Represents response when getting single item.
public class ItemResponse<T>: Mappable where T: Mappable {
    
    /// Response item.
    public private(set) var item: T?
    private var map: Map
    
    /// Maps response's json instance of the item into strongly typed object representation.
    public required init?(map: Map) {
        self.map = map
    }
    
    /// Maps response's json instance of the item into strongly typed object representation.
    public func mapping(map: Map) {
        item <- map["item"]
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
