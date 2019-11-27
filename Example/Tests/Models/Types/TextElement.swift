//
//  TextElement.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 10/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class TextElementSpec: QuickSpec {
    override func spec() {
        describe("Get text element") {
            
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
                                
                                if let summary = deliveryItem?.item?.summary {
                                    let expectedType = "text"
                                    let expectedName = "Summary"
                                    let expectedValue = "Roasting coffee beans can take from 6 to 13 minutes. Different roasting times produce different types of coffee, with varying concentration of caffeine and intensity of the original flavor."
                                    expect(summary.type) == expectedType
                                    expect(summary.name) == expectedName
                                    expect(summary.value) == expectedValue
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}
