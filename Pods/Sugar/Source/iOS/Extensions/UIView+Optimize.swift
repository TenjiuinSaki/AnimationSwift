import UIKit

public extension UIView {

  func optimize() {
    clipsToBounds = true
    layer.drawsAsynchronously = true
    isOpaque = true
  }
}
