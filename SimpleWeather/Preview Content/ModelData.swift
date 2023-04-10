//
//  ModelData.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/4/23.
//

import Foundation

var previewWeather: ResponseBody = load("weatherData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Не найден \(filename) файл.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Ошибка при загрузке \(filename) файла:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Ошибка парсинга \(filename) as \(T.self):\n\(error)")
    }
}
