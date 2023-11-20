
import UIKit

class ViewController: UIViewController {

    // MARK: - Init
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        return nil
    }

    // MARK: - Functions
    func showError(with message: String) {
        let alert = UIAlertController(title: "alert_error_title".localized,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "alert_error_ok".localized,
                                      style: UIAlertAction.Style.cancel,
                                      handler: { _ in

        }))

        self.present(alert, animated: true, completion: nil)
    }
}
