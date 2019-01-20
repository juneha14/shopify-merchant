//  Copyright © 2019 June Ha. All rights reserved.

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()

        let myCollectionsVC = MyCollectionsViewController()
        let navigationVC = UINavigationController(rootViewController: myCollectionsVC)
        window?.rootViewController = navigationVC

        return true
    }
}
