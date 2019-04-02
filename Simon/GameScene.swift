//
//  GameScene.swift
//  Genius
//
//  Created by Matheus Aeroso on 08/05/15.
//  Copyright (c) 2015 Matheus Aeroso. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private var buttonArray: [SimonButton]!;
    private var levelLabel: SKLabelNode!;
    private var playerTouchesLabel: SKLabelNode!;
    //private var player: Player;
    private var level: Int = 0;
    private var levelSequence: [Int] = [], playerSequence: [Int] = [];
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let blue = SimonButton(name: "blue");
        blue.position = CGPointMake(200, 0);
        let yellow = SimonButton(name: "yellow");
        yellow.position = CGPointMake(0, 0);
        let red = SimonButton(name: "red");
        red.position = CGPointMake(200, 200);
        let green = SimonButton(name: "green");
        green.position = CGPointMake(0, 200);
        
        self.buttonArray = [blue, yellow, red, green];
        
        for node in self.buttonArray {
            self.addChild(node);
        }
        
        self.levelLabel = self.childNodeWithName("levelLabel") as! SKLabelNode;
        self.playerTouchesLabel = self.childNodeWithName("playerTouchesLabel") as! SKLabelNode;
        
        
        self.nextLevel();
    }
    
    func nextLevel() {
        self.levelLabel.text = String(++self.level);
        self.appendToGameSequence();
    }
    
    func appendToGameSequence() {
        levelSequence.append(Int(arc4random_uniform(4)));
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("sequenceAnimation"), userInfo: nil, repeats: false);
    }
    
    func sequenceAnimation() {
        var actionsArray:[SKAction] = [];
        for indexOfButton in self.levelSequence {
            actionsArray.append(SKAction .runBlock({self.buttonArray[indexOfButton].push()}));
            actionsArray.append(SKAction .waitForDuration(0.5));
        }
        self.runAction(SKAction .sequence(actionsArray));
    }
    
    func clearTouches() {
        self.playerSequence.removeAll(keepCapacity: false);
        self.playerTouchesLabel.text = String(self.playerSequence.count);
    }
    
    func pushedButton(index: Int) {
        self.playerSequence.append(index);
        self.playerTouchesLabel.text = String(self.playerSequence.count);
    }
    
    func checkGame() {
        for var index = 0; index < self.playerSequence.count; index++ {
            if self.playerSequence[index] != self.levelSequence[index] {
                if let scene = GameOverScene.unarchiveFromFile("GameOverScene") as? GameOverScene {
                    scene.scaleMode = SKSceneScaleMode.AspectFill;
                    self.view!.presentScene(scene);
                }
            }
            
            if (self.playerSequence == self.levelSequence) {
                self.clearTouches();
                self.nextLevel();
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self);
            let button: SimonButton? = self.nodeAtPoint(location) as? SimonButton;
            
            if button != nil {
                if let index = find(self.buttonArray, button!) {
                    button?.push();
                    self.pushedButton(index);
                    self.checkGame();
                }
            }
        }
    }
    
}
