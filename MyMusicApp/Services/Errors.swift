//
//  Errors.swift
//  MyMusicApp
//
//  Created by Dmitry Medvedev on 17.06.2023.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}
