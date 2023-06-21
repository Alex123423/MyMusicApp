//
//  MusicManager.swift
//  MyMusicApp
//
//  Created by Dmitry Medvedev on 18.06.2023.
//

import Foundation

final class MusicManager {
    
    var dowloadedTracks: [URL] = []
    
    static let shared = MusicManager()
    private let urlSession = URLSession.shared
    private let baseURL = "https://itunes.apple.com/search?"
    
    func requestData(name: String, completion: @escaping (Result<[Album], Error>) -> Void) {
        let urlString = baseURL + "term=\(name)" + "&limit=10"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = urlSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data,
               let response = response,
               let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if 200..<300 ~= statusCode {
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(AlbumResult.self, from: data) {
                        DispatchQueue.main.async {
                            completion(.success(json.results))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.httpStatusCode(statusCode)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    guard let error = error else { return }
                    completion(.failure(NetworkError.urlRequestError(error)))
                }
            }
        }
        task.resume()
    }
    
    func downloadTrackSample(from urlString: String, completion: @escaping (URL?) -> Void) {
        guard let trackURL = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.downloadTask(with: trackURL) { (tempLocation, response, error) in
            guard let tempLocation = tempLocation, error == nil else {
                print("Error downloading track sample: \(error?.localizedDescription ?? "")")
                completion(nil)
                return
            }
            
            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            print(documentsDirectoryURL)
            let destinationURL = documentsDirectoryURL?.appendingPathComponent(trackURL.lastPathComponent)
            print(destinationURL)
            do {
                try FileManager.default.moveItem(at: tempLocation, to: destinationURL!)
                completion(destinationURL)
                print(destinationURL)
            } catch {
                print("Error saving track sample: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
