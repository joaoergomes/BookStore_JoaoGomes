//
//  Book.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 28/11/2024.
//

import Foundation

struct BookList: Codable
{
    let totalItems: Int
    let items: [Book]
}

struct Book: Codable
{
    let id: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

struct VolumeInfo: Codable
{
    let title: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let imageLinks: ImageLinks?
}

struct SaleInfo: Codable
{
    let saleability: String?
    let buyLink: String?
    let listPrice: ListPrice?
}

struct ListPrice: Codable
{
    let amount: Double?
    let currencyCode: String?
}

struct ImageLinks: Codable
{
    let smallThumbnail: String?
    let thumbnail: String?
}

struct BookWithThumbnailData: Codable
{
    let book: Book
    let thumbnailBase64: String?
}
