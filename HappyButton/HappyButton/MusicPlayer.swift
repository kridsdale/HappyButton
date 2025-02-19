//
import AVFoundation
import CarPlay
import MediaPlayer

protocol MusicPlayerProtocol {
    func playSong(_ song: MPMediaItem)
    func pause()
    func cleanup()
    func resume()
    func stop()
    var isPlaying: Bool { get }
    var currentSong: MPMediaItem? { get }
}

// MARK: - MusicPlayer

class MusicPlayer: MusicPlayerProtocol {
    private var player: AVPlayer?
    private(set) var currentSong: MPMediaItem?

    var isPlaying: Bool {
        guard let player else { return false }
        return player.rate != 0 && player.error == nil
    }

    func playSong(_ song: MPMediaItem) {
        guard let url = song.assetURL else { return }
        player = AVPlayer(url: url)
        currentSong = song
        player?.play()
    }

    func pause() {
        player?.pause()
    }

    func resume() {
        player?.play()
    }

    func stop() {
        player?.pause()
        player?.seek(to: .zero)
    }

    func cleanup() {
        player?.pause()
        player = nil
        currentSong = nil
    }
}

// MARK: - CarPlayTemplateManagerImpl

class CarPlayTemplateManagerImpl: CarPlayTemplateManager {
    private var currentPlaylist: [MPMediaItem] = []
    private let musicPlayer: MusicPlayerProtocol

    init(musicPlayer: MusicPlayerProtocol) {
        self.musicPlayer = musicPlayer
    }

    func setupAudioInterface(_ interfaceController: CPInterfaceController) {
        // Get all songs from media library
        let query = MPMediaQuery.songs()
        guard let songs = query.items else { return }
        currentPlaylist = songs

        // Create list items for each song
        let listItems = songs.map { song in
            let listItem = CPListItem(text: song.title ?? "Unknown",
                                      detailText: song.artist ?? "Unknown Artist",
                                      image: nil)

            listItem.handler = { [weak self] _, completion in
                self?.musicPlayer.playSong(song)
                completion()
            }

            return listItem
        }

        // Create section and template
        let section = CPListSection(items: listItems)
        let listTemplate = CPListTemplate(title: "Music Library", sections: [section])

        // Set as root template
        interfaceController.setRootTemplate(listTemplate, animated: true) { _, error in
            if let error {
                print("Error setting CarPlay template: \(error.localizedDescription)")
            }
        }
    }

    func cleanup() {
        currentPlaylist = []
    }
}
