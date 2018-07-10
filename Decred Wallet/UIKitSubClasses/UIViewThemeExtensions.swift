import Foundation
import UIKit

// MARK: - Theme

extension UIView {
    @objc func changeSkin() {
        backgroundColor = AppDelegate.shared.theme.backgroundColor
    }

    func subscribeToThemeUpdates() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeSkin),
            name: Notification.Name.appSkinDidChange,
            object: nil
        )
    }
}
