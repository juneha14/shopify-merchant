//  Copyright © 2019 June Ha. All rights reserved.

import UIKit
import SnapKit


class CollectionDetailsViewController: UIViewController, UICollectionViewDataSource {
    private var collectionView: UICollectionView!

    private struct Constants {
        static let minimumInteritemSpacing: CGFloat = 5
        static let collectionViewInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }


    // MARK: Initializer

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Collection Details" // TODO: change this to actual title of the collection

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.minimumLineSpacing = Constants.minimumInteritemSpacing

        let collectionViewInsets = Constants.collectionViewInsets
        let cellWidth = (view.frame.width - collectionViewInsets.left - collectionViewInsets.right - Constants.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = collectionViewInsets

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)

        view.addSubview(collectionView)

        setupConstraints()
    }


    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 55
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        cell.backgroundColor = .gray
    
        return cell
    }


    // MARK: Helpers

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
