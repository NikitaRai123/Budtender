//
//  NotificationList.swift
//  Budtender
//
//  Created by Dharmesh Avaiya on 09/11/23.
//

import Foundation

// MARK: - NotificationList
class NotificationList: Codable {
    
    let status: Int?
    let message: String?
    let data: [NotificationElement]?
    let lastPage: Bool?
    
    init(status: Int?, message: String?, lastPage: Bool?, data: [NotificationElement]?) {
        self.status = status
        self.message = message
        self.data = data
        self.lastPage = lastPage
    }
}

// MARK: NotificationList convenience initializers and mutators

extension NotificationList {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NotificationList.self, from: data)
        self.init(status: me.status, message: me.message, lastPage: me.lastPage, data: me.data)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        status: Int?? = nil,
        message: String?? = nil,
        data: [NotificationElement]?? = nil
    ) -> NotificationList {
        return NotificationList(
            status: status ?? self.status,
            message: message ?? self.message,
            lastPage: lastPage ?? self.lastPage,
            data: data ?? self.data
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Datum
class NotificationElement: Codable {
    let notificationID, userID, otherID: Int?
    let title, description: String?
    let readStatus: Int?
    let type: JSONNull?
    let disable: Int?
    let created, createdAt, updatedAt: String?
    let isAdmin, productID: Int?
    let dispensarysID: JSONNull?
    let productName: String?
    let orderID, notificationType: Int?
    let image: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case notificationID = "notification_id"
        case userID = "user_id"
        case otherID = "other_id"
        case title, description
        case readStatus = "read_status"
        case type, disable, created
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isAdmin = "is_admin"
        case productID = "product_id"
        case dispensarysID = "dispensarys_id"
        case productName = "product_name"
        case orderID = "order_id"
        case notificationType, image, name
    }

    init(notificationID: Int?, userID: Int?, otherID: Int?, title: String?, description: String?, readStatus: Int?, type: JSONNull?, disable: Int?, created: String?, createdAt: String?, updatedAt: String?, isAdmin: Int?, productID: Int?, dispensarysID: JSONNull?, productName: String?, orderID: Int?, notificationType: Int?, image: String?, name: String?) {
        self.notificationID = notificationID
        self.userID = userID
        self.otherID = otherID
        self.title = title
        self.description = description
        self.readStatus = readStatus
        self.type = type
        self.disable = disable
        self.created = created
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isAdmin = isAdmin
        self.productID = productID
        self.dispensarysID = dispensarysID
        self.productName = productName
        self.orderID = orderID
        self.notificationType = notificationType
        self.image = image
        self.name = name
    }
}

// MARK: Datum convenience initializers and mutators

extension NotificationElement {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NotificationElement.self, from: data)
        self.init(notificationID: me.notificationID, userID: me.userID, otherID: me.otherID, title: me.title, description: me.description, readStatus: me.readStatus, type: me.type, disable: me.disable, created: me.created, createdAt: me.createdAt, updatedAt: me.updatedAt, isAdmin: me.isAdmin, productID: me.productID, dispensarysID: me.dispensarysID, productName: me.productName, orderID: me.orderID, notificationType: me.notificationType, image: me.image, name: me.name)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        notificationID: Int?? = nil,
        userID: Int?? = nil,
        otherID: Int?? = nil,
        title: String?? = nil,
        description: String?? = nil,
        readStatus: Int?? = nil,
        type: JSONNull?? = nil,
        disable: Int?? = nil,
        created: String?? = nil,
        createdAt: String?? = nil,
        updatedAt: String?? = nil,
        isAdmin: Int?? = nil,
        productID: Int?? = nil,
        dispensarysID: JSONNull?? = nil,
        productName: String?? = nil,
        orderID: Int?? = nil,
        notificationType: Int?? = nil,
        image: String?? = nil,
        name: String?? = nil
    ) -> NotificationElement {
        return NotificationElement(
            notificationID: notificationID ?? self.notificationID,
            userID: userID ?? self.userID,
            otherID: otherID ?? self.otherID,
            title: title ?? self.title,
            description: description ?? self.description,
            readStatus: readStatus ?? self.readStatus,
            type: type ?? self.type,
            disable: disable ?? self.disable,
            created: created ?? self.created,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            isAdmin: isAdmin ?? self.isAdmin,
            productID: productID ?? self.productID,
            dispensarysID: dispensarysID ?? self.dispensarysID,
            productName: productName ?? self.productName,
            orderID: orderID ?? self.orderID,
            notificationType: notificationType ?? self.notificationType,
            image: image ?? self.image,
            name: name ?? self.name
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

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
