//
//  KeyAES256.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/24/24.
//

import Foundation
import CryptoKit

class KeyAES256 {
    var keyBase64AES = "AC1pV5BfjgMmXTcAyqSwCX3nbkmGXEyf3ZdaxUrOYHk="
    var idBase64AES = "aiNZGFJNWQBL+zZBiy7Djm0BdYNQZGIsw732VIsg2Dh9wQQtlwAFskD9+xlePAPG"
    var secretBase64AES = "Qdg+Osc3rf3UtUMCRkyXzyRPfJvUlKmrnz90abD67Uetk14mAZA="
    
    // MARK: - key decrypt
    
    func decryptAES(targetBase64: String, keyBase64: String)
    throws -> String {
        let data = Data(base64Encoded: targetBase64)!
        let keyData = Data(base64Encoded: keyBase64)!
        let key = SymmetricKey(data: keyData)
        
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        return String(data: decryptedData, encoding: .utf8) ?? "N/a"
    }
    
    // MARK: - key generate, encrypt, encode
    
    func generateBase64AESKey(originalId: String, originalSecret: String) {
        keyBase64AES = generateAESKey()
        idBase64AES = try! encryptAES(targetString: originalId, keyString: keyBase64AES)
        secretBase64AES = try! encryptAES(targetString: originalSecret, keyString: keyBase64AES)
        print("keyBase64AES : \(keyBase64AES)")
        print("idBase64AES : \(idBase64AES)")
        print("secretBase64AES : \(secretBase64AES)")
    }
    
    func compareKey (
        clientId: String, originalId: String,
        clientSecret: String, originalSecret: String) {
            print("clientId decrypt \(clientId == originalId)")
            print("clientSecret decrypt \(clientSecret == originalSecret)")
        }
    
    private func generateAESKey() -> String {
        let generatedKey = SymmetricKey(size: .bits256)
        let keyData = generatedKey.withUnsafeBytes { Data(Array($0)) }
        return keyData.base64EncodedString()
    }
    
    private func encryptAES(targetString: String, keyString: String)
    throws -> String {
        let data = targetString.data(using: .utf8)!
        let keyData = Data(base64Encoded: keyString)!
        let key = SymmetricKey(data: keyData)
        
        let sealedBox = try AES.GCM.seal(data, using: key)
        let encryptedData = sealedBox.combined!
        return encryptedData.base64EncodedString()
    }
    
}
