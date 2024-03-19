//
//  QuoteFetcher.swift
//  Random Quote Generator
//
//  Created by Maria Ehab
//

import Foundation

class QuoteFetcher {
    static func fetchRandomQuote(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://type.fit/api/quotes") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let quotes = try JSONDecoder().decode([Quote].self, from: data)
                    if let randomQuote = quotes.randomElement()?.text {
                        completion(randomQuote)
                    } else {
                        print("No quotes found")
                        completion(nil)
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    completion(nil)
                }
            } else if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}

struct Quote: Decodable {
    let text: String
    let author: String?
}


