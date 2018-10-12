//
//  ItemsRequestBuilder.swift
//  Pods
//
//  Created by Martin Makarsky on 11/09/2017.
//
//

class ItemsRequestBuilder {
    
    private var endpointUrl: String
    private var projectId: String
    private var queryParameters: [QueryParameter?]
    
    
    init(endpointUrl: String, projectId: String, queryParameters: [QueryParameter?]) {
        self.endpointUrl = endpointUrl
        self.projectId = projectId
        self.queryParameters = queryParameters
    }
    
    func getRequestUrl() -> String {
        
        var queryParametersString = "?"
        
        for queryParameter in queryParameters {
            if let queryParameter = queryParameter {
                queryParametersString.append(queryParameter.getQueryStringParameter())
                queryParametersString.append("&")
            }
        }
        
        // Remove last ampersand or question mark.
        queryParametersString = String(queryParametersString.dropLast(1))
        
        return "\(endpointUrl)/\(projectId)/items\(queryParametersString)"
    }
}
