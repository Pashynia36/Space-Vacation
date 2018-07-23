//
//  GameScene.swift
//  Space Vacation
//
//  Created by Pavlo Novak on 7/23/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene {

	// Object of node
	private var spaceShuttle: SKSpriteNode!

	override func didMove(to view: SKView) {

		// Initalization of node
		spaceShuttle = SKSpriteNode(imageNamed: "shuttle")
		addChild(spaceShuttle)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			// Detecting point of touch
			let touchLocation = touch.location(in: self)

			// Creating and adding action to shuttle
			let moveAction = SKAction.move(to: touchLocation, duration: 0.5)
			spaceShuttle.run(moveAction)
		}
	}
}
