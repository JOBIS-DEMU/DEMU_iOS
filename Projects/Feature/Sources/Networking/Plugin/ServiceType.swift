import Foundation

enum NetworkingResult: Int {
    case ok = 200
    case deleteOk = 204
    case createOk = 201
    case wrongRq = 400
    case tokenError = 401
    case expiredToken = 403
    case notFound = 404
    case conflict = 409
    case fault = 0
    case serverError = 500
}
