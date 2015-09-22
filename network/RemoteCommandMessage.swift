/*
* RemoteCommandMessage.swift
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

public class RemoteCommandMessage : BaseMessage
{
    private let REMOTE_COMMAND_DATA_LENGTH: Int32 = 8
    
    //private var m_bIsAck: Bool = false
    
    private var m_nMessageSubType: enumRemoteSubCommand = .MESSAGE_SUBTYPE_UNKNOWN  // 1 byte  ===> to 1st byte of m_nTag

    private var m_nData: Int32 = 0			// 4 bytes
    private var m_nTag: Int32 = 0			// 4 bytes
    
    init( isAck: Bool )
    {
        super.init()
        if( !isAck )
        {
            self.m_nMessageType = .MESSAGE_TYPE_REMOTE_COMMAND
        }
        else
        {
            self.m_nMessageType = .MESSAGE_TYPE_REMOTE_COMMAND_ACK
        }
        m_bIsAck = isAck
    }
    
    init( subType: enumRemoteSubCommand, isAck: Bool )
    {
        super.init()
        if( !isAck )
        {
            self.m_nMessageType = .MESSAGE_TYPE_REMOTE_COMMAND
        }
        else
        {
            self.m_nMessageType = .MESSAGE_TYPE_REMOTE_COMMAND_ACK
        }
        m_bIsAck = isAck
        
        m_nMessageSubType = subType
        self.assembleRemoteMessage()
    }
    
    init( subType: enumRemoteSubCommand, data: Int32, tag: Int32, isAck: Bool )
    {
        super.init()
        if( !isAck )
        {
            self.m_nMessageType = .MESSAGE_TYPE_REMOTE_COMMAND
        }
        else
        {
            self.m_nMessageType = .MESSAGE_TYPE_REMOTE_COMMAND_ACK
        }
        m_bIsAck = isAck
        
        m_nData = data
        m_nMessageSubType = subType
        m_nTag = tag
        self.assembleRemoteMessage()
    }
    
    public func getMessageSubType() -> enumRemoteSubCommand
    {
        return m_nMessageSubType
    }
    
    public override func buildRemoteMessage( messageId: Int32, buffer: NSData, offset: Int32, dataSize: Int32 ) -> Bool
    {
        var bRet: Bool = false
        
        // var type: enumRemoteCommand? = .MESSAGE_TYPE_UNKNOWN
        // var subType: enumRemoteSubCommand = .MESSAGE_SUBTYPE_UNKNOWN
        
        // type = messageType //enumRemoteCommand(rawValue: NSInteger(messageType))
        m_nMessageId = messageId
        
        var nDataLL: UInt8 = 0//buffer[offset]
        var nDataL: UInt8 = 0//buffer[offset+1]
        var nDataH: UInt8 = 0//buffer[offset+2]
        var nDataHH: UInt8 = 0//buffer[offset+3]
        
        var nTagLL: UInt8 = 0//buffer[offset+4]
        var nTagL: UInt8 = 0//buffer[offset+5]
        var nTagH: UInt8 = 0//buffer[offset+6]
        var nTagHH: UInt8 = 0//buffer[offset+7]
        
        //var length: Int32 = 0
        buffer.getBytes(&nDataLL, range: NSMakeRange(Int(offset+0), 1))
        buffer.getBytes(&nDataL, range: NSMakeRange(Int(offset+1), 1))
        buffer.getBytes(&nDataH, range: NSMakeRange(Int(offset+2), 1))
        buffer.getBytes(&nDataHH, range: NSMakeRange(Int(offset+3), 1))
        
        buffer.getBytes(&nTagLL, range: NSMakeRange(Int(offset+4), 1))
        buffer.getBytes(&nTagL, range: NSMakeRange(Int(offset+5), 1))
        buffer.getBytes(&nTagH, range: NSMakeRange(Int(offset+6), 1))
        buffer.getBytes(&nTagHH, range: NSMakeRange(Int(offset+7), 1))
        
        m_nData = ( Int32(nDataHH) << 24 ) | ( Int32(nDataH) << 16 ) | ( Int32(nDataL) << 8 ) | Int32(nDataLL)
        //m_nTag = ( nTagHH << 24 ) | ( nTagH << 16 ) | ( nTagL << 8 ) | nTagLL
        m_nTag = ( Int32(nTagH) << 16 ) | ( Int32(nTagL) << 8 ) | Int32(nTagLL)
        
        let subType: enumRemoteSubCommand? = enumRemoteSubCommand(rawValue: NSInteger(nTagHH))
        if( subType != nil )
        {
            m_nMessageSubType = subType!
            bRet = assembleRemoteMessage()
        }
        
        return bRet
    }
    
    public override func assembleRemoteMessage() -> Bool
    {
        var bRet: Bool = false
        
        var bodyBuffer:Array<UInt8> = Array<UInt8>(count: Int(REMOTE_COMMAND_DATA_LENGTH), repeatedValue:0x0)
        
        bodyBuffer[0] = UInt8(m_nData & 0xFF )
        bodyBuffer[1] = UInt8((m_nData >> 8) & 0xFF )
        bodyBuffer[2] = UInt8((m_nData >> 16) & 0xFF )
        bodyBuffer[3] = UInt8((m_nData >> 24) & 0xFF )
        
        bodyBuffer[4] = UInt8(m_nTag & 0xFF )
        bodyBuffer[5] = UInt8((m_nTag >> 8) & 0xFF )
        bodyBuffer[6] = UInt8((m_nTag >> 16) & 0xFF )
        //bufferBody[7] = UInt8((m_nTag >> 24) & 0xFF )
        
        bodyBuffer[7] = UInt8(m_nMessageSubType.rawValue & 0xFF )
        
        let dataBuffer: NSData = NSData(bytes: bodyBuffer, length: Int(REMOTE_COMMAND_DATA_LENGTH))
        
        bRet = super.updateMessageBody(dataBuffer, bodyLength: REMOTE_COMMAND_DATA_LENGTH)
        
        return bRet
    }
    
}
