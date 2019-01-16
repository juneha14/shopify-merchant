//  Copyright © 2019 June Ha. All rights reserved.

import UIKit


class MyCollectionsViewController: UITableViewController {

    private struct Constants {

    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "My Collections"

        tableView.register(MyCollectionsTableViewCell.self, forCellReuseIdentifier: MyCollectionsTableViewCell.identifier)
    }


    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let myCollectionCell = tableView.dequeueReusableCell(withIdentifier: MyCollectionsTableViewCell.identifier, for: indexPath) as? MyCollectionsTableViewCell else {
            return UITableViewCell()
        }

        // Configure myCollectionCell here
        myCollectionCell.collectionTitle.text = "test cell number: \(indexPath.row)"

        return myCollectionCell
    }


    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
