//
//  ImageUrlBuilder.swift
//  KenticoKontentDelivery
//
//  Created by Jiang Chunhui on 20/3/19.
//


/**
 A helper class to build image transformation URL.
 Read https://docs.kontent.ai/reference/image-transformation before using this URL builder,
 because the builder will not validate the parameter.
 */
public class ImageUrlBuilder {

    private let baseUrl: String
    private var imageOption: [String:String]
    // Use the array to maintain the order of options
    private var optionKeywords: [String]

    /**
     Inits Image url builder instance.

     - Parameter baseUrl: The url of the source image, which should be either jpeg, png, gif, or webp in order to apply the transformation.
     - Returns: Instance of the ImageUrlBuilder with base url updated.
     */
    public init(baseUrl url: String) {
        self.baseUrl = url
        self.imageOption = [:]
        self.optionKeywords = []
    }

    /**
     The URL of the image with transformation options.

     - Returns: The URL of the image with transformation options.
     */
    public var url: String {
        if optionKeywords.isEmpty {
            return baseUrl
        }
        var option = ""
        for optionName in optionKeywords {
            if let optionValue = imageOption[optionName] {
                option += optionName + "=" + optionValue + "&"
            }
        }

        _ = option.popLast()
        return baseUrl + "?" + option
    }


