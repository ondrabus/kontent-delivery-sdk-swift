//
//  InitDeliveryClient.swift
//  KenticoKontentDelivery_Example
//
//  Created by Sagar Choudhary on 03/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class InitDeliveryClient: QuickSpec {
    override func spec() {
        describe("Initialize Delivery client") {
            
            context("Initializing with no API key") {
                
                it("does not throw Assertion fatalError()") {
                    expect {_ = DeliveryClient.init(projectId: TestConstants.projectId)}.toNot(throwAssertion())
                }
            }
            
            context("Initializing with secure API key only ") {
                
                it("does not throw Assertion fatalError()") {
                    expect {_ = DeliveryClient.init(projectId: TestConstants.projectId, secureApiKey: TestConstants.secureApiKey)}.toNot(throwAssertion())
                }
            }
            
            context("Initializing with Preview API key only ") {
                
                it("does not throw Assertion fatalError()") {
                    expect {_ = DeliveryClient.init(projectId: TestConstants.projectId, previewApiKey: TestConstants.previewApiKey)}.toNot(throwAssertion())
                }
            }
            
            context("Initializing with both secure and preview API key") {
                
                it("throw Assertion fatalError()") {
                    expect {_ = DeliveryClient.init(projectId: TestConstants.projectId, previewApiKey: TestConstants.previewApiKey, secureApiKey: TestConstants.secureApiKey)}.to(throwAssertion())
                }
            }
        }
    }
}
