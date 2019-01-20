//  Copyright © 2019 June Ha. All rights reserved.

import UIKit
import SnapKit
import SDWebImage


class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"

    var product: Product! {
        didSet {
            render(product)
        }
    }

    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    private var inventoryLabel: UILabel!
    private var tagIconImageView: UIImageView!
    private var collectionTagLabel: UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)

        productImageView = UIImageView(image: UIImage(named: "home"))
//        productImageView.backgroundColor = .yellow
        productImageView.contentMode = .scaleAspectFit
        addSubview(productImageView)

        productTitleLabel = UILabel()
//        productTitleLabel.backgroundColor = .white
        productTitleLabel.text = "Product test very long title please tell me this is good"
        productTitleLabel.textAlignment = .left
        productTitleLabel.numberOfLines = 0
        productTitleLabel.lineBreakMode = .byWordWrapping
        productTitleLabel.textColor = .black
        productTitleLabel.font = .boldSystemFont(ofSize: 12)
        addSubview(productTitleLabel)

        inventoryLabel = UILabel()
//        inventoryLabel.backgroundColor = .cyan
        inventoryLabel.text = "Inventory test"
        inventoryLabel.textAlignment = .left
        inventoryLabel.numberOfLines = 1
        inventoryLabel.textColor = .black
        inventoryLabel.font = .systemFont(ofSize: 10)
        addSubview(inventoryLabel)

        tagIconImageView = UIImageView()
//        tagIconImageView.backgroundColor = .white
        tagIconImageView.contentMode = .scaleAspectFit
        addSubview(tagIconImageView)

        collectionTagLabel = UILabel()
//        collectionTagLabel.backgroundColor = .brown
        collectionTagLabel.text = "Collection type test"
        collectionTagLabel.textAlignment = .left
        collectionTagLabel.numberOfLines = 0
        collectionTagLabel.lineBreakMode = .byWordWrapping
        collectionTagLabel.textColor = .gray
        collectionTagLabel.font = .systemFont(ofSize: 10)
        addSubview(collectionTagLabel)

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Helpers

    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(productImageView.snp.width).multipliedBy(0.6)
        }

        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview()
        }

        inventoryLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview()
        }

        tagIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.width.equalToSuperview().multipliedBy(0.05)
            make.height.equalTo(tagIconImageView.snp.width)
            make.centerY.equalTo(collectionTagLabel.snp.centerY)
        }

        collectionTagLabel.snp.makeConstraints { make in
            make.top.equalTo(inventoryLabel.snp.bottom).offset(5)
            make.leading.equalTo(tagIconImageView.snp.trailing).offset(5)
//            make.bottom.equalToSuperview().offset(-15)
        }
    }

    private func render(_ product: Product) {
        productImageView.sd_setImage(with: URL(string: product.image.src), placeholderImage: nil, options: .continueInBackground, completed: nil)
        productTitleLabel.text = product.title
        collectionTagLabel.text = product.tags

        var totalInventory = 0
        for variant in product.variants {
            totalInventory += variant.inventoryQuantity
        }

        inventoryLabel.text = "\(totalInventory) in stock"
    }
}
