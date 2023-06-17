//
//  Errors.swift
//  MyMusicApp
//
//  Created by Dmitry Medvedev on 18.06.2023.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}
