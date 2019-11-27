//
//  DateTimeElement.swift
//  Pods
//
//  Created by Martin Makarsky on 06/09/2017.
//
//

import ObjectMapper

/// Represents Taxonomy element.
public class DateTimeElement: Mappable {
    
    /// Type of the element.
    public private(set) var type: String?
    /// Name of the element.
    public private(set) var name: String?
    /// Value of Date type of the element.
    public private(set) var value: Date?
    /// Raw value of the element.
    public private(set) var rawValue: String?
    
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
        rawValue <- (map["elements.\(elementName).value"])
        value = getDateTime(dateTime: rawValue)
    }
    
    private func getDateTime(dateTime: String?) -> Date? {
        if let dateTime = dateTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter.date(from: dateTime)
        }
        
        return nil
    }
}

