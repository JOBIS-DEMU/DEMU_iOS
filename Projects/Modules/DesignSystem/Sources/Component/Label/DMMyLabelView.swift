import UIKit
import SnapKit
import Then

public enum MlType {
    case setting
    case write
    var text: String {
        switch self {
        case .setting:
            return "설정"
        case .write:
            return "글쓰기"
        }
    }
}

public class DMMyLabelView: UIView {
    
}

