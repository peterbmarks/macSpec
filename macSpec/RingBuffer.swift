//
//  RingBuffer.swift
//  macSpec
//
//  Created by Milko Daskalov on 05.08.16.
//  Copyright © 2016 Milko Daskalov. All rights reserved.
//

import Foundation

let kBufferSize = 1024 * 16

class RingBuffer: NSObject {
    var samples = [Float](repeating: 0, count: kBufferSize)
    var offset = 0
    
    func copyTo(count: Int) -> [Float] {
        var buffer = [Float]()
        for index in 0..<count {
            buffer.append(samples[(index + offset) % kBufferSize])
        }
        return buffer
    }

    @objc func pushSamples(_ source: UnsafeMutablePointer<Float32>, count: Int) {
        var bufferIndex = 0
        for index in 0..<count {
            bufferIndex = (index + offset) % kBufferSize
            samples[bufferIndex] = source[index]
        }
        offset = bufferIndex
    }
}

