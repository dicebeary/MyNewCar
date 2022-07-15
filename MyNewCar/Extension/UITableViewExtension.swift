import UIKit

extension UITableViewCell {
    static var nib: UINib { UINib(nibName: identifier, bundle: nil) }
    
    static var identifier: String { String(describing: self) }
}
