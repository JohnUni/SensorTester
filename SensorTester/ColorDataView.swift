/*
* ColorDataView.swift
* SensorTester
*
* Created by John Wong on 8/09/2015.
* Copyright (c) 2015-2015, John Wong <john dot innovation dot au at gmail dot com>
*
* All rights reserved.
*
* http://www.bitranslator.com
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*   * Redistributions of source code must retain the above copyright notice,
*     this list of conditions and the following disclaimer.
*   * Redistributions in binary form must reproduce the above copyright
*     notice, this list of conditions and the following disclaimer in the
*     documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
* ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
* LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
* SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
* INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
* CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
* ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
* POSSIBILITY OF SUCH DAMAGE.
*
* Licensed to the Apache Software Foundation (ASF) under one
* or more contributor license agreements.  See the NOTICE file
* distributed with this work for additional information
* regarding copyright ownership.  The ASF licenses this file
* to you under the Apache License, Version 2.0 (the
* "License"); you may not use this file except in compliance
* with the License.  You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied.  See the License for the
* specific language governing permissions and limitations
* under the License.
*/

import Foundation
import UIKit

public class ColorDataView : UIView
{
    private var m_dataController : ViewController?
    
    func setDataController( dataController : ViewController ) -> Void
    {
        m_dataController = dataController
    }
    
    private func redrawDataArea() -> Void
    {
        let frameSize: CGRect = self.frame
        
        frameSize.origin.x
        frameSize.origin.y
        frameSize.size.height
        frameSize.size.width
        
        let rawBuffer: DataBuffer<RawColor> = m_dataController!.getRawColorBuffer()
        
        let nColorCount: Int32 = rawBuffer.getBufferSize()
        
    }
    
    override public func drawRect(rect: CGRect)
    {
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        if( context != nil )
        {
            //CGContextClearRect( context, rect )
            
            let strokeWidth = 1.0
            CGContextSetLineWidth(context, CGFloat(strokeWidth))
            CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
            
            self.drawRectAround( context!, rect: rect )
            CGContextStrokePath(context)
            
            if( m_dataController != nil)
            {
                let rawBuffer: DataBuffer<RawColor> = m_dataController!.getRawColorBuffer()
                self.drawRawColorPoint( context!, rect: rect, rawBuffer: rawBuffer )
                CGContextStrokePath(context)
                
                let dashArray:[CGFloat] = [2,4]
                CGContextSetLineDash(context, 3, dashArray, 2)
                
                self.drawRectColumns( context!, rect: rect, rawBuffer: rawBuffer )
                self.drawRectRows( context!, rect: rect, rawBuffer: rawBuffer )
                CGContextStrokePath(context)
                
            }
        }
    }
    
    private func drawRectAround( context: CGContext, rect: CGRect ) -> Void
    {
        // Rectangle around the area
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        var points: Array<CGPoint> = Array<CGPoint>()
        points.append( CGPoint(x: 0, y: 0) )
        points.append( CGPoint(x: rect.width, y: 0) )
        points.append( CGPoint(x: rect.width, y: rect.height) )
        points.append( CGPoint(x: 0, y: rect.height) )
        points.append( CGPoint(x: 0, y: 0) )
        CGContextAddLines(context, points, points.count)
        
    }
    
    private func drawRectColumns( context: CGContext, rect: CGRect, rawBuffer: DataBuffer<RawColor> ) -> Void
    {
        let nBufferSize: Int32 = rawBuffer.getBufferSize()
        
        let nDrawColumes: Int32 = (nBufferSize >> 6)
        
        CGContextSetStrokeColorWithColor(context, UIColor.grayColor().CGColor)
        for( var i: Int32 = 1; i<nDrawColumes; i += 1 )
        {
            var points: Array<CGPoint> = Array<CGPoint>()
            let nPositionX: Double = Double(rect.width)*Double(i)/Double(nDrawColumes)
            points.append( CGPoint(x: CGFloat(nPositionX), y: CGFloat(0)) )
            points.append( CGPoint(x: CGFloat(nPositionX), y: CGFloat(rect.height)) )
            
            CGContextAddLines(context, points, points.count)
        }
    }
    
