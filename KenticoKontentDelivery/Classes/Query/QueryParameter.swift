//
//  QueryParameter.swift
//  Pods
//
//  Created by Martin Makarsky on 07/09/2017.
//
//

/// DeliveryClient's queryParameter object.
public class QueryParameter {

    private var parameterKey: QueryParameterKey
    private var parameterValue: String
    
    /**
        Creates query parameter instance.
     
        - Parameter parameterKey: Key for query's parameter.
        - Parameter parameterValue: Value for query's parameter.
        - Returns: Instance of the QueryParameter.
     */
    public init(parameterKey: QueryParameterKey, parameterValue: String) {
        self.parameterKey = parameterKey
        self.parameterValue = parameterValue
    }
    
    func getQueryStringParameter() -> String {
        return self.parameterKey.rawValue + "=" + self.parameterValue
    }
}
