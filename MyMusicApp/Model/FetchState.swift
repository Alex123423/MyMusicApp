//
//  FetchState.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 09.06.2023.
//

import Foundation

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case noResults
    case error(String)
}
