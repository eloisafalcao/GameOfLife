//
//  GameViewController.swift
//  SceneKit Practice
//
//  Created by Eloisa Falcão on 31/10/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    
    let scene = SCNScene(named: "art.scnassets/scene.scn")
    var grid = GridViewFactory(rowSize: 5, numberOfElements: 25)
    var deadCells: [CellView] = []
    var aliveCells: [CellView] = []
    var timeInterval: TimeInterval = 0.0
    var currentTime: TimeInterval = 1.0
    var enabled: Bool = true
    var playButton: UIButton?
    var scnView: SCNView?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scnView = {
            guard let view = self.view as? SCNView else { fatalError()
            }
            
            view.delegate = self
            view.scene = scene
            view.loops = true
            view.allowsCameraControl = true
            
            return view
        }()
        
        let cells = grid.cells
        
        for cell in cells{
            scene?.rootNode.addChildNode(cell.cellNode)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView?.addGestureRecognizer(tapGesture)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene?.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 20)
        
        playButton = UIButton(frame: .zero)
        guard let playButton = playButton else { return }
        self.view.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        playButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        playButton.addTarget(self, action: #selector(playNextGeneration), for: .touchDown)
    }
    
    @objc func playNextGeneration()  {
        if scnView?.isPlaying ?? false{
            scnView?.isPlaying = false
            playButton?.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        } else {
            scnView?.isPlaying = true
            playButton?.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        }
    }
    
    
    func createnewGeneration(){
        let cells = grid.cells
        
        for cell in cells {
            let aliveNeighbors = grid.checkAliveNeighbors(xPosition: cell.x , yPosition: cell.y)
            
            if cell.isAlive == true {
                switch aliveNeighbors {
                case 0, 1:
                    deadCells.append(cell)
                case 2, 3:
                    aliveCells.append(cell)
                default:
                    deadCells.append(cell)
                }
            } else {
                switch aliveNeighbors {
                case 3:
                    aliveCells.append(cell)
                default:
                    deadCells.append(cell)
                }
            }
        }
    }
    
    func setNewGrid() {
        for aliveCell in aliveCells {
            aliveCell.chanceCellState(state: true)
        }
        
        for deadCell in deadCells {
            deadCell.chanceCellState(state: false)
        }
        
        aliveCells.removeAll(keepingCapacity: false)
        deadCells.removeAll(keepingCapacity: false)
    }
    
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let scnView = self.view as! SCNView
        
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            let result = hitResults[0]
            guard let cell = result.node as? CellNode else {
                return
            }
            
            if cell.cellView?.isAlive == true {
                cell.cellView?.chanceCellState(state: false)
            } else {
                cell.cellView?.chanceCellState(state: true)
            }
            
        }
        
        enabled = true
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        if timeInterval < 0.01 {
            timeInterval = time
        }
        
        var deltaTime = time - timeInterval
        
        if deltaTime > currentTime && scnView?.isPlaying == true {
            createnewGeneration()
            setNewGrid()
            
            timeInterval = time
        }
    }
}

