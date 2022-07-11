//
//  LocationView.swift
//  TeslaMockupApp
//
//  Created by Ajitkumar Marigoli on 07/07/22.
//

import SwiftUI
import MapKit

struct CarLocation: Identifiable{
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

let carLocations = [CarLocation(latitude: 12.991700, longitude: 77.571520)]

struct LocationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 12.991753, longitude: 77.569641), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $location, annotationItems: carLocations, annotationContent: { location in MapAnnotation(coordinate: location.coordinate, content: {CarPin()})
            })
            
            CarLocationPanel()
//            LinearGradient(gradient: Gradient(colors: [Color("DarkGray"), .clear]), startPoint: .top, endPoint: .bottom)
//                .allowsHitTesting(false)
            VStack {
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        GeneralButton(icon: "chevron.left")
                            .background(Color("DarkGray").opacity(0.5))
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button(action:{}){
                        GeneralButton(icon: "speaker.wave.3.fill")
                            .background(Color("DarkGray").opacity(0.5))
                            .clipShape(Circle())
                    }
                }
                .padding()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkGray"))
        .foregroundColor(.white)
        .navigationTitle("Fast & Furious")
        .navigationBarHidden(true)
    }
}

struct CarPin:View{
    var body: some View{
        VStack(alignment: .center, spacing: 4){
            Image(systemName: "car.fill")
                .frame(width: 36, height: 36, alignment: .center)
                .background(Color("Red"))
                .foregroundColor(.white)
                .clipShape(Circle())
            Text("Fast & Furious")
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(.black.opacity(0.1), lineWidth: 1))
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}

struct CarLocationPanel: View {
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading, spacing: 10){
                VStack(alignment: .leading, spacing: 5){
                    Text("Location")
                        .font(.title)
                        .fontWeight(.semibold)
                    CustomDivider()
                    Label("Outside Mantri Square Mall", systemImage: "location")
                        .font(.body)
                        .opacity(0.5)
                }
                VStack(alignment: .leading, spacing: 5){
                    VStack(alignment: .leading, spacing: 5){
                        Text("Summon")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Press and Hold Controls to move Vehicle")
                            .opacity(0.5)
                            .font(.callout)
                    }
                    CustomDivider()
                    FullButton(text: "Go To Target")
                    HStack{
                        FullButton(text: "Forward", icon: "arrow.up")
                        FullButton(text: "Backward", icon: "arrow.down")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("DarkGray"))
            .foregroundColor(.white)
            .cornerRadius(16, corners: [.topLeft, .topRight])
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
