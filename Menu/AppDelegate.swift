import UIKit

func dispatchAfter(seconds: Double, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: block)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = makeRoot()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func makeRoot() -> UINavigationController {
        let controller = RootViewController()
        return UINavigationController(rootViewController: controller)
    }
}
