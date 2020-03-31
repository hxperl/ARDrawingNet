//
//  ColorSelectView.swift
//  DrawingNet
//
//  Created by Geonseok Lee on 2020/03/31.
//  Copyright © 2020 Geonseok Lee. All rights reserved.
//

import SwiftUI

struct ColorSelectView: View {

	let hexColors: [String] = ["#EE404E", "#F5A623", "#F8E71C", "#7ED321", "#65E4FF", "#3884FF", "#3929D8", "#9013FE", "#8B572A", "#FF6C37",
	"#FFA6EB", "#31BE9F", "#FFFFFF", "#9B9B9B", "#4A4A4A", "#000000"]
	
	@Binding var hexColor: String
	
    var body: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 10) {
				ForEach(hexColors, id: \.self) { colorString in
					Circle()
						.fill(Color(hex: colorString))
						.frame(width:40, height: 40)
						.onTapGesture {
							self.hexColor = colorString
					}
				}
			}
		}
		.padding()
		.background(VisualEffectView(effect: UIBlurEffect(style: .dark)))
    }
}

struct ColorSelectView_Previews: PreviewProvider {
    static var previews: some View {
		ColorSelectView(hexColor: .constant("#ffffff"))
    }
}
