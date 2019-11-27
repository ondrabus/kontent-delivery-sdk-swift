//
//  LinkedItemsBlock.swift
//  Pods
//
//  Created by Martin Makarsky on 05/09/2017.
//
//

import Kanna

/// Represents LinkedItemsBlock in RichText element.
public class LinkedItemsBlock: Block {
    
    /// Name of the linked item.
    public private(set) var contentItemName: String?
    
    init?(html: String?) {
        if let objectTag = html {
            if (isLinkedItem(objectTag: objectTag)) {
                if let contentItemName = getLinkedItemName(objectTag: html) {
                    self.contentItemName = contentItemName
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    private func isLinkedItem(objectTag: String) -> Bool {
        let dataTypeXpath = "//@data-type"
        if let figureTagDoc = try? HTML(html: objectTag, encoding: .utf8) {
            let dataType = figureTagDoc.xpath(dataTypeXpath).first?.content
            
            if isKenticoCloudApplicationType(tag: objectTag) && dataType == "item" {
                return true
            }
        }
        
        return false
    }
    
    private func getLinkedItemName(objectTag: String?) -> String? {
        if let objectTag = objectTag {
            let codeNameXpath = "//@data-codename"
            if let objTagDoc = try?  HTML(html: objectTag, encoding: .utf8) {
                let name = objTagDoc.xpath(codeNameXpath).first?.content
                return name
            }
        }
        
        return nil
    }
}
