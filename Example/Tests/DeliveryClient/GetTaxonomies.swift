//
//  GetTaxonomies.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 21/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class GetTaxonomiesSpec: QuickSpec {
    override func spec() {
        describe("Get taxonomies request") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Get all taxonomies
            
            context("getting all taxonomies", {
                
                it("returns list of all taxonomies") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getTaxonomies(completionHandler: { (isSuccess, items, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let taxonomies = items {
                                let fstLvl = taxonomies[0].terms?[1].codename
                                let sndLvl = taxonomies[1].terms?[1].codename
                                expect(fstLvl) == "chemex"
                                expect(sndLvl) == "coffee_enthusiast"
                                done()
                            }
                        })
                    }
                }
            })
            
            //MARK: Get taxonomies with custom query
            
            context("getting taxonomies with custom query", {
                
                it("returns list of required taxonomies") {
                    
                    waitUntil(timeout: 5) { done in
                        let customQuery = "taxonomies?skip=1&limit=1"
                        client.getTaxonomies(customQuery: customQuery, completionHandler: { (isSuccess, items, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let taxonomies = items {
                                let count = taxonomies.count
                                let sndLvl = taxonomies[0].terms?[1].codename
                                expect(count) == 1
                                expect(sndLvl) == "coffee_enthusiast"
                                done()
                            }
                        })
                    }
                }
            })
            
        }
    }
}
