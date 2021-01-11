//
//  QueryBuilder.swift
//  KenticoKontentDelivery
//
//  Created by Aliaksandr Kantsevoi on 10/12/18.
//

import Foundation

public typealias QueryBuilder = [QueryParameter]

public extension Array where Element == QueryParameter {
    private func add(key: QueryParameterKey, value: String) -> [QueryParameter] {
        return self + [QueryParameter(parameterKey: key, parameterValue: value)]
    }
    
    public func id(_ value: String) -> [QueryParameter] {
        return add(key: .id, value: value)
    }
    
    public func name(_ value: String) -> [QueryParameter] {
        return add(key: .name, value: value)
    }
    
    public func codename(_ value: String) -> [QueryParameter] {
        return add(key: .codename, value: value)
    }
    
    public func type(_ value: String) -> [QueryParameter] {
        return add(key: .type, value: value)
    }
    
    public func sitemapLocations(_ value: String) -> [QueryParameter] {
        return add(key: .sitemapLocations, value: value)
    }
    
    public func language(_ value: String) -> [QueryParameter] {
        return add(key: .language, value: value)
    }
    
    public static func params() -> [QueryParameter] {
        return []
    }
    
    public func queryString() -> String {
        return self.map{$0.getQueryStringParameter()}.joined(separator: "&")
    }
}
