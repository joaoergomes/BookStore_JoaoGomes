//
//  NetworkManager.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 28/11/2024.
//

import Foundation

class NetworkManager
{
    private let baseUrl = URL(string:"https://www.googleapis.com/books/v1/volumes?q=ios")!
    
    func loadBookItems(index: Int, numResults: Int, completion: @escaping (Result<BookList,Error>) -> Void)
    {
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)!
        let queryItems = [URLQueryItem(name: "startIndex", value: String(index)), URLQueryItem(name:"maxResults", value: String(numResults))]
        components.queryItems?.append(contentsOf: queryItems)
        self.loadRequest(urlRequest: URLRequest(url: components.url!), decodeWith: BookList.self, completion: completion)
    }
    
    private func loadRequest<T:Codable>(urlRequest request: URLRequest, decodeWith decodeType: T.Type, completion: @escaping (Result<T,Error>) -> Void)
    {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data
            {
                print("Data retrieved")
                let decoder = JSONDecoder()
                do
                {
                    let list = try decoder.decode(decodeType.self, from: data)
                    completion(.success(list))
                    print("Success")
                }
                catch
                {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            }
            
            if let error = error
            {
                completion(.failure(error))
                print("An error ocurred: \(error)")
            }
        }
        task.resume()
    }
}