//
//  ContentView.swift
//  DrawingNet
//
//  Created by Geonseok Lee on 2020/03/31.
//  Copyright © 2020 Geonseok Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	
	@State var hexColor: String = "#FFFFFF"
	
    var body: some View {
		let arView = ARDrawViewContainer(hexColor: $hexColor)
		return ZStack {
				arView
				VStack {
					HStack {
						Spacer()
						Button(action: { arView.share() }) {
							Text("Share session")
						}
						.frame(width: 150, height: 30)
						.background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
						.padding()
					}
					Spacer()
					ColorSelectView(hexColor: $hexColor)
				}
			}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
