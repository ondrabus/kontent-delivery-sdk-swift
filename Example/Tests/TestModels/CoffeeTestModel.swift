//
//  CoffeeTestModel.swift
//  KenticoKontentDelivery_Example
//
//  Created by Martin Makarsky on 28/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import ObjectMapper
import KenticoKontentDelivery

public class CoffeeTestModel: Mappable {
    
    // MARK: Properties
    
    var price: NumberElement?
    
    // MARK: Mapping
    
    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        price = mapper.map(elementName: "price", elementType: NumberElement.self)
    }
    
    public func mapping(map: Map) {
    }
}
