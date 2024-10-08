import UIKit

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        bind()
    }
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addView()
        layout()
    }
    open func attribute() {
    }
    open func bind() {
    }
    open func addView() {
    }
    open func layout() {
    }
}
