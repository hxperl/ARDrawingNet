//
//  VisualEffectView.swift
//  DrawingNet
//
//  Created by Geonseok Lee on 2020/03/31.
//  Copyright © 2020 Geonseok Lee. All rights reserved.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
	var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct VisualEffectView_Previews: PreviewProvider {
    static var previews: some View {
		VisualEffectView(effect: UIBlurEffect(style: .dark))
    }
}
