import UIKit
import DesignSystem
import Core
import SnapKit
import Then
import RxSwift
import RxCocoa

class MoreViewController: UIViewController {
    @objc public func didTapMoreButton() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "수정하기", style: .default) { _ in
            print("수정뷰 ㄱㄱ")
        }
        let deleteAction = UIAlertAction(title: "게시물 삭제", style: .destructive) { _ in
            self.showAlert()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    private func showAlert() {
        let title = "게시물을 삭제하시겠습니까?"
        let message = "삭제하면 다시 복구할 수 없습니다"
        let alertStyle: UIAlertController.Style = .alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let confirmAction = UIAlertAction(title: "삭제", style: .destructive) {_ in
            self.cancel()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }

    private func cancel() {
        print("게시물이 삭제되었따 ㅋㅋㄹㅃㅃ")
    }
}
