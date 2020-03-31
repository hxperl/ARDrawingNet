//
//  ARDrawViewContainer.swift
//  DrawingNet
//
//  Created by Geonseok Lee on 2020/03/31.
//  Copyright © 2020 Geonseok Lee. All rights reserved.
//

import SwiftUI
import ARKit

struct ARDrawViewContainer: UIViewRepresentable {
	
	@Binding var hexColor: String
	let arDrawView = ARDrawView(frame: .zero)
	
	func makeUIView(context: Context) -> ARDrawView {
		arDrawView
	}
	
	func updateUIView(_ uiView: ARDrawView, context: Context) {
		uiView.hexColor = hexColor
	}
	
	func share() {
		arDrawView.shareSession()
	}
}