    private func drawRectRows( context: CGContext, rect: CGRect, rawBuffer: DataBuffer<RawColor> ) -> Void
    {
        let MAX_ROW: Int32 = 10
        
        CGContextSetStrokeColorWithColor(context, UIColor.grayColor().CGColor)
        for( var i: Int32 = 1; i<MAX_ROW; i += 1 )
        {
            var points: Array<CGPoint> = Array<CGPoint>()
            let nPositionY: Double = Double(rect.height)*Double(i)/Double(MAX_ROW)
            points.append( CGPoint(x: CGFloat(0), y: CGFloat(nPositionY)) )
            points.append( CGPoint(x: CGFloat(rect.width), y: CGFloat(nPositionY)) )
            
            CGContextAddLines(context, points, points.count)
        }
    }
    
    private func drawRawColorPoint( context: CGContext, rect: CGRect, rawBuffer: DataBuffer<RawColor> ) -> Void
    {
        let nBufferSize: Int32 = rawBuffer.getBufferSize()
        let nDotRectSize: CGFloat = 2
        
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        for( var i: Int32 = 1; i<nBufferSize; i += 1 )
        {
            let rawColor: RawColor? = rawBuffer.getData( i )
            if( rawColor != nil )
            {
                let nRawRed: Double = rawColor!.getRawRed()
                let nPositionX: Double = Double(rect.width) * Double(i) / Double(nBufferSize)
                let nPositionY: Double = Double(rect.height) - Double(nRawRed) * Double(rect.height)
                
                let origin: CGPoint = CGPoint(x: nPositionX, y: nPositionY)
                let size: CGSize = CGSize(width: nDotRectSize, height: nDotRectSize)
                let rectRed: CGRect = CGRect( origin: origin, size: size )
                CGContextAddRect( context, rectRed )
            }
        }
        CGContextStrokePath(context)
        
        CGContextSetStrokeColorWithColor(context, UIColor.greenColor().CGColor)
        //let nRawGreen: Double = rawColor.getRawGreen()
        for( var i: Int32 = 1; i<nBufferSize; i += 1 )
        {
            let rawColor: RawColor? = rawBuffer.getData( i )
            if( rawColor != nil )
            {
                let nRawGreen: Double = rawColor!.getRawGreen()
                let nPositionX: Double = Double(rect.width) * Double(i) / Double(nBufferSize)
                let nPositionY: Double = Double(rect.height) - Double(nRawGreen) * Double(rect.height)
                
                let origin: CGPoint = CGPoint(x: nPositionX, y: nPositionY)
                let size: CGSize = CGSize(width: nDotRectSize, height: nDotRectSize)
                let rectRed: CGRect = CGRect( origin: origin, size: size )
                CGContextAddRect( context, rectRed )
            }
        }
        CGContextStrokePath(context)
        
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        //let nRawBlue: Double = rawColor.getRawBlue()
        for( var i: Int32 = 1; i<nBufferSize; i += 1 )
        {
            let rawColor: RawColor? = rawBuffer.getData( i )
            if( rawColor != nil )
            {
                let nRawBlue: Double = rawColor!.getRawBlue()
                let nPositionX: Double = Double(rect.width) * Double(i) / Double(nBufferSize)
                let nPositionY: Double = Double(rect.height) - Double(nRawBlue) * Double(rect.height)
                
                let origin: CGPoint = CGPoint(x: nPositionX, y: nPositionY)
                let size: CGSize = CGSize(width: nDotRectSize, height: nDotRectSize)
                let rectRed: CGRect = CGRect( origin: origin, size: size )
                CGContextAddRect( context, rectRed )
            }
        }
        CGContextStrokePath(context)
        
    }
}
