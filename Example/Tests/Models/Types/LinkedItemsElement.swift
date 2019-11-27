//
//  LinkedItemslement.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 11/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class LinkedItemsElementSpec: QuickSpec {
    override func spec() {
        describe("Get linked items element") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Properties tests
            
            context("checking properties", {
                
                it("all properties are correct") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, itemName: "on_roasts", completionHandler:
                            { (isSuccess, deliveryItem, error) in
                                if !isSuccess {
                                    fail("Response is not successful. Error: \(String(describing: error))")
                                }
                                
                                if let relatedContent = deliveryItem?.item?.relatedContent {
                                    let expectedType = "modular_content"
                                    let expectedName = "Related articles"
                                    let expectedFstLinkedItemName = "coffee_processing_techniques"
                                    let expectedSndLinkedItemId = "origins_of_arabica_bourbon"
                                    expect(relatedContent.type) == expectedType
                                    expect(relatedContent.name) == expectedName
                                    expect(relatedContent.value?[0]) == expectedFstLinkedItemName
                                    expect(relatedContent.value?[1]) == expectedSndLinkedItemId
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}
