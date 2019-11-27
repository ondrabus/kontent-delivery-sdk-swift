//
//  UrlSlugElement.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 10/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class UrlSlugElementSpec: QuickSpec {
    override func spec() {
        describe("Get url slug element") {
            
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
                                
                                if let urlSlug = deliveryItem?.item?.urlSlug {
                                    let expectedType = "url_slug"
                                    let expectedName = "URL pattern"
                                    let expectedValue = "on-roasts"
                                    expect(urlSlug.type) == expectedType
                                    expect(urlSlug.name) == expectedName
                                    expect(urlSlug.value) == expectedValue
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}

