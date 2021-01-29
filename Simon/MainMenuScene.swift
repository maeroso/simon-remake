//
//  MainMenuScene.swift
//  Genius
//
//  Created by Matheus Aeroso on 10/05/15.
//  Copyright (c) 2015 Matheus Aeroso. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        self.run(SKAction .playSoundFileNamed("startgame.caf", waitForCompletion: false));
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node is SKLabelNode && node.name == "startButton" {
                if let scene = GameScene.unarchiveFromFile(file: "GameScene") as? GameScene {
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                }
            }
        }
    }
}
