
// MARK: - MusicPlayer
class MusicPlayer: MusicPlayerProtocol {
    private var player: AVPlayer?
    
    func playSong(_ song: MPMediaItem) {
        guard let url = song.assetURL else { return }
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func cleanup() {
        player?.pause()
        player = nil
    }
}