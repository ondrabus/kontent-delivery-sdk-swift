//
//  RetryPolicyOption.swift
//  KenticoKontentDelivery_Example
//
//  Created by Jiang Chunhui on 19/2/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class RetryPolicy: QuickSpec {
    override func spec() {

        describe("Configure retry policy option") {

            context("with negative maximum retry attempts", {

                it("sets maximum retry attempts to 0") {

                    let client1 = DeliveryClient(projectId: TestConstants.projectId, maxRetryAttempts: -7)
                    expect(client1.getMaximumRetryAttempts()) == 0

                    let client2 = DeliveryClient(projectId: TestConstants.projectId)
                    client2.setRetryAttribute(isRetryEnabled: true, maxRetryAttempts: -2)
                    expect(client2.getMaximumRetryAttempts()) == 0
                }
            })
        }
    }
}
