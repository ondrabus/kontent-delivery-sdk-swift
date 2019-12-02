//
//  Coffee.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 Kentico Software. All rights reserved
//

import Foundation
import ObjectMapper
import KenticoKontentDelivery

public class Coffee: Mappable {
    
    // MARK: Properties 
    
    var name: TextElement?
    var image: AssetElement?
    var category: TaxonomyElement?
    var promotion: MultipleChoiceElement?
    var shortDescription: RichTextElement?
    var longDescription: RichTextElement?
    var farm: TextElement?
    var country: TextElement?
    var variety: TextElement?
    var processing: MultipleChoiceElement?
    var altitude: TextElement?
    var price: NumberElement?

    // MARK: Mapping
    
    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        
        name = mapper.map(elementName: "product_name", elementType: TextElement.self)
        image = mapper.map(elementName: "image", elementType: AssetElement.self)
        category = mapper.map(elementName: "coffee_category", elementType: TaxonomyElement.self)
        promotion = mapper.map(elementName: "promotion", elementType: MultipleChoiceElement.self)
        shortDescription = mapper.map(elementName: "short_description", elementType: RichTextElement.self)
        longDescription = mapper.map(elementName: "long_description", elementType: RichTextElement.self)
        farm = mapper.map(elementName: "farm", elementType: TextElement.self)
        country = mapper.map(elementName: "country", elementType: TextElement.self)
        variety = mapper.map(elementName: "variety", elementType: TextElement.self)
        processing = mapper.map(elementName: "processing", elementType: MultipleChoiceElement.self)
        altitude = mapper.map(elementName: "altitude", elementType: TextElement.self)
        price = mapper.map(elementName: "price", elementType: NumberElement.self)
    }
    
    public func mapping(map: Map) {
    }
}
