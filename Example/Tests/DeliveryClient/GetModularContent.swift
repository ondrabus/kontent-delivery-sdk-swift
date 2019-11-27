//
//  GetLinkedItem.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 9/23/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class GetLinkedItemSpec: QuickSpec {
    override func spec() {
        describe("Get linked items ") {
            
            let client = DeliveryClient.init(projectId: TestConstants.projectId)
            
            //MARK: From item response
            
            context("from ItemResponse using specific codename", {
                
                it("returns linked item") {
                    waitUntil(timeout: 5) { done in
                        client.getItem(modelType: ArticleTestModel.self, itemName: "on_roasts", completionHandler: { (isSuccess, itemResponse, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let item = itemResponse?.item {
                                let itemRelatedContent = item.relatedContent
                                let originsOfArabicaCodeName = itemRelatedContent?.value?[1]
                                let coffeeItem = itemResponse?.getLinkedItems(codename: originsOfArabicaCodeName!, type: ArticleTestModel.self)
                                expect(coffeeItem?.title?.value) == "Origins of Arabica Bourbon"
                                done()
                            }
                        })
                    }
                }
            })
            
            //MARK: From items response
            
            context("from ItemsResponse using specific codename", {
                
                it("returns linked item") {
                    waitUntil(timeout: 5) { done in
                        let contentTypeParameter = QueryParameter.init(parameterKey: QueryParameterKey.type, parameterValue: "article")
                        client.getItems(modelType: ArticleTestModel.self, queryParameters: [contentTypeParameter], completionHandler:  { (isSuccess, itemsResponse, error) in
                            if !isSuccess {
                                fail("Response is not successful. Error: \(String(describing: error))")
                            }
                            
                            if let items = itemsResponse?.items {
                                let itemRelatedContent = items[1].relatedContent
                                let originsOfArabicaCodeName = itemRelatedContent?.value?[0]
                                let coffeeItem = itemsResponse?.getLinkedItems(codename: originsOfArabicaCodeName!, type: ArticleTestModel.self)
                                expect(coffeeItem?.title?.value) == "On Roasts"
                                done()
                            }
                        })
                    }
                }
            })
            
        }
    }
}
