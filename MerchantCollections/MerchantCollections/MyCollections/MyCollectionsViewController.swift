//  Copyright © 2019 June Ha. All rights reserved.

import UIKit


class MyCollectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let collectionService: CollectionService
    private var myCollections = [CustomCollection]()

    private var tableView: UITableView!


    // MARK: Initializers

    init(collectionService: CollectionService = CollectionService()) {
        self.collectionService = collectionService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "My Collections"

        tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyCollectionsTableViewCell.self, forCellReuseIdentifier: MyCollectionsTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        loadCollections()
    }


    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCollections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCollectionsTableViewCell.identifier, for: indexPath) as? MyCollectionsTableViewCell else {
            return UITableViewCell()
        }

        cell.collection = myCollections[indexPath.row]
        return cell
    }


    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let collection = myCollections[indexPath.row]
        let collectionDetailsVC = CollectionDetailsViewController(customCollection: collection, collectionService: collectionService)
        navigationController?.pushViewController(collectionDetailsVC, animated: true)
    }


    // MARK: Helpers

    private func loadCollections() {
        let loadingVC = LoadingViewController()
        add(loadingVC)

        collectionService.loadMyCollections { [weak self] result in
            loadingVC.remove()
            
            switch result {
            case .success(let value):
                self?.myCollections = value
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
