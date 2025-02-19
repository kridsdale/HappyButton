import CarPlay
import MediaPlayer

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    var interfaceController: CPInterfaceController?
    var nowPlayingTemplate: CPNowPlayingTemplate?

    func templateApplicationScene(_ scene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController

        let tabBarTemplate = CPTabBarTemplate(templates: [
            createLibraryTemplate(),
            createNowPlayingTemplate()
        ])

        interfaceController.setRootTemplate(tabBarTemplate, animated: true)
    }

    func createLibraryTemplate() -> CPListTemplate {
        let songItem = CPListItem(text: "Example Song", detailText: "Artist Name")
        songItem.handler = { _, completion in
            print("Song selected")
            completion()
        }
        let section = CPListSection(items: [songItem])
        let listTemplate = CPListTemplate(title: "Library", sections: [section])
        return listTemplate
    }

    func createNowPlayingTemplate() -> CPNowPlayingTemplate {
        return CPNowPlayingTemplate()
    }
}