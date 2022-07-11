//
//  CarControlsView.swift
//  TeslaMockupApp
//
//  Created by Ajitkumar Marigoli on 07/07/22.
//

import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer!

let carControls: [ActionItem] = [
    ActionItem(icon: "flashlight.on.fill", labelText: "Flash"),
    ActionItem(icon: "speaker.wave.3.fill", labelText: "Honk"),
    ActionItem(icon: "key.fill", labelText: "Start"),
    ActionItem(icon: "arrow.up.bin", labelText: "Front Trunk"),
    ActionItem(icon: "arrow.up.square", labelText: "Trunk")
]

struct CarControlsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var toggleValet: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            GeneralButton(icon: "chevron.left")
                        }
                        Spacer()
                    }
                    Text("Car Controls")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                CustomDivider()
                CarLockButton()
                CustomDivider()
                CarControlAction()
                CustomDivider()
                HStack{
                    Text("Valet Mode")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Toggle("", isOn: $toggleValet)
                }
            }
            .padding()
        }
        .background(Color("DarkGray"))
        .foregroundColor(.white)
        .navigationTitle("Fast & Furious")
        .navigationBarHidden(true)
    }
}

struct CarControlsView_Previews: PreviewProvider {
    static var previews: some View {
        CarControlsView()
    }
}

struct CarLockButton: View{
    var body: some View{
        Button(action: {}) {
            FullButton(text: "Unlock Car", icon: "lock.fill")
        }
    }
}

struct CarControlAction: View{
    @StateObject var torchState = TorchState()
    
    var body: some View{
        VStack(spacing: 20){
            HStack{
                Spacer()
                Button(action: {
                    torchState.isOn = !torchState.isOn
                }){
                    ActionButtons(item: carControls[0])
                }
                Spacer()
                Button(action: {
                    torchState.playSound(type: "mp3")
                    torchState.isGladiator = !torchState.isGladiator
                }){
                    ActionButtons(item: carControls[1])
                }
                Spacer()
                ActionButtons(item: carControls[2])
                Spacer()
            }
            HStack{
                Spacer()
                ActionButtons(item: carControls[3])
                Spacer()
                ActionButtons(item: carControls[4])
                Spacer()
            }
        }
        .padding()
    }
}

class TorchState: ObservableObject {
    
    @Published var isGladiator: Bool = false
    
    @Published var isOn: Bool = false {
        didSet {
            toggleTorch(isOn)
        }
    }
    
    private func toggleTorch(_ isOn: Bool) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            device.torchMode = isOn ? .on : .off
            
            if isOn {
                try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func playSound(type: String){
        var sound = ""
        if isGladiator{
            sound = "gladiator"
        }else{
            sound = "thisissparta"
        }
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("ERROR")
            }
        }else{
            print("not found")
        }
    }
}
