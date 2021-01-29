//
//  SimonButton.swift
//  Simon
//
//  Created by Matheus Aeroso on 10/05/15.
//  Copyright (c) 2015 Matheus Aeroso. All rights reserved.
//

import SpriteKit

class SimonButton: SKSpriteNode {
    private lazy var pushSound: SKAction = SKAction .playSoundFileNamed(self.name! + ".caf", waitForCompletion: true)
    private lazy var idleTexture: SKTexture = SKTexture (imageNamed: self.name!)
    private lazy var pushTexture: SKTexture = SKTexture (imageNamed: self.name! + "_push")
    

    init(name: String) {
        let texture: SKTexture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .clear, size: CGSize(width: 200, height: 200))
        self.name = name
        self.anchorPoint = CGPoint(x: 1, y: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func push() {
        self.run(SKAction .animate(with: [self.pushTexture, self.idleTexture], timePerFrame: 0.5))
        self.run(self.pushSound)
    }
}
