//
//  SurvivorRule.swift
//  SceneKit Practice
//
//  Created by Eloisa Falcão on 02/11/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import Foundation
import UIKit

func survivorRule(grid: Grid) -> [Cell] {
    let cells: [Cell] = []
    let grid2 = grid
    var neighbors: [Cell] = []
    
    for cell in cells {
        neighbors = grid2.checkNeighborhood(x: cell.x, y: cell.y)
        
        if neighbors.count > 2 && neighbors.count < 4 {
            print("\(cell) survivor")
        }
    }
    return cells
}

//func generateNewGrid(cells: [CellView]) -> [CellView]{
//    let newCellsForGrid: [CellView] = []
//
//    for cell in cells {
//        if cell.isAlive == true {
//            cell.body.firstMaterial?.diffuse.contents = UIColor.magenta
//        } else {
//            cell.body.firstMaterial?.diffuse.contents = UIColor.gray
//        }
//    }
//    return newCellsForGrid
//}
