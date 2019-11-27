//
//  CafeKontentModel.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 15/08/2017.
//  Copyright © 2017 Kentico Software. All rights reserved
//

import ObjectMapper
import KenticoKontentDelivery

class Article: Mappable {
    
    // MARK: Properties
    
    var title: TextElement?
    var asset: AssetElement?
    var postDate: DateTimeElement?
    var summary: TextElement?
    var bodyCopy: RichTextElement?
    var relatedContent: LinkedItemsElement?
    
    // MARK: Mapping
    
    required init?(map: Map){
        let mapper = MapElement.init(map: map)
        title = mapper.map(elementName: "title", elementType: TextElement.self)
        asset = mapper.map(elementName: "teaser_image", elementType: AssetElement.self)
        postDate = mapper.map(elementName: "post_date", elementType: DateTimeElement.self)
        summary = mapper.map(elementName: "summary", elementType: TextElement.self)
        bodyCopy = mapper.map(elementName: "body_copy", elementType: RichTextElement.self)
        relatedContent = mapper.map(elementName: "related_articles", elementType: LinkedItemsElement.self)
    }
    
    func mapping(map: Map) {
    }
}
