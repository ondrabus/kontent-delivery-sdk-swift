//
//  GetContentType.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 13/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class GetContentTypeSpec: QuickSpec {
    override func spec() {
        describe("Get content type request") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Get some content types
            
            context("getting content type using content type name", {
                
                it("returns content type with correct name codename and elements") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getContentType(name: "coffee", completionHandler: { (isSuccess, contentType, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let type = contentType {
                                let expectedName = "Coffee"
                                let expecedCodename = "coffee"
                                let expectedElementName = "Farm"
                                let expectedElementType = "text"
                                let expectedElementsCount = 22
                                expect(type.name) == expectedName
                                expect(type.codename) == expecedCodename
                                expect(type.elements?.count) == expectedElementsCount
                                expect(type.elements?["farm"]?.type) == expectedElementType
                                expect(type.elements?["farm"]?.name) == expectedElementName
                                done()
                            }
                        })
                    }
                }
            })
        }
    }
}

