//
//  GetItemLive.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 21/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class GetItemLiveSpec: QuickSpec {
    override func spec() {
        describe("Get live single item request") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Custom Model mapping
            
            context("using item name and custom model mapping", {
                
                it("returns proper item") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: CafeTestModel.self, itemName: "madrid", completionHandler:
                            { (isSuccess, deliveryItem, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let country = deliveryItem?.item?.country {
                                let expectedCountry = "Spain"
                                expect(country) == expectedCountry
                                done()
                            }
                        })
                    }
                }
            })
            
            
            context("using custom query and custom model mapping", {
                
                it("returns proper item") {
                    
                    let customQuery = "items/madrid?elements=country"
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: CafeTestModel.self, customQuery: customQuery, completionHandler: { (isSuccess, deliveryItem, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let country = deliveryItem?.item?.country {
                                let expectedCountry = "Spain"
                                expect(country) == expectedCountry
                                done()
                            }
                        })
                    }
                }
            })
            
            //MARK: Auto mapping using Delivery element types
            
            context("using item name and Delivery element types", {
                
                it("returns proper item") {

                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, itemName: "on_roasts", completionHandler: { (isSuccess, deliveryItem, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let title = deliveryItem?.item?.title?.value {
                                let expectedTitle = "On Roasts"
                                expect(title) == expectedTitle
                                done()
                            }
                        })
                    }
                }
            })
            
            context("using custom query and Delivery element types", {
                
                it("returns array of items") {
                    
                    let customQuery = "items/on_roasts?elements=title"
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, customQuery: customQuery, completionHandler: { (isSuccess, deliveryItem, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let title = deliveryItem?.item?.title?.value {
                                let expectedTitle = "On Roasts"
                                expect(title) == expectedTitle
                                done()
                            }
                        })
                    }
                }
            })
            
        }
    }
}

