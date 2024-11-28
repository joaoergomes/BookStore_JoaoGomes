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
    
    func loadBooks()
    {
        let request = URLRequest(url: baseUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data
            {
                print("Data retrieved")
                let decoder = JSONDecoder()
                do
                {
                    let list = try decoder.decode(BookList.self, from: data)
                    print("Success")
                }
                catch
                {
                    print("Decoding error \(error)")
                }
                
            }
            
            if let error = error
            {
                print("An error ocurred")
            }
        }
        task.resume()
    }
}
