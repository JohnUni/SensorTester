/*
* BaseMessage.swift
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

public enum enumRemoteCommand : NSInteger
{
    case MESSAGE_TYPE_UNKNOWN		= 0x00
    case MESSAGE_TYPE_UNKNOWN_ACK	= 0x80
    
    case MESSAGE_TYPE_REMOTE_COMMAND		= 0x01
    case MESSAGE_TYPE_REMOTE_COMMAND_ACK	= 0x81
    
    case MESSAGE_TYPE_SENSOR_COLOR	= 0x10
    case MESSAGE_TYPE_SENSOR_GYRO	= 0x11
    case MESSAGE_TYPE_SENSOR_SONIC	= 0x12
    case MESSAGE_TYPE_SENSOR_TOUCH	= 0x13
    case MESSAGE_TYPE_SENSOR_RAWCOLOR	= 0x14
    
    case MESSAGE_TYPE_SENSOR_COLOR_ACK	= 0x90
    case MESSAGE_TYPE_SENSOR_GYRO_ACK	= 0x91
    case MESSAGE_TYPE_SENSOR_SONIC_ACK	= 0x92
    case MESSAGE_TYPE_SENSOR_TOUCH_ACK	= 0x93
    case MESSAGE_TYPE_SENSOR_RAWCOLOR_ACK	= 0x94
    
    case MESSAGE_TYPE_POSITION_UPDATE = 0x20
    case MESSAGE_TYPE_DIRECTION_UPDATE = 0x21
    
    case MESSAGE_TYPE_POSITION_UPDATE_ACK = 0xA0
    case MESSAGE_TYPE_DIRECTION_UPDATE_ACK = 0xA1
}

public enum enumRemoteSubCommand : NSInteger
{
    case MESSAGE_SUBTYPE_UNKNOWN = 0x00
    
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_RESET		= 0x01
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP		= 0x02
    //case MESSAGE_SUBTYPE_REMOTE_COMMAND_BRAKE = MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_TURN_LEFT	= 0x03
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_TURN_RIGHT	= 0x04
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_FORWARD		= 0x05
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_BACKWARD	= 0x06
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_SPEEDUP		= 0x07
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_SPEEDDOWN	= 0x08
    
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_TURN_LEFT_ANGLE		= 0x11
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_TURN_RIGHT_ANGLE	= 0x12
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_FORWARD_DISTANCE	= 0x13
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_BACKWARD_DISTANCE	= 0x14
    
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_SET_DESTINATE_POSITION	= 0x20
    
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_GET_STATUS              = 0x80
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_GET_CURRENT_POSITION	= 0x81
    case MESSAGE_SUBTYPE_REMOTE_COMMAND_GET_CURRENT_DIRECTION	= 0x82
}

public let MESSAGE_HEADER_LENGTH: Int32 = 4
public let MESSAGE_EXTEND_SIZE_MASK: UInt8 = 0x80

public class BaseMessage : IDataMessage
{
    var m_nMessageType: enumRemoteCommand = .MESSAGE_TYPE_UNKNOWN
    //var m_nMessageSubType: enumRemoteSubCommand = .MESSAGE_SUBTYPE_UNKNOWN
    var m_bIsAck: Bool = false
    
    var m_nMessageId: Int32 = -1
    
    var	m_dataBodyBuffer: NSData = NSData()
    var m_nBodyLength: Int32 = -1
    
    var m_bValid: Bool = false
    
    private func BaseMessage()
    {
    }
    
    public static func getInt32FromByteArray( data: NSData, offset: Int32 ) -> Int32
    {
        var nRet: Int32 = 0
        
        if( Int32(data.length) > (offset+4) )
        {
            var nValue: Int32 = 0
            data.getBytes(&nValue, range: NSMakeRange(Int(offset), 4))
            nRet = nValue
        }
        return nRet
    }
    
    public static func GetMessageType( nMessageType: Int32 ) -> enumRemoteCommand
    {
        var type: enumRemoteCommand = enumRemoteCommand.MESSAGE_TYPE_UNKNOWN
        if( Int32(enumRemoteCommand.MESSAGE_TYPE_REMOTE_COMMAND.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_REMOTE_COMMAND
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_REMOTE_COMMAND_ACK.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_REMOTE_COMMAND_ACK
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_COLOR.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_COLOR
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_GYRO.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_GYRO
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_SONIC.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_SONIC
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_TOUCH.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_TOUCH
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_RAWCOLOR.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_RAWCOLOR
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_COLOR_ACK.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_COLOR_ACK
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_GYRO_ACK.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_GYRO_ACK
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_SONIC_ACK.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_SONIC_ACK
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_TOUCH_ACK.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_TOUCH_ACK
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_SENSOR_RAWCOLOR_ACK.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_SENSOR_RAWCOLOR_ACK
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_POSITION_UPDATE.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_POSITION_UPDATE
        }
        else if( Int32(enumRemoteCommand.MESSAGE_TYPE_POSITION_UPDATE_ACK.rawValue) == nMessageType )
        {
            type = enumRemoteCommand.MESSAGE_TYPE_POSITION_UPDATE_ACK
        }
        return type
    }
    
    public func updateMessageId( newMessageId: Int32 ) -> Void
    {
        m_nMessageId = newMessageId
    }
    
    public func getMessageType() -> enumRemoteCommand
    {
        return m_nMessageType
    }
    
    //public func getMessageSubType() -> enumRemoteSubCommand
    //{
    //    return m_nMessageSubType
    //}
    
    public func getMessageId() -> Int32
    {
        return m_nMessageId
    }
    
    public func getMessageLength() -> Int32
    {
        return MESSAGE_HEADER_LENGTH + m_nBodyLength
    }
    
    public func getMessageBuffer() -> NSData?
    {
        if( m_bValid )
        {
            let nFullMessageLength: Int32 = MESSAGE_HEADER_LENGTH + m_nBodyLength
            
            let nHighId: Int32 = (( m_nMessageId >> 8) & 0x00FF )
            let nLowId: Int32 = m_nMessageId & 0x00FF
            
            var headerBuffer:Array<UInt8> = Array<UInt8>(count: Int(MESSAGE_HEADER_LENGTH), repeatedValue:0x0)
            headerBuffer[0] = UInt8(nFullMessageLength & 0xFF)
            headerBuffer[1] = UInt8(m_nMessageType.rawValue & 0xFF)
            headerBuffer[2] = UInt8(nLowId & 0xFF)
            headerBuffer[3] = UInt8(nHighId & 0xFF)
            
            let finalMessageBuffer: NSMutableData = NSMutableData()
            finalMessageBuffer.appendBytes(headerBuffer, length: Int(MESSAGE_HEADER_LENGTH))
            finalMessageBuffer.appendData(m_dataBodyBuffer)
            
            return finalMessageBuffer
        }
        else
        {
            return nil
        }
    }
    
    func updateMessageBody( bufferBody: NSData, bodyLength: Int32 ) -> Bool
    {
        var bRet: Bool = false
        
        if( bufferBody.length > 0 &&
            bodyLength > 0 &&
            bodyLength <= Int32(bufferBody.length) )
        {
            m_nBodyLength = bodyLength
            m_dataBodyBuffer = NSData(data: bufferBody)
            
            m_bValid = true
            bRet = true
        }
        return bRet
    }
    
    public func buildRemoteMessage( messageId: Int32, buffer: NSData, offset: Int32, dataSize: Int32 ) -> Bool
    {
        let bRet: Bool = false
        print( "buildRemoteMessage MUST BUILD IN OTHER CLASS! NOT in BaseMessage.\n", terminator: "" )
        return bRet
    }
    
    public func assembleRemoteMessage() -> Bool
    {
        let bRet: Bool = false
        print( "assembleRemoteMessage MUST BUILD IN OTHER CLASS! NOT in BaseMessage.\n", terminator: "" )
        return bRet
    }
    
}
