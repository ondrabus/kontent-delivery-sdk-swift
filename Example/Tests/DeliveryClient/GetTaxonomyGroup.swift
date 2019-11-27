//
//  GetTaxonomyLive.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 21/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class GetTaxonomyGroupSpec: QuickSpec {
    override func spec() {
        describe("Get taxonomy group request") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Get one taxonomy group
            
            context("using taxonomy codename", {
                
                it("returns taxonomy") {
   
                    waitUntil(timeout: 5) { done in
                        client.getTaxonomyGroup(taxonomyGroupName: "personas", completionHandler: { (isSuccess, item, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let taxonomyGroup = item {
                                let fstLvlTermName = taxonomyGroup.terms?[0].name
                                let sndLvlTermCodename = taxonomyGroup.terms?[0].terms?[1].codename
                                expect(fstLvlTermName) == "Coffee expert"
                                expect(sndLvlTermCodename) == "cafe_owner"
                                done()
                            }
                        })
                    }
                }
            })
            
        }
    }
}

