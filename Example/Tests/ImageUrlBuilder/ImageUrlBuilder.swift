//
//  ImageUrlBuilder.swift
//  KenticoKontentDelivery_Tests
//
//  Created by Jiang Chunhui on 23/3/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import KenticoKontentDelivery

class ImageUrlBuilderSpec: QuickSpec {
    override func spec() {
        describe("Build image URL") {

            let baseUrl = "https://test_example.com/coffee/test-image.jpg"

            // MARK: Empty transformation option

            context("with no transformation option", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl).url
                    let expectedUrl = baseUrl
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Pixel width

            context("with pixel width", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl).withWidth(900).url
                    let expectedUrl = baseUrl + "?w=900"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Width ratio

            context("with width ratio", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl).withWidthRatio(0.4).url
                    let expectedUrl = baseUrl + "?w=0.4"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Both pixel width and width ratio

            context("with both pixel width and width ratio", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withWidth(700)
                        .withWidthRatio(0.2).url
                    let expectedUrl = baseUrl + "?w=0.2"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Pixel height

            context("with pixel height", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl).withHeight(500).url
                    let expectedUrl = baseUrl + "?h=500"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Height ratio

            context("with height ratio", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl).withHeightRatio(0.3).url
                    let expectedUrl = baseUrl + "?h=0.3"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Both pixel height and height ratio

            context("with both pixel height and height ratio", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withHeightRatio(0.2)
                        .withHeight(700)
                        .url
                    let expectedUrl = baseUrl + "?h=700"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: DPR

            context("with DPR value", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl).withDpr(3.4).url
                    let expectedUrl = baseUrl + "?dpr=3.4"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Fit Mode

            context("with fit mode", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl).withFitMode(.Clip).url
                    let expectedUrl = baseUrl + "?fit=clip"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Rectangle Crop with Pixel Width and Height

            context("with rectangle crop with pixel size", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withRectangleCrop(x: 100, y: 50, width: 700, height: 400)
                        .url
                    let expectedUrl = baseUrl + "?rect=100,50,700,400"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Rectangle Crop with Percentage Width and Height Ratio

            context("with rectangle crop with size ratio", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withRectangleCrop(x: 0.1, y: 0.2, widthRatio: 0.3, heightRatio: 0.5)
                        .url
                    let expectedUrl = baseUrl + "?rect=0.1,0.2,0.3,0.5"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Rectangle Crop followed by Focal Point

            context("with rectangle crop followed by focal point", {
                it("ignores focal points and only returns rectangle crop") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withRectangleCrop(x: 100, y: 50, width: 700, height: 400)
                        .withFocalPointCrop(x: 0.4, y: 0.6, z: 3)
                        .url
                    let expectedUrl = baseUrl + "?rect=100,50,700,400"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Focal Point

            context("with focal point", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withFocalPointCrop(x: 0.4, y: 0.6, z: 2)
                        .url
                    let expectedUrl = baseUrl + "?fit=crop&crop=focalpoint&fp-x=0.4&fp-y=0.6&fp-z=2.0"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Focal Point followed by Rectangle Crop

            context("with focal point followed by rectangle crop", {
                it("removes focal points and only returns rectangle crop") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withFocalPointCrop(x: 0.4, y: 0.6, z: 2)
                        .withRectangleCrop(x: 100, y: 50, width: 700, height: 400)
                        .url
                    let expectedUrl = baseUrl + "?rect=100,50,700,400"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Fit Mode followed by Focal Point
            context("with fit mode followed by focal point", {
                it("overwrites fit mode to be crop") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withFitMode(.Scale)
                        .withFocalPointCrop(x: 0.4, y: 0.6, z: 2)
                        .url
                    let expectedUrl = baseUrl + "?fit=crop&crop=focalpoint&fp-x=0.4&fp-y=0.6&fp-z=2.0"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Background color with single RGB value

            context("with background color with single RGB", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withBackgroundColor(rgbColor: 0x0C9F3E, alpha: 0xFF)
                        .url
                    let expectedUrl = baseUrl + "?bg=FF0C9F3E"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Background color with separate R, G, B.

            context("with background color with separate RGB", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withBackgroundColor(red: 255, green: 0xDC, blue: 0, alpha: 0xFF)
                        .url
                    let expectedUrl = baseUrl + "?bg=FFFFDC00"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Image Format

            context("with image format", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withImageFormat(.Gif)
                        .url
                    let expectedUrl = baseUrl + "?fm=gif"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Image Compression

            context("with image compression", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withImageCompression(.Lossy)
                        .url
                    let expectedUrl = baseUrl + "?lossless=false"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Image Quality

            context("with image quality", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withQuality(40)
                        .url
                    let expectedUrl = baseUrl + "?q=40"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Auto Format

            context("with automatic format", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withAutomaticFormat()
                        .url
                    let expectedUrl = baseUrl + "?auto=format"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Decimal value with trailing 0

            context("with decimal value with trailing 0", {
                it("removes trailing 0") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl).withDpr(3.000000).url
                    let expectedUrl = baseUrl + "?dpr=3.0"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Rounding the decimal value

            context("with infinite decimal value", {
                it("rounds to 3 decimal places") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl).withWidthRatio(2/3).url
                    let expectedUrl = baseUrl + "?w=0.667"
                    expect(actualUrl) == expectedUrl
                }
            })

            // MARK: Combination query

            context("with combined query", {
                it("returns correct URL") {
                    let actualUrl = ImageUrlBuilder(baseUrl: baseUrl)
                        .withFitMode(.Clip)
                        .withWidth(300)
                        .withHeightRatio(0.4)
                        .withBackgroundColor(rgbColor: 0x330FAA)
                        .withImageFormat(.Png)
                        .withAutomaticFormat()
                        .url
                    let expectedUrl = baseUrl + "?fit=clip&w=300&h=0.4&bg=330FAA&fm=png&auto=format"
                    expect(actualUrl) == expectedUrl

                }
            })
        }
    }
}
