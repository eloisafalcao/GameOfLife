//
//  GridViewFactory.swift
//  SceneKit Practice
//
//  Created by Eloisa Falcão on 01/11/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import Foundation
import SceneKit

//Factory: classe estática que cria objetos
class GridViewFactory {
    var grid: Grid
    var cells: [CellView] = []
    let colums: Int
    let rows: Int
    
    init(rowSize: Int, numberOfElements: Int) {
        
        self.grid = Grid(rowSize: rowSize, numberOfElements: numberOfElements)
        self.rows = numberOfElements/rowSize
        self.colums = rows
        setCells()
    }
    
    func setCells() {
        for x in 0..<colums {
            for y in 0..<rows {
                let cellNode = CellView(x: x, y: y, xPosition: x-(colums/2), yPosition: y-(rows/2))
                cells.append(cellNode)
            }
        }
        
    }
    
    func checkNeighborhood(x: Int, y: Int) -> [CellView]{
        var neighbors: [CellView] = []
        
        for xIndex in -1...1{
            for yIndex in -1...1{
                if !(xIndex == 0 && yIndex == 0 ){
                    if let isOnRange = grid.findElementIndexBy(x: xIndex+x, y: yIndex+y) {
                        let neighbor = cells[isOnRange]
                        neighbors.append(neighbor)
                    }
                }
            }
        }
        return neighbors
    }
    
    func checkAliveNeighbors(xPosition: Int, yPosition: Int) -> Int?{
        var aliveNeighbors: [CellView] = []
        let neighbors = checkNeighborhood(x: xPosition, y: yPosition)
        
        for neighbor in neighbors{
            if neighbor.isAlive == true{
                aliveNeighbors.append(neighbor)
            }
        }
        return aliveNeighbors.count
    }
    
}
