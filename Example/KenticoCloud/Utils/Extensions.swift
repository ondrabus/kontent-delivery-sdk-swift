//
//  Extensions.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 26/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import KenticoCloud

extension UIButton {
    
    func stylePinkButton() {
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}

extension UILabel {
    func styleWithRichtextString(richtextString: String) {
        do {
            let attributedString = try NSMutableAttributedString(data: richtextString.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            
            
            let fontSizeAttribute = [NSFontAttributeName : UIFont.systemFont(ofSize: 16.0)]
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.5
            let lineSpacingAttribute = [NSParagraphStyleAttributeName : paragraphStyle]
            
            attributedString.addAttributes(fontSizeAttribute, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttributes(lineSpacingAttribute, range: NSMakeRange(0, attributedString.length))
            
            self.attributedText = attributedString
        } catch {
            print(error)
        }
    }
}

extension UIImageView {
    func addBorder() {
        self.layer.borderColor = AppConstants.imageBorderColor.cgColor
        self.layer.borderWidth = 2
    }
}

extension Date {
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

extension Array where Iterator.Element == QueryParameter {
    func addSampleSite() -> [QueryParameter] {
        let sampleSiteParam = QueryParameter.init(parameterKey: QueryParameterKey.sampleSite, parameterValue: "1")
        var copyOfArray = self.map { $0 }
        copyOfArray.append(sampleSiteParam)
        return copyOfArray
    }
}


class QueryStringParameter {
    static func addSampleSite(param: String) -> String {
        let lastChar = param.last!

        if (lastChar == "/") {
            return param + "?sampleSite=1";	
        }

        return param + "&sampleSite=1";
    }
}

