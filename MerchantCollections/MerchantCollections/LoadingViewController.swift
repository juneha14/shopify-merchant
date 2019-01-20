//  Copyright © 2019 June Ha. All rights reserved.

import UIKit
import SnapKit


class LoadingViewController: UIViewController {
    private lazy var activityIndicator = UIActivityIndicatorView(style: .gray)


    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
}
