//
//  ContentView.swift
//  HappyButton
//
//  Created by Kevin Ridsdale on 2/18/25.
//

import CarPlay
import MediaPlayer
import SwiftData
import SwiftUI

import AVFoundation
import SwiftUI

struct ContentView: View {
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            Color.blue // Add this to verify the ZStack is showing

            Image("BackgroundImage")
                .resizable()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Hello World") // Add this to verify buttons are present
                    .foregroundColor(.white)

                Button("Play") {
                    if let url = URL(string: "https://example.com/audio.mp3") {
                        player = AVPlayer(url: url)
                        player?.play()
                    }
                }
                .padding()
                .background(Color.white) // Make button visible against any background

                Button("Pause") {
                    player?.pause()
                }
                .padding()
            }
        }
    }
}

//
// struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
// }
//
// #Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
// }
