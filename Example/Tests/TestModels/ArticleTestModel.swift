//
//  ArticleTestModel.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 21/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import ObjectMapper
import KenticoKontentDelivery

public class ArticleTestModel: Mappable {
    
    // MARK: Properties
    
    var title: TextElement?
    var asset: AssetElement?
    var postDate: DateTimeElement?
    var summary: TextElement?
    var bodyCopy: RichTextElement?
    var relatedContent: LinkedItemsElement?
    var targetAudience: MultipleChoiceElement?
    var issue: NumberElement?
    var personas: TaxonomyElement?
    var urlSlug: UrlSlugElement?
    
    // MARK: Mapping
    
    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        title = mapper.map(elementName: "title", elementType: TextElement.self)
        asset = mapper.map(elementName: "teaser_image", elementType: AssetElement.self)
        postDate = mapper.map(elementName: "post_date", elementType: DateTimeElement.self)
        summary = mapper.map(elementName: "summary", elementType: TextElement.self)
        bodyCopy = mapper.map(elementName: "body_copy", elementType: RichTextElement.self)
        relatedContent = mapper.map(elementName: "related_articles", elementType: LinkedItemsElement.self)
        targetAudience = mapper.map(elementName: "target_audience", elementType: MultipleChoiceElement.self)
        issue = mapper.map(elementName: "issue", elementType: NumberElement.self)
        personas = mapper.map(elementName: "personas", elementType: TaxonomyElement.self)
        urlSlug = mapper.map(elementName: "url_pattern", elementType: UrlSlugElement.self)
        
    }
    
    public func mapping(map: Map) {
    }
}
