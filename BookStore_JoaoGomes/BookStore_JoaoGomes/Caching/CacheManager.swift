//
//  CacheManager.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 30/11/2024.
//
import Foundation
import UIKit

class CacheManager: NSObject
{
    
    static let shared = CacheManager()
    private let userDefaults: UserDefaults?
    
    override private init() {
        self.userDefaults = UserDefaults.standard
    }
    
    func addBook(_ book: Book, thumbnail: UIImage?)
    {
        //Check if book is alreacy stored
        guard !self.checkForBook(id: book.id) else
        {
            return
        }
        
        var storedBooksArray: [BookWithThumbnailData] = self.getAllBooks()
        let bookWithThumbnail = BookWithThumbnailData(book: book, thumbnailBase64: thumbnail?.base64)
        storedBooksArray.append(bookWithThumbnail)
        
        self.saveToCache(array: storedBooksArray)
        
    }
    
    func removeBook(id: String)
    {
        var storedBooksArray = self.getAllBooks()
       
        storedBooksArray.removeAll { item in
            item.book.id == id
        }
        self.saveToCache(array: storedBooksArray)
    }
    
    func checkForBook(id: String) -> Bool
    {
        let storedBooksArray = self.getAllBooks()
        return storedBooksArray.contains { item in
            item.book.id == id
        }
    }
    
    func getAllBooks() -> [BookWithThumbnailData]
    {
        var storedBooksArray: [BookWithThumbnailData] = []
        
        //Decode stored JSON Array
        if let storedBooks = userDefaults!.object(forKey: "storedBooks") as? Data
        {
            let decoder = JSONDecoder()
            do
            {
                storedBooksArray = try decoder.decode([BookWithThumbnailData].self, from: storedBooks)
            }
            catch
            {
                print("Decoding error: \(error)")
                return []
            }
        }
        return storedBooksArray
    }
    
    private func saveToCache(array: [BookWithThumbnailData])
    {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do
        {
            let data = try encoder.encode(array)
            print(String(data: data, encoding: .utf8)!)
            userDefaults!.set(data, forKey: "storedBooks")
        }
        catch
        {
            print("Decoding error: \(error)")
            return
        }
    }
    
    
}

