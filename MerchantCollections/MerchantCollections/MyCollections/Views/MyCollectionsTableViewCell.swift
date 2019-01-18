//  Copyright © 2019 June Ha. All rights reserved.

import UIKit
import SnapKit


class MyCollectionsTableViewCell: UITableViewCell {
    // Set up collection property observer here to allow for functional rendering of the cell

    static let identifier = "MyCollectionsTableViewCell"

    var collectionTitle: UILabel!
    private var collectionImage: UIImageView!


    // MARK: Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        collectionTitle = UILabel()
        collectionTitle.font = .systemFont(ofSize: 18)

        collectionImage = UIImageView()
        collectionImage.contentMode = .scaleAspectFit

        addSubview(collectionTitle)
        //addSubview(collectionImage)

        setupContraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Helpers

    private func setupContraints() {
        collectionTitle.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
        }
    }
}
