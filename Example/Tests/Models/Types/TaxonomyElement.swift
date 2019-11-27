//
//  TaxonomyElement.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 10/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class TaxonomyElementSpec: QuickSpec {
    override func spec() {
        describe("Get taxonomy element") {
            
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
                                
                                if let personas = deliveryItem?.item?.personas {
                                    let expectedType = "taxonomy"
                                    let expectedName = "Personas"
                                    let expectedTaxonomyGroup = "personas"
                                    let expectedFstValueName = "Barista"
                                    let expectedSndValueCodename = "coffee_blogger"
                                    expect(personas.type) == expectedType
                                    expect(personas.name) == expectedName
                                    expect(personas.taxonomyGroup) == expectedTaxonomyGroup
                                    expect(personas.value?[0].name) == expectedFstValueName
                                    expect(personas.value?[1].codename) == expectedSndValueCodename
                                    expect(personas.containsCodename(codename: "coffee_blogger")) == true
                                    expect(personas.containsCodename(codename: "coffee_blogger1")) == false
                                    expect(personas.containsName(name: "Barista")) == true
                                    expect(personas.containsName(name: "Barista1")) == false
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}
