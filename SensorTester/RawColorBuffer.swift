/*
* RawColorBuffer.swift
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


public class DataBuffer<T> : NSObject
{
    private var m_nBufferSize: Int32 = 512
    private var m_arrayRawBuffer: Array<T> = Array<T>()
    
    private var m_nCurrentPosition: Int32 = 0
    
    public func getBufferSize() -> Int32
    {
        return m_nBufferSize
    }
    
    public func getData( nIndex: Int32 ) -> T?
    {
        if( (nIndex >= 0) && (nIndex < m_nBufferSize) && (Int32(m_arrayRawBuffer.count) > nIndex) )
        {
            return m_arrayRawBuffer[Int(nIndex)]
        }
        else
        {
            return nil
        }
    }

    public func addData( time: Int32, data: T ) -> Bool
    {
        var bRet: Bool = false
        
        if( Int32(m_arrayRawBuffer.count) < m_nBufferSize )
        {
            m_arrayRawBuffer.append( data )
            m_nCurrentPosition++
        }
        else if(Int32(m_arrayRawBuffer.count) == m_nBufferSize)
        {
            if( m_nCurrentPosition >= m_nBufferSize )
            {
                m_nCurrentPosition = 0
            }
            
            m_arrayRawBuffer[Int(m_nCurrentPosition)] = data
            m_nCurrentPosition++
        }
        else
        {
            // ERROR!!
        }
        
        bRet = true
        return bRet
    }
}

public class RawColor : NSObject
{
    private var m_rawR: Double = 0
    private var m_rawG: Double = 0
    private var m_rawB: Double = 0
    
    override init()
    {
        super.init()
        
        m_rawR = 0
        m_rawG = 0
        m_rawB = 0
    }
    
    init( rawR: Double, rawG: Double, rawB: Double )
    {
        super.init()
        
        m_rawR = rawR
        m_rawG = rawG
        m_rawB = rawB
    }
    
    public func getRawRed()   -> Double { return m_rawR }
    public func getRawGreen() -> Double { return m_rawG }
    public func getRawBlue()  -> Double { return m_rawB }
    
}

public class SpeedItem : NSObject
{
    private var m_nSpeed: Double = 0
    
    override init()
    {
        super.init()
        
        m_nSpeed = 0
    }
    
    init( nSpeed: Double )
    {
        super.init()
        m_nSpeed = nSpeed
    }
    
    public func getSpeed() -> Double { return m_nSpeed }
}

public class DirectionItem : NSObject
{
    private var m_nDirection: Double = 0
    
    override init()
    {
        super.init()
        
        m_nDirection = 0
    }
    
    init( nDirection: Double )
    {
        super.init()
        m_nDirection = nDirection
    }
    
    public func getDirection() -> Double { return m_nDirection }
}
