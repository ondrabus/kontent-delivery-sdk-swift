//
//  MultipleChoiceElement.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 11/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class MultipleChoiceElementSpec: QuickSpec {
    override func spec() {
        describe("Get multiple choice element") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Properties tests
            
            context("checking properties", {
                
                it("all properties are correct") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: HostedVideoTestModel.self, itemName: "the_coffee_story", completionHandler:
                            { (isSuccess, deliveryItem, error) in
                                if !isSuccess {
                                    fail("Response is not successful. Error: \(String(describing: error))")
                                }
                                
                                if let videoHost = deliveryItem?.item?.videoHost {
                                    let expectedType = "multiple_choice"
                                    let expectedName = "Video host"
                                    let expectedFstChoiceName = "Vimeo"
                                    expect(videoHost.type) == expectedType
                                    expect(videoHost.name) == expectedName
                                    expect(videoHost.value?[0].name) == expectedFstChoiceName
                                    expect(videoHost.containsCodename(codename: "vimeo")) == true
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}
