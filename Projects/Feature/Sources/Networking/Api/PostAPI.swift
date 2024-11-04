import Foundation
import RxSwift
import RxCocoa
import Moya

enum PostAPI {
    case postCreate(title: String, content: String, major: String, images: [Data])
    case postFix(content: String, title: String, major: String)
    case postSuggestion(postId: Int)
    case postCheck(postId: Int)
    case postUserCheck
    case postDelete(postId: Int)
    case postRate
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.25.126:8080")!
    }

    var path: String {
        switch self {
        case .postCreate:
            return "/post/create"
        case .postFix(let postId):
            return "/post/update/\(postId)"
        case .postSuggestion(let postId):
            return "/post/recommend/\(postId)"
        case .postCheck(let postId):
            return "/post/get/\(postId)"
        case .postUserCheck:
            return "/post/get/my-posts"
        case .postDelete(let postId):
            return "/post/delete/\(postId)"
        case .postRate:
            return "/post/grade"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postFix, .postRate:
            return .patch
        case .postCheck, .postUserCheck:
            return .get
        case .postDelete:
            return .delete
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postCreate(let title, let content, let major, let images):
            var formData = [MultipartFormData]()
            if let jsonData = try? JSONSerialization.data(
                withJSONObject: [
                    "title": title,
                    "content": content,
                    "major": major
                ],
                options: []
            ) {
                let jsonPart = MultipartFormData(provider: .data(jsonData), name: "post", mimeType: "application/json")
                formData.append(jsonPart)
            }

            for (index, imageData) in images.enumerated() {
                let imagePart = MultipartFormData(
                    provider: .data(imageData),
                    name: "images",
                    fileName: "image\(index).jpg",
                    mimeType: "image/jpeg"
                )
                formData.append(imagePart)
            }

            return .uploadMultipart(formData)
            //            var formData = [MultipartFormData]()
            //            return .requestParameters(
            //                parameters: [
            //                    "title": title,
            //                    "content": content,
            //                    "major": major
            //                ], encoding: JSONEncoding.default
            //            )
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .postCreate, .postFix, .postSuggestion, .postCheck, .postUserCheck, .postDelete, .postRate:
            return Header.accessToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
