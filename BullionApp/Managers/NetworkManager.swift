//
//  NetworkManager.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case serverError(Int)
    case noData
    case custom(String)
    case unauthorized
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .decodingError:
            return "Failed to decode response."
        case .serverError(let code):
            return "Server returned status code \(code)."
        case .noData:
            return "No data received from server."
        case .custom(let message):
            return message
        case .unauthorized:
            return "Unauthorized. Please login again."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

protocol TokenProvider {
    func getToken() async -> String?
    func deleteToken()
}

final class DefaultTokenProvider: TokenProvider {
    private let key = "auth_token"
    
    func getToken() async -> String? {
        if let token = UserDefaults.standard.string(forKey: key) {
            return token
        }
        return nil
    }
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: key)
    }
    
    func deleteToken() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

final class NetworkService {
    
    static let shared = NetworkService()
    private let baseURL: URL
    private let session: URLSession
    let tokenProvider: TokenProvider?

    init(baseURL: String = Helper.loadFromInfoPlist("BASE_URL"),
         session: URLSession = .shared,
         tokenProvider: TokenProvider? = DefaultTokenProvider()) {
        guard let url = URL(string: baseURL) else {
            fatalError("Invalid base URL")
        }
        self.baseURL = url
        self.session = session
        self.tokenProvider = tokenProvider
    }

    private func request<T: Decodable>(
        _ path: String,
        method: String,
        body: Encodable? = nil,
        query: [String: String]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        let cleanPath = path.hasPrefix("/") ? String(path.dropFirst()) : path
        guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(cleanPath), resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }

        if let query = query {
            urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else { throw NetworkError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        if let token = await tokenProvider?.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        print("[Request] \(method) \(url.absoluteString)")

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.custom("Invalid response type.")
        }

        switch httpResponse.statusCode {
        case 200...299:
            break
        case 401:
            throw NetworkError.unauthorized
        default:
            if !data.isEmpty {
                if let apiErr = try? JSONDecoder().decode(ApiErrorResponse.self, from: data) {
                    let message = apiErr.message
                    throw NetworkError.custom(message)
                }
            }
            throw NetworkError.serverError(httpResponse.statusCode)
        }

        guard !data.isEmpty else { throw NetworkError.noData }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }

    // MARK: - Public API helpers

    func get<T: Decodable>(
        _ path: String,
        query: [String: String]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        try await request(path, method: "GET", query: query, headers: headers, responseType: responseType)
    }

    func post<T: Decodable, B: Encodable>(
        _ path: String,
        body: B,
        query: [String: String]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        try await request(path, method: "POST", body: body, query: query, headers: headers, responseType: responseType)
    }

    func put<T: Decodable, B: Encodable>(
        _ path: String,
        body: B,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        try await request(path, method: "PUT", body: body, headers: headers, responseType: responseType)
    }

    func delete<T: Decodable>(
        _ path: String,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        try await request(path, method: "DELETE", headers: headers, responseType: responseType)
    }
    
    func patch<T: Decodable, B: Encodable>(
        _ path: String,
        body: B,
        query: [String: String]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        try await request(path, method: "PATCH", body: body, query: query, headers: headers, responseType: responseType)
    }
}
