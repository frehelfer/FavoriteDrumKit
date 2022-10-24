//
//  ContentView.swift
//  FavoriteDrumKit
//
//  Created by Frédéric Helfer on 22/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = DataController()
    
    @State private var enteredDrumKit = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add your favorite drumkit", text: $enteredDrumKit)
                        .padding()
                        .background(.gray.opacity(0.3))
                        .cornerRadius(10)
                    
                    Button {
                        vm.createDrumKit(name: enteredDrumKit)
                        enteredDrumKit = ""
                    } label: {
                        Label("Add new drum kit", systemImage: "plus")
                            .foregroundColor(.primary)
                            .labelStyle(.iconOnly)
                            .padding()
                            .background(.green.opacity(0.8))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                List {
                    ForEach(vm.savedEntities) { kit in
                        DrumKitRowView(vm: vm, kit: kit)
                    }
                    .onDelete(perform: vm.deleteDrumKit)
                }
            }
            .navigationTitle("FavoriteDrumKit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct DrumKitRowView: View {
    @ObservedObject var vm: DataController
    var kit: DrumKitEntity
    
    var body: some View {
        HStack {
            Text(kit.wrappedName)
            
            Spacer()
            
            Button {
                vm.updateFavorite(kit: kit)
            } label: {
                Label("Add to favorite", systemImage: kit.favorite ? "star.fill" : "star")
                    .font(.title3)
                    .labelStyle(.iconOnly)
                    .foregroundColor(kit.favorite ? .yellow : .gray.opacity(0.6))
            }
        }
    }
}
