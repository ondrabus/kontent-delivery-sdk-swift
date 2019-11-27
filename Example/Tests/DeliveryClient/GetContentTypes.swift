//
//  GetContentTypes.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 13/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class GetContentTypesSpec: QuickSpec {
    override func spec() {
        describe("Get content types request") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Get some content types
            
            context("getting some content types using limit and skip parameters", {
                
                it("returns list of some content types with correct names and codenames") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getContentTypes(skip: 2, limit: 4, completionHandler: { (isSuccess, contentTypesResponse, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let response = contentTypesResponse {
                                let expectedCount = 4
                                let expectedName = "Brewer"
                                let expecedCodename = "coffee"
                                expect(response.contentTypes?.count) == expectedCount
                                expect(response.contentTypes?[1].name) == expectedName
                                expect(response.contentTypes?[3].codename) == expecedCodename
                                done()
                            }
                        })
                    }
                }
            })
            
            //MARK: Get all content types
            
            context("getting all content types", {
                
                it("returns list of some content types with correct names and codenames") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getContentTypes(skip: nil, limit: nil, completionHandler: { (isSuccess, contentTypesResponse, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let response = contentTypesResponse {
                                let expectedCount = 13
                                let expectedName = "Accessory"
                                let expecedCodename = "brewer"
                                expect(response.contentTypes?.count) == expectedCount
                                expect(response.contentTypes?[1].name) == expectedName
                                expect(response.contentTypes?[3].codename) == expecedCodename
                                done()
                            }
                        })
                    }
                }
            })
        }
    }
}
