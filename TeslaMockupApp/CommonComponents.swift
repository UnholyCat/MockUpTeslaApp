//
//  CommonComponents.swift
//  TeslaMockupApp
//
//  Created by Ajitkumar Marigoli on 07/07/22.
//

import Foundation
import SwiftUI

struct GeneralButton: View{
    var icon: String
    var body: some View{
        Image(systemName: icon)
            .imageScale(.large)
            .frame(width: 50, height: 50)
            .background(.white.opacity(0.1))
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.white.opacity(0.1),lineWidth: 0.5)
            )
    }
}

struct CustomDivider: View{
    var body: some View{
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 0.25)
            .background(.white)
            .opacity(0.1)
    }
}

struct ActionButtons: View{
    var item: ActionItem
    
    var body: some View{
        VStack(alignment: .center, spacing: 5){
            GeneralButton(icon: item.icon)
            Text(item.labelText)
                .frame(width: 72)
                .font(.system(size: 12, weight: .semibold, design: .default))
                .multilineTextAlignment(.center)
        }
    }
}

struct ActionItem: Hashable {
    var icon: String
    var labelText: String
}

struct FullButton: View{
    var text: String
    var icon: String = ""
    
    var body: some View{
        if icon.isEmpty{
            textButton
        }else{
            iconButton
        }
    }
    
    var iconButton: some View{
        Label(text, systemImage: icon)
            .font(.system(size: 14, weight: .medium, design: .default))
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(.white.opacity(0.1), lineWidth: 0.5)
            )
    }
    
    var textButton:some View{
        Text(text)
            .font(.system(size: 14, weight: .medium, design: .default))
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(.white.opacity(0.1), lineWidth: 0.5)
            )
    }
}
