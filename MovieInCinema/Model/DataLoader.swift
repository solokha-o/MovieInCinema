//
//  DataLoader.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 14.04.2021.
//

import Foundation

class DataLoader {
    //create static instance of singleton class
    public static let shared = DataLoader()
    //configure data loader from link and decode json to array
    public func loadData(from link: String, completion: @escaping ((MoviePeriod) -> Void)) {
       
        //create url from link
        guard let url = URL(string: link) else { fatalError("link is not correct!") }
        // create dataTask
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Have some error - \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            switch response.statusCode {
                case 200:
                    guard let data = data else { return }
                    print(data)
                    do {
                        let json = try JSONDecoder().decode(MoviePeriod.self, from: data)
                        print(json)
                        DispatchQueue.main.async {
                            completion(json)
                            //load json data save to UserDefaults
                            let encoder = JSONEncoder()
                            if let encoded = try? encoder.encode(json) {
                                UserDefaults.standard.set(encoded, forKey: link)
                            }
                        }
                    } catch {
                        print("Have some error - \(error.localizedDescription)")
                    }
                case 503:
                    print("ERROR!")
                default:
                    print(response.statusCode)
            }
        }.resume()
    }
}

