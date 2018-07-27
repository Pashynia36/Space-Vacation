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

		scene?.size = UIScreen.main.bounds.size

		// background init

		let screenSize = UIScreen.main.bounds
		let spaceBackground = SKSpriteNode(imageNamed: "spaceBackground")
		spaceBackground.size = CGSize(width: screenSize.width, height: screenSize.height)
		addChild(spaceBackground)
		
		// Initalization of node

		spaceShuttle = SKSpriteNode(imageNamed: "shuttle")
		spaceShuttle.xScale = 1.0
		spaceShuttle.yScale = 1.0
		spaceShuttle.physicsBody = SKPhysicsBody(texture: spaceShuttle.texture!, size: spaceShuttle.size)
		spaceShuttle.physicsBody?.isDynamic = false
		addChild(spaceShuttle)

		let asteroid = SKAction.run {
			let asteroid = self.createAsteroid()
			self.addChild(asteroid)
		}
		let asteroidPerSecond = 3.0
		let asteroidDelay = SKAction.wait(forDuration: 1.0 / asteroidPerSecond, withRange: 0.5)
		
		let asteroidSequenceAction = SKAction.sequence([asteroid, asteroidDelay])
		
		let asteroidLoop = SKAction.repeatForever(asteroidSequenceAction)
		run(asteroidLoop)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {

			// Detecting point of touch
			let touchLocation = touch.location(in: self)

			let distance = distanceCalc(a: spaceShuttle.position, b: touchLocation)
			let speed: CGFloat = 500.0
			let time = timeToDestination(distance: distance, speed: speed)

			// Creating and adding action to shuttle
			let moveAction = SKAction.move(to: touchLocation, duration: time)
			spaceShuttle.run(moveAction)
		}
	}

	func createAsteroid() -> SKSpriteNode {

		let asteroid = SKSpriteNode(imageNamed: "asteroid")

		let randomScale = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: 6)) / 10
		
		asteroid.xScale = randomScale
		asteroid.yScale = randomScale
		
		asteroid.position.x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: 16))
		asteroid.position.y = frame.size.height + asteroid.size.height
		
		
		asteroid.physicsBody = SKPhysicsBody(texture: asteroid.texture!, size: asteroid.size)
		
		return asteroid
	}

	func distanceCalc(a: CGPoint, b: CGPoint) -> CGFloat {

		return sqrt((b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y))
	}

	func timeToDestination(distance: CGFloat, speed: CGFloat) -> TimeInterval {

		let time = distance / speed
		return TimeInterval(time)
	}
}
