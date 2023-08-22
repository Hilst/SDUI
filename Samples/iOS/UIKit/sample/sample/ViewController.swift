import UIKit
import SDUI

class ViewController: UIViewController {

	private lazy var label: UILabel = UILabel()
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		label.text = SDUI().text
		label.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(label)
		label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
}