    /**
     Updates the image url builder with fit mode parameter.
     Supported fit modes are: crop, clip, and scale.
     Fit mode works only if width, height, or both parameters are set.

     - Parameter mode: variable that indicates the image fit mode.
     - Returns: Instance of the ImageUrlBuilder with fit mode option updated.
     */
    public func withFitMode(_ mode: ImageFitMode) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("fit")
        imageOption["fit"] = mode.rawValue
        return self
    }

    /**
     Updates the image builder with absolute pixel width parameter.

     - Parameter width: The absolute pixel width of the output image. Restricted range: 1 to 8192.
     - Returns: Instance of the ImageUrlBuilder with width updated.
     */
    public func withWidth(_ width: Int) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("w")
        imageOption["w"] = width.description
        return self
    }

    /**
     Updates the image builder with percentage width parameter.

     - Parameter width: The percentage width of output image to input image. Restricted range: 0 to 1.
     - Returns: Instance of the ImageUrlBuilder with width updated.
     */
    public func withWidthRatio(_ ratio: Double) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("w")
        imageOption["w"] = formatDoubleString(ratio)
        return self
    }

    /**
     Updates the image builder with absolute pixel height parameter.

     - Parameter height: The absolute pixel height of the output image. Restricted range: 1 to 8192.
     - Returns: Instance of the ImageUrlBuilder with height updated.
     */
    public func withHeight(_ height: Int) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("h")
        imageOption["h"] = height.description
        return self
    }

    /**
     Updates the image builder with percentage height parameter.

     - Parameter height: The percentage height of output image to input image. Restricted range: 0 to 1.
     - Returns: Instance of the ImageUrlBuilder with height updated.
     */
    public func withHeightRatio(_ ratio: Double) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("h")
        imageOption["h"] = formatDoubleString(ratio)
        return self
    }

    /**
     Updates the image builder with DPR.
     DPR parameter works only if width, height, or both parameters are set.

     - Parameter dpr: The DPR value of the image. Restricted range: 0 to 5.
     - Returns: Instance of the ImageUrlBuilder with DPR updated.
     */
    public func withDpr(_ dpr: Double) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("dpr")
        imageOption["dpr"] = formatDoubleString(dpr)
        return self
    }

    /**
     Updates the image builder with rectangle crop.
     Incompatible with focal point.
     If both focal point crop and rectangle crop exist, only rectangle crop will appear in URL.

     - Parameter x: Rectangle offset on the x-axis in pixels. Restricted range: 1 to 8192.
     - Parameter y: Rectangle offset on the y-axis in pixels. Restricted range: 1 to 8192.
     - Parameter width: The absolute pixel width of rectangle. Restricted range: 1 to 8192.
     - Parameter height: The absolute pixel height of rectangle. Restricted range: 1 to 8192.
     - Returns: Instance of the ImageUrlBuilder with rectangle crop option updated.
     */
    public func withRectangleCrop(x: Int, y: Int, width: Int, height: Int) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("rect")
        checkAndRemoveFocalPointParameter()
        imageOption["rect"] = x.description + "," + y.description + "," + width.description + "," + height.description
        return self
    }

    /**
     Updates the image builder with rectangle crop.
     Incompatible with focal point.
     If both focal point crop and rectangle crop exist, only rectangle crop will appear in URL.

     - Parameter x: Rectangle offset on the x-axis in percentage. Restricted range: 0 to 1.
     - Parameter y: Rectangle offset on the y-axis in percentage. Restricted range: 0 to 1.
     - Parameter widthRatio: The width ratio of rectangle to the input image width. Restricted range: 0 to 1.
     - Parameter heightRatio: The height ratio of rectangle to the input image height. Restricted range: 0 to 1.
     - Returns: Instance of the ImageUrlBuilder with rectangle crop option updated.
     */
    public func withRectangleCrop(x: Double, y: Double, widthRatio width: Double, heightRatio height: Double)
            -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("rect")
        checkAndRemoveFocalPointParameter()
        imageOption["rect"] = formatDoubleString(x) + "," + formatDoubleString(y) + ","
            + formatDoubleString(width) + "," + formatDoubleString(height)
        return self
    }

    /**
     Updates the image builder with focal point crop.
     Fit mode will be set to "crop".
     Incompatible with rect. If both focal point crop and rectangle crop exist, only rectangle crop will appear in URL.

     - Parameter x: The horizontal value of the focal point of an image. Restricted range: 0 to 1.
     - Parameter y: The vertical value of the focal point of an image. Restricted range: 0 to 1.
     - Parameter z: The zoom value of a focal point of an image. Recommended range: 1 to 100
     - Returns: Instance of the ImageUrlBuilder with focal point crop option updated, if rectangle parameter is not set.
     */
    public func withFocalPointCrop(x: Double, y: Double, z: Double) -> ImageUrlBuilder {
        if imageOption["rect"] != nil {
            return self
        }
        checkAndUpdateOptionKeywords("fit")
        checkAndUpdateOptionKeywords("crop")
        imageOption["crop"] = "focalpoint&fp-x=" + formatDoubleString(x)
            + "&fp-y=" + formatDoubleString(y)
            + "&fp-z=" + formatDoubleString(z)
        return self.withFitMode(ImageFitMode.Crop)
    }

    /**
     Updates the image builder with background color option.

     - Parameter rgbColor: an integer represents the color in RGB format. Restricted range: 0x000000 to 0xFFFFFF.
     - Parameter alpha: (Optional) an integer represents the color's alpha transparency. Restricted range: 0x00 to 0xFF.
     - Returns: Instance of the ImageUrlBuilder with background color option updated.
     */
    public func withBackgroundColor(rgbColor rgb: Int, alpha a: Int? = nil) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("bg")
        return self.withBackgroundColor(red: (rgb >> 16) & 0xFF,
                                        green: (rgb >> 8) & 0xFF,
                                        blue: rgb & 0xFF,
                                        alpha: a)
    }

    /**
     Updates the image builder with background color option.

     - Parameter red: an integer represents the red value of color. Restricted range: 0x00 to 0xFF.
     - Parameter green: an integer represents the green value of color. Restricted range: 0x00 to 0xFF.
     - Parameter blue: an integer represents the blue value of color. Restricted range: 0x00 to 0xFF.
     - Parameter alpha: (Optional) an integer represents the color's alpha transparency. Restricted range: 0x00 to 0xFF.
     - Returns: Instance of the ImageUrlBuilder with background color option updated.
     */
    public func withBackgroundColor(red r: Int, green g: Int, blue b: Int, alpha a: Int? = nil) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("bg")
        var color = String(format: "%02X%02X%02X", r, g, b)
        if let alphaValue = a {
            color = String(format: "%02X", alphaValue) + color
        }
        imageOption["bg"] = color
        return self
    }

    /**
     Updates the image url builder with image format parameter.
     Supported formats are: gif, png, png8, jpg, pjpg, and webp.
     If no format parameter present, the output image format will be same as input one.

     - Parameter format: variable that indicates the output image format.
     - Returns: Instance of the ImageUrlBuilder with format option updated.
     */
    public func withImageFormat(_ format: ImageFormat) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("fm")
        imageOption["fm"] = format.rawValue
        return self
    }

    /**
     Updates the image url builder with the compression parameter.
     The compression works only if the output image format has been set to WebP.

     - Parameter compression: variable that indicates whether the compression is lossy or lossless.
     - Returns: Instance of the ImageUrlBuilder with compression option updated.
     */
    public func withImageCompression(_ compression: ImageCompression) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("lossless")
        imageOption["lossless"] = compression.rawValue
        return self
    }

    /**
     Updates the image url builder with the quality parameter.
     Quality parameter works only if the output image format is either jpg, pjpg, or WebP.

     - Parameter quality: the compression level for lossy file-formatted images. Restricted range: 0 to 100.
     - Returns: Instance of the ImageUrlBuilder with quality option updated.
     */
    public func withQuality(_ quality: Int) -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("q")
        imageOption["q"] = quality.description
        return self
    }

    /**
     Updates the image url builder by enabling automatic delivery of WebP format images.

     - Returns: Instance of the ImageUrlBuilder with automatic format option updated.
     */
    public func withAutomaticFormat() -> ImageUrlBuilder {
        checkAndUpdateOptionKeywords("auto")
        imageOption["auto"] = "format"
        return self
    }

    private func checkAndRemoveFocalPointParameter() {
        if imageOption["crop"] != nil {
            imageOption.removeValue(forKey: "fit")
            imageOption.removeValue(forKey: "crop")
        }
    }

    private func checkAndUpdateOptionKeywords(_ option: String) {
        if !optionKeywords.contains(option) {
            optionKeywords.append(option)
        }
    }

    private func formatDoubleString(_ value: Double) -> String {
        // Round the double value to 3 decimal places to avoid infinite decimal.
        let roundedValue = (value * 1000).rounded() / 1000
        return roundedValue.description
    }

    /**
     The image compression option.
    */
    public enum ImageCompression: String {
        /** Compress the image */
        case Lossless = "true"
        /** Not compress the image */
        case Lossy = "false"
    }

    /**
     The image format option.
     */
    public enum ImageFormat: String {
        /** The gif format */
        case Gif = "gif"
        /** The jpg format */
        case Jpg = "jpg"
        /** The png format */
        case Png = "png"
        /** The png8 format */
        case Png8 = "png8"
        /** The pjpg format */
        case Pjpg = "pjpg"
        /** The webp format */
        case Webp = "webp"
    }

    /**
     The image fit mode option.
     */
    public enum ImageFitMode: String {
        /** The clip fit mode*/
        case Clip = "clip"
        /** The crop fit mode*/
        case Crop = "crop"
        /** The scale fit mode*/
        case Scale = "scale"
    }
}
