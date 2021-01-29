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
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        let blue = SimonButton(name: "blue");
        blue.position = CGPoint(x: 200, y: 0);
        let yellow = SimonButton(name: "yellow");
        yellow.position = CGPoint(x: 0, y: 0);
        let red = SimonButton(name: "red");
        red.position = CGPoint(x: 200, y: 200);
        let green = SimonButton(name: "green");
        green.position = CGPoint(x: 0, y: 200);
        
        self.buttonArray = [blue, yellow, red, green];
        
        for node in self.buttonArray {
            self.addChild(node);
        }
        
        self.levelLabel = self.childNode(withName: "levelLabel") as? SKLabelNode;
        self.playerTouchesLabel = self.childNode(withName: "playerTouchesLabel") as? SKLabelNode;
        
        
        self.nextLevel();
    }
    
    func nextLevel() {
        self.level += 1
        self.levelLabel.text = String(self.level);
        self.appendToGameSequence();
    }
    
    func appendToGameSequence() {
        levelSequence.append(Int(arc4random_uniform(4)));
        _ = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: Selector(("sequenceAnimation")), userInfo: nil, repeats: false);
    }
    
    func sequenceAnimation() {
        var actionsArray:[SKAction] = [];
        for indexOfButton in self.levelSequence {
            actionsArray.append(SKAction .run({self.buttonArray[indexOfButton].push()}));
            actionsArray.append(SKAction .wait(forDuration: 0.5));
        }
        self.run(SKAction .sequence(actionsArray));
    }
    
    func clearTouches() {
        self.playerSequence.removeAll(keepingCapacity: false);
        self.playerTouchesLabel.text = String(self.playerSequence.count);
    }
    
    func pushedButton(index: Int) {
        self.playerSequence.append(index);
        self.playerTouchesLabel.text = String(self.playerSequence.count);
    }
    
    func checkGame() {
        for i in 0..<self.playerSequence.count {
            if self.playerSequence[i] != self.levelSequence[i] {
                if let scene = GameOverScene.unarchiveFromFile(file: "GameOverScene") as? GameOverScene {
                    scene.scaleMode = SKSceneScaleMode.aspectFill;
                    self.view!.presentScene(scene);
                }
            }
            
            if (self.playerSequence == self.levelSequence) {
                self.clearTouches();
                self.nextLevel();
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.location(in: self);
            let button: SimonButton? = self.atPoint(location) as? SimonButton;
            
            if button != nil {
                if let index = self.buttonArray.firstIndex(of: button!) {
                    button?.push();
                    self.pushedButton(index: index);
                    self.checkGame();
                }
            }
        }
    }
    
}
