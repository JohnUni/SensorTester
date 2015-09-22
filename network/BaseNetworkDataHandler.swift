/*
* BaseNetworkDataHandler.swift
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

public class BaseNetworkDataHandler: INetworkDataHandler
{
    private var m_messageHandler: IMessageHandler? = nil
    
    var m_byteDataBuffer: NSMutableData? = nil
    
    public init( messageHandler: IMessageHandler )
    {
        m_messageHandler = messageHandler
    }

    public func receiveData( socket: AsyncTcpSocket, data: NSData ) -> Bool
    {
        var bRet: Bool = false
        
        let nDataLength: Int32 = Int32(data.length)
        if (m_byteDataBuffer == nil && nDataLength > 0 )
        {
            m_byteDataBuffer = NSMutableData(data: data)
            
            print("copy data! len=\(nDataLength)", terminator: "")
            if( nDataLength >= 4 )
            {
                var byte0: UInt8 = 0
                var byte1: UInt8 = 0
                var byte2: UInt8 = 0
                var byte3: UInt8 = 0
                
                data.getBytes(&byte0, range: NSMakeRange(0, 1))
                data.getBytes(&byte1, range: NSMakeRange(1, 1))
                data.getBytes(&byte2, range: NSMakeRange(2, 1))
                data.getBytes(&byte3, range: NSMakeRange(3, 1))
                
                // String(format: "hex string: %X", 123456)
                print( String(format: " %02X", byte0), terminator: "")
                print( String(format: " %02X", byte1), terminator: "")
                print( String(format: " %02X", byte2), terminator: "")
                print( String(format: " %02X", byte3), terminator: "")
            }
            print("\n", terminator: "")
        } else {
            print("append data! len=\(nDataLength)\n", terminator: "")
            m_byteDataBuffer!.appendData(data)
        }
        
        bRet = processParseBuffer()
        
        return bRet
    }
    
    func processParseBuffer() -> Bool
    {
        let bRet: Bool = true
        print( "BaseNetworkDataHandler.processParseBuffer MUST be override by other class!\n", terminator: "" )
        return bRet
    }
    
    func handleMessage( message: IDataMessage ) -> Bool
    {
        var bRet: Bool = false
    
        if( m_messageHandler != nil )
        {
            bRet = m_messageHandler!.handle( message )
        }
    
        return bRet
    }

}
