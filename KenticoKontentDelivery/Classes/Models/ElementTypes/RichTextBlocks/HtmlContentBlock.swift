//
//  HtmlContentBlock.swift
//  Pods
//
//  Created by Martin Makarsky on 05/09/2017.
//
//

/// Represents HtmlContentBlock in RichText element.
public class HtmlContentBlock: Block {
    
    /// Content of the HtmlContentBlock.
    public private(set) var content: String?
    
    init?(html: String?) {
        
        if let tag = html {
            self.content = tag
        } else {
            return nil
        }
    }
}
