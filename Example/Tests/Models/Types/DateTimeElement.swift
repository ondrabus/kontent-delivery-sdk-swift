//
//  DateTypeElement.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 11/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class DateTimeElementSpec: QuickSpec {
    override func spec() {
        describe("Get DateTime element") {
            
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
                                
                                if let postDate = deliveryItem?.item?.postDate {
                                    let expectedType = "date_time"
                                    let expectedName = "Post date"
                                    let expectedRawValue = "2014-11-07T00:00:00Z"
                                    expect(postDate.type) == expectedType
                                    expect(postDate.name) == expectedName
                                    expect(postDate.rawValue) == expectedRawValue
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}

