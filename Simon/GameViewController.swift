//
//  GameViewController.swift
//  Genius
//
//  Created by Matheus Aeroso on 08/05/15.
//  Copyright (c) 2015 Matheus Aeroso. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if Bundle.main.path(forResource: file, ofType: "sks") != nil {
            do {
                let sceneData = try Data(contentsOf: URL(string: file)!, options: .mappedIfSafe)
                let archiver = try NSKeyedUnarchiver(forReadingFrom: sceneData)
                archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
                let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! SKScene
                archiver.finishDecoding()
                return scene
            } catch {
                print(error)
                return nil
            }
            
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = MainMenuScene.unarchiveFromFile(file: "MainMenuScene.sks") as? MainMenuScene {
            // Configure the view.
            let skView = self.view as! SKView
            //skView.showsFPS = true
            //skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
