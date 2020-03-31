//
//  ARDrawView.swift
//  DrawingNet
//
//  Created by Geonseok Lee on 2020/03/31.
//  Copyright © 2020 Geonseok Lee. All rights reserved.
//

import ARKit
import SwiftUI
import MultipeerConnectivity

class ARDrawView: ARSCNView {
	
	var multipeerSession: MultipeerSession?
	var hexColor: String = ""
	
	override init(frame: CGRect, options: [String : Any]? = nil) {
		super.init(frame: frame, options: options)
		let config = ARWorldTrackingConfiguration()
		session.run(config)
		delegate = self
		
		multipeerSession = MultipeerSession(receivedDataHandler: receivedData(_:from:))
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let point = touches.first?.location(in: self) else { return }
		addLineAnchor(point: point)
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let point = touches.first?.location(in: self) else { return }
		addLineAnchor(point: point)
	}
	
	func shareSession() {
		session.getCurrentWorldMap { worldMap, error in
			guard let map = worldMap
                else { print("Error: \(error!.localizedDescription)"); return }
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                else { fatalError("can't encode map") }
			self.multipeerSession?.sendToAllPeers(data, reliably: true)
		}
	}
	
	private func addLineAnchor(point: CGPoint) {
		let point3D = self.unprojectPoint(SCNVector3(point.x, point.y, 0.997))
		let node = SCNNode()
		node.position = point3D
		let anchor = ARAnchor(name: hexColor, transform: node.simdWorldTransform)
		session.add(anchor: anchor)
		sendToMultipeers(anchor)
	}
	
	private func sendToMultipeers(_ anchor: ARAnchor) {
		guard let data = try? NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true)
            else { fatalError("can't encode anchor") }
        self.multipeerSession?.sendToAllPeers(data, reliably: true)
	}
	
	private func createLine(name: String) -> SCNNode {
		let sphere = SCNSphere(radius: 0.005)
		sphere.firstMaterial?.diffuse.contents = UIColor.hexStringToUIColor(hex: name)
		let node = SCNNode(geometry: sphere)
		return node
	}
	
	private func receivedData(_ data: Data, from peer: MCPeerID) {
		if let worldMap = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data) {
			// Run the session with the received world map.
			let configuration = ARWorldTrackingConfiguration()
			configuration.initialWorldMap = worldMap
			session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
		}
		else if let anchor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARAnchor.self, from: data) {
			session.add(anchor: anchor)
		}
	}
}

extension ARDrawView: ARSCNViewDelegate {
	func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
		if let name = anchor.name, name.hasPrefix("#") {
			node.addChildNode(createLine(name: name))
		}
	}
}
