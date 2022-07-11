//
//  ContentView.swift
//  TeslaMockupApp
//
//  Created by Ajitkumar Marigoli on 05/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var openVoiceCommand: Bool = false
    @State private var openMediaControl: Bool = false
    @State private var openCharging: Bool = false
    @State private var actionText = ""
    @State private var actionIcon = ""
    @State private var openAction = false
    
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 20){
                        HomeHeader()
                        CustomDivider()
                        CarImageSection(openCharging: $openCharging)
                        CustomDivider()
                        CategeryView(openAction: $openAction, actionText: $actionText, actionIcon: $actionIcon, openCharging: $openCharging, openMediaControl: $openMediaControl, title: "Quick Shortcuts", showEdit: true, actionItems: quickShortcuts)
                        CustomDivider()
                        CategeryView(openAction: $openAction, actionText: $actionText, actionIcon: $actionIcon, openCharging: $openCharging, openMediaControl: $openMediaControl, title: "Recent Actions", showEdit: false, actionItems: recentActions)
                        CustomDivider()
                        AllSettings()
                        ReorderButton()
                    }
                    .padding()
                }
                VoiceCommandButton(open: $openVoiceCommand)
                
                if (openVoiceCommand || openCharging || openMediaControl || openAction){
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                openVoiceCommand = false
                                openCharging = false
                                openMediaControl = false
                                openAction = false
                            }
                        }
                }
                
                if openVoiceCommand{
                    VoiceCommandView(open: $openVoiceCommand, text: "Take me to Majestic Bus Stand")
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                if openCharging{
                    ChargingView()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                if openMediaControl{
                    MediaPlayer()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                if openAction && !actionText.isEmpty{
                    ActionNotification(open: $openAction, icon: actionIcon, text: actionText)
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
            }
            .background(Color("DarkGray"))
            .foregroundColor(.white)
            .navigationTitle("Fast & Furious")
            .navigationBarHidden(true)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct VoiceCommandButton: View{
    
    @Binding var open: Bool
    
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button(action:{
                    withAnimation {
                        open = true
                    }
                }){
                    Image(systemName: "mic.fill")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .frame(width: 70, height: 70)
                        .background(Color("Green"))
                        .foregroundColor(Color("DarkGray"))
                        .clipShape(Circle())
                        .padding(.trailing, 17)
                        .shadow(radius: 10)
                }
            }
        }
    }
}

struct HomeHeader: View {
    var body: some View{
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text("Model S".uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(.red)
                    .clipShape(Capsule())
                Text("Fast & Furious")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Spacer()
            HStack{
                Button(action: {}){
                    GeneralButton(icon: "lock.fill")
                }
                Button(action: {}){
                    GeneralButton(icon: "gear")
                }
            }
        }
        .padding(.top)
    }
}

struct CarImageSection: View{
    @Binding var openCharging: Bool
    
    var body: some View{
        VStack{
            HStack(alignment:.center){
                Button(action: {
                    withAnimation {
                        openCharging = true
                    }
                }){
                    Label("250 miles".uppercased(), systemImage: "battery.75")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Green"))
                }
                Spacer()
                VStack(alignment:.trailing){
                    Text("Parked")
                        .fontWeight(.medium)
                    Spacer(minLength: 5)
                    Text("Last Updated 5 mins ago")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            Image("whiteTesla")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct CategeryHeader: View{
    var title: String
    var showEdit: Bool = false
    var body: some View{
        VStack{
            HStack(alignment: .center){
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                if showEdit{
                    Button(action: {}){
                        Text("Edit")
                            .foregroundColor(.gray)
                            .fontWeight(.medium)
                    }
                }
            }
        }
    }
}

struct CategeryView: View{
    
    @Binding var openAction: Bool
    @Binding var actionText: String
    @Binding var actionIcon: String
    @Binding var openCharging: Bool
    @Binding var openMediaControl: Bool

    var title: String
    var showEdit: Bool
    var actionItems: [ActionItem]
    
    var body: some View{
        VStack{
            CategeryHeader(title: title, showEdit: showEdit)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top){
                    if title == "Quick Shortcuts"{
                        Button(action: {openCharging = true}){
                            ActionButtons(item: chargingShortcut)
                        }
                        
                        Button(action: {openMediaControl = true}){
                            ActionButtons(item: mediaShortCut)
                        }
                    }
                    ForEach(actionItems, id:\.self){ item in
                        Button(action: {
                            withAnimation {
                                openAction = true
                                actionText = item.labelText
                                actionIcon = item.icon
                            }
                        }){
                            ActionButtons(item: item)
                        }
                    }
                }
            }
        }
    }
}

let quickShortcuts: [ActionItem] = [
    ActionItem(icon: "fanblades.fill", labelText: "Fan On"),
    ActionItem(icon: "bolt.car", labelText: "Close charge port")
]

let chargingShortcut = ActionItem(icon: "bolt.fill", labelText: "Charging")
let mediaShortCut = ActionItem(icon: "music.note", labelText: "Music Control")

let recentActions: [ActionItem] = [
    ActionItem(icon: "arrow.up.square", labelText: "Open Trunk"),
    ActionItem(icon: "fanblades", labelText: "Fan Off"),
    ActionItem(icon: "person.fill.viewfinder", labelText: "Summon"),
    ActionItem(icon: "chevron.down", labelText: "Close Doors"),
    ActionItem(icon: "chevron.up", labelText: "Open Doors")
]

struct AllSettings: View{
    var body: some View{
        VStack{
            CategeryHeader(title: "All Settings")
            LazyVGrid(columns: [GridItem(),GridItem()]){
                NavigationLink(destination: CarControlsView()) {
                    SettingBlock(icon: "car.fill", title: "Controls",subTitle: "car locked")
                }
                SettingBlock(icon: "fanblades.fill", title: "Climate", subTitle: "37ºC inside", backgroundColor: Color("Blue"))
                NavigationLink(destination: LocationView()) {
                    SettingBlock(icon: "location.fill", title: "Location",subTitle: "Mantri Square Mall")
                }
                SettingBlock(icon: "checkerboard.shield", title: "Security",subTitle: "0 events detected")
                SettingBlock(icon: "sparkles", title: "upgrade", subTitle: "3 upgrades available")
            }
        }
    }
}

struct SettingBlock: View{
    var icon: String
    var title: String
    var subTitle: String
    
    var backgroundColor: Color = Color.white.opacity(0.05)
    
    var body: some View{
        HStack(alignment:.center, spacing: 5){
            Image(systemName: icon)
            VStack(alignment:.leading, spacing: 5){
                Text(title)
                    .fontWeight(.semibold)
                    .font(.system(size: 20, weight: .medium, design: .default))
                Text(subTitle)
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 5)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white.opacity(0.1),lineWidth: 0.5))
    }
}

struct ReorderButton: View{
    var body: some View{
        Button(action: {}){
            Text("Reorder Groups")
                .font(.caption)
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(.white.opacity(0.05))
                .clipShape(Capsule())
        }
    }
}
