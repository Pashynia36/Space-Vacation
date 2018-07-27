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

		// background init

		let screenSize = UIScreen.main.bounds
		let spaceBackground = SKSpriteNode(imageNamed: "spaceBackground")
		spaceBackground.size = CGSize(width: screenSize.width * 2.5, height: screenSize.height * 2.5)
		addChild(spaceBackground)
		
		// Initalization of node

		spaceShuttle = SKSpriteNode(imageNamed: "shuttle")
		spaceShuttle.xScale = 2
		spaceShuttle.yScale = 2
		spaceShuttle.physicsBody = SKPhysicsBody(texture: spaceShuttle.texture!, size: spaceShuttle.size)
		spaceShuttle.physicsBody?.isDynamic = false
		addChild(spaceShuttle)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			// Detecting point of touch
			let touchLocation = touch.location(in: self)

			// Creating and adding action to shuttle
			let moveAction = SKAction.move(to: touchLocation, duration: 0.5)
			spaceShuttle.run(moveAction)
			
			let asteroid = SKAction.run {
				let asteroid = self.createAsteroid()
				self.addChild(asteroid)
			}
			let asteroidDelay = SKAction.wait(forDuration: 1.0, withRange: 0.5)

			let asteroidSequenceAction = SKAction.sequence([asteroid, asteroidDelay])

			let asteroidLoop = SKAction.repeatForever(asteroidSequenceAction)
			run(asteroidLoop)
		}
	}

	func createAsteroid() -> SKSpriteNode {
		let asteroid = SKSpriteNode(imageNamed: "asteroid")
		asteroid.position.x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: 6))
		asteroid.position.y = frame.size.height + asteroid.size.height
		
		
		asteroid.physicsBody = SKPhysicsBody(texture: asteroid.texture!, size: asteroid.size)
		
		return asteroid
	}
}
