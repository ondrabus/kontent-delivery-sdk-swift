//
//  HtmlContentBlock.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 11/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class HtmlContentBlockSpec: QuickSpec {
    override func spec() {
        describe("Get html content block") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: Name tests
            
            context("checking content", {
                
                it("returns proper content") {
                    
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, itemName: "on_roasts", completionHandler:
                            { (isSuccess, deliveryItem, error) in
                                if !isSuccess {
                                    fail("Response is not successful. Error: \(String(describing: error))")
                                }
                                
                                if let htmlContentBlock = deliveryItem?.item?.bodyCopy?.htmlContent.first {
                                    let expectedContent = "<p>There’s nothing complicated about roasting. It’s as easy as baking a pie, maybe even simpler as there’s just one ingredient. What’s complicated is fine-tuning the whole process to perfection. It’s also a huge responsibility. You can easily ruin something that’s been in the works for months and has been perfect up until now.</p>"
                                    expect(htmlContentBlock?.content) == expectedContent
                                    done()
                                }
                        })
                    }
                }
            })
        }
    }
}
