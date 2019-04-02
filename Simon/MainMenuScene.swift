//
//  MainMenuScene.swift
//  Genius
//
//  Created by Matheus Aeroso on 10/05/15.
//  Copyright (c) 2015 Matheus Aeroso. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.runAction(SKAction .playSoundFileNamed("startgame.caf", waitForCompletion: false));
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self);
            let node = self.nodeAtPoint(location);
            
            if node is SKLabelNode && node.name == "startButton" {
                if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
                    scene.scaleMode = SKSceneScaleMode.AspectFill;
                    self.view!.presentScene(scene);
                }
            }
        }
    }
}
