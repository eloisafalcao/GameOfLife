//
//  Grid.swift
//  SceneKit Practice
//
//  Created by Eloisa Falcão on 01/11/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import Foundation

public class Grid {
    
    var cells: [Cell]
    var rowSize: Int
    var numberOfElements: Int
    var generation: Int = 1
    
    init(rowSize: Int, numberOfElements: Int) {
        cells = []
        self.rowSize = rowSize
        self.numberOfElements = numberOfElements
        
        // Percorrer o vetor de elementos e me retorna a posição do quadrado
        for i in 0..<numberOfElements{
            guard let x = findElementPositionBy(index: i)?.0 else {return}
           guard let y = findElementPositionBy(index: i)?.1 else {return}
            let cell = Cell(x: x, y: y)
            cells.append(cell)
        }
    }
    
    //Encontra a posição do quadrado com base no index
    func findElementPositionBy(index: Int) -> (Int, Int)? {
        if index <= numberOfElements {
            let y = index/rowSize
            let x = index % rowSize
            return (x, y)
        }
        return nil
    }
    
    //Retorna o index com base na posição
    func findElementIndexBy(x: Int, y: Int) -> Int? {
        let y = y
        let x = x
        
        if y >= 0 && x >= 0 {
            let index = (y * rowSize) + x
            if index <= numberOfElements, x < rowSize, y < numberOfElements/rowSize {
                return index
            }
        }
        return nil
    }
}
