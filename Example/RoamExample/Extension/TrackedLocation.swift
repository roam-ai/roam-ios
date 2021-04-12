//
//  TrackedLocation.swift
//  TestExample
//
//  Created by Roam Mac 15 on 16/06/20.
//  Copyright © 2020 Roam. All rights reserved.
//

import Foundation

// MARK: - TrackedLocation
struct TrackedLocation: Codable {
    let latitude, longitude: Double
    let timeStamp: String
    let activity:String
}

// MARK: TrackedLocation convenience initializers and mutators

extension TrackedLocation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TrackedLocation.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        latitude: Double? = nil,
        longitude: Double? = nil,
        timeStamp: String? = nil,
        activity: String? = nil

    ) -> TrackedLocation {
        return TrackedLocation(
            latitude: latitude ?? self.latitude,
            longitude: longitude ?? self.longitude,
            timeStamp: timeStamp ?? self.timeStamp,
            activity: activity ?? self.activity
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
