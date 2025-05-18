//
//  TokenRefresherProtocol.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


public protocol TokenRefresherProtocol {
    func refreshIfNeeded() async throws
}

/*
 USAGE CAN BE LIKE
class DefaultTokenRefresher: TokenRefresher {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }

    // Метод для обновления токена
    func refreshIfNeeded() async throws -> String {
        // Создаём запрос с использованием созданного Endpoint
        let refreshEndpoint = RefreshTokenEndpoint()
        let refreshRequest = AnyEndpointRequest(endpoint: refreshEndpoint)

        // Отправляем запрос через сетевой клиент
        let tokenResponse: TokenResponse = try await client.send(refreshRequest)

        // Возвращаем новый токен
        return tokenResponse.accessToken
    }
}
*/