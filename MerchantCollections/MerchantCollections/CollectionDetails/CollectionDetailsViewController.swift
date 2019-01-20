//  Copyright © 2019 June Ha. All rights reserved.

import UIKit
import SnapKit


class CollectionDetailsViewController: UIViewController, UICollectionViewDataSource {
    private let customCollection: CustomCollection
    private let collectionService: CollectionService
    private let productService: ProductService
    private var products = [Product]()

    private var collectionView: UICollectionView!
    private lazy var loadingViewController = LoadingViewController()

    private struct Constants {
        static let minimumInteritemSpacing: CGFloat = 2
        static let collectionViewInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }


    // MARK: Initializer

    init(customCollection: CustomCollection, collectionService: CollectionService = CollectionService(), productService: ProductService = ProductService()) {
        self.customCollection = customCollection
        self.collectionService = collectionService
        self.productService = productService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = customCollection.title

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.minimumLineSpacing = Constants.minimumInteritemSpacing

        let collectionViewInsets = Constants.collectionViewInsets
        let cellWidth = (view.frame.width - collectionViewInsets.left - collectionViewInsets.right - Constants.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = collectionViewInsets

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .groupTableViewBackground
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        view.addSubview(collectionView)

        setupConstraints()

        loadCollects()
    }


    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        cell.backgroundColor = .white
        cell.product = products[indexPath.row]
        return cell
    }


    // MARK: Helpers

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func loadCollects() {
        add(loadingViewController)
        collectionService.loadCollects(in: customCollection) { [weak self] result in
            switch result {
            case .success(let collects):
                self?.loadProducts(from: collects)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func loadProducts(from collects: [Collect]) {
        let productIdsQuery = extractProductIds(from: collects)

        productService.loadProducts(withProductQuery: productIdsQuery) { [weak self] result in
            self?.loadingViewController.remove()

            switch result {
            case .success(let products):
                self?.products = products
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func extractProductIds(from collects: [Collect]) -> String {
        var productIds = Set<String>()
        for collect in collects {
            productIds.insert(String(collect.productId))
        }

        return productIds.joined(separator: ",")
    }
}
