//
//  NumberElement.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 11/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class NumberElementSpec: QuickSpec {
    override func spec() {
        describe("Get number element") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Properties tests
            
            context("checking properties", {
                
                it("all properties are correct") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: CoffeeTestModel.self, itemName: "brazil_natural_barra_grande", completionHandler:
                            { (isSuccess, deliveryItem, error) in
                                if !isSuccess {
                                    fail("Response is not successful. Error: \(String(describing: error))")
                                }
                                
                                if let price = deliveryItem?.item?.price {
                                    let expectedType = "number"
                                    let expectedName = "Price"
                                    let expectedValue = 8.5
                                    expect(price.type) == expectedType
                                    expect(price.name) == expectedName
                                    expect(price.value) == expectedValue
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}

