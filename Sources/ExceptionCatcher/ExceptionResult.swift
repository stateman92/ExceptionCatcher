//
//  ExceptionResult.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 27..
//

import Foundation

public enum ExceptionResult<T> {
    case exception(NSException)
    case error(Error)
    case success(T)
}
