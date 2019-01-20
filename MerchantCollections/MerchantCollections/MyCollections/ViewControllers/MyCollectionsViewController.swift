//  Copyright © 2019 June Ha. All rights reserved.

import UIKit


class MyCollectionsViewController: UITableViewController {
    private let collectionService: CollectionService
    private var myCollections = [CustomCollection]()


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

        tableView.register(MyCollectionsTableViewCell.self, forCellReuseIdentifier: MyCollectionsTableViewCell.identifier)
        tableView.tableFooterView = UIView()

        loadCollections()
    }


    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCollections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCollectionsTableViewCell.identifier, for: indexPath) as? MyCollectionsTableViewCell else {
            return UITableViewCell()
        }

        cell.collection = myCollections[indexPath.row]
        return cell
    }


    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: navigate to the details screen with the CustomCollection at the specified indexPath
        let collectionDetailsVC = CollectionDetailsViewController()
        navigationController?.pushViewController(collectionDetailsVC, animated: true)
    }


    // MARK: Helpers

    private func loadCollections() {
        collectionService.loadMyCollections { [weak self] result in
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
