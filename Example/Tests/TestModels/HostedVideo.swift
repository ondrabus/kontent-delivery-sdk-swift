//
//  HostedVideo.swift
//  KenticoKontentDelivery_Example
//
//  Created by Martin Makarsky on 28/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import ObjectMapper
import KenticoKontentDelivery

public class HostedVideoTestModel: Mappable {
    
    // MARK: Properties
    
    var videoHost: MultipleChoiceElement?
    
    // MARK: Mapping
    
    public required init?(map: Map){
        let mapper = MapElement.init(map: map)
        videoHost = mapper.map(elementName: "video_host", elementType: MultipleChoiceElement.self)
    }
    
    public func mapping(map: Map) {
    }
}

