//
//  InlineImageBlockTests.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 11/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class InlineImageBlockSpec: QuickSpec {
    override func spec() {
        describe("Get inline image block") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Descriptions tests
            
            context("checking description", {
                
                it("returns proper description") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, itemName: "on_roasts", completionHandler:
                            { (isSuccess, deliveryItem, error) in
                                if !isSuccess {
                                    fail("Response is not successful. Error: \(String(describing: error))")
                                }
                                
                                if let imageBlock = deliveryItem?.item?.bodyCopy?.inlineImages.first {
                                    let expectedDescription = "Coffee Bean Bag"
                                    expect(imageBlock?.description) == expectedDescription
                                    done()
                                }
                        })
                    }
                }
            })
            
            //MARK: URL tests
            
            context("checking url", {
                
                it("returns proper url") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, itemName: "on_roasts", completionHandler:
                            { (isSuccess, deliveryItem, error) in
                                if !isSuccess {
                                    fail("Response is not successful. Error: \(String(describing: error))")
                                }
                                
                                if let imageBlock = deliveryItem?.item?.bodyCopy?.inlineImages.first {
                                    let expectedUrl = "https://assets-us-01.kc-usercontent.com:443/24ea5db0-f8e5-0010-1822-ef5eea334bfc/55caecc2-400c-4ee3-91c3-0f7f067414ec/banner-default.jpg"
                                    expect(imageBlock?.url) == expectedUrl
                                    done()
                                }
                        })
                    }
                }
            })
            
        }
    }
}


