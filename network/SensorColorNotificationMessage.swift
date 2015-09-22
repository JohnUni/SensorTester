/*
* SensorColorNotificationMessage.swift
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

let RAWCOLOR_NOTIFICATION_DATA_LENGTH: Int32 = 24

public class SensorColorNotificationMessage : BaseMessage
{
    init( isAck: Bool )
    {
        super.init()
        if( !isAck )
        {
            self.m_nMessageType = .MESSAGE_TYPE_SENSOR_COLOR
        }
        else
        {
            self.m_nMessageType = .MESSAGE_TYPE_SENSOR_COLOR_ACK
        }
        m_bIsAck = isAck
    }
}

public class SensorRawColorNotificationMessage : BaseMessage
{
    //protected boolean m_bIsAck = false
    
    var m_nRawValueR: Int32 = 0     // 4 bytes
    var m_nRawValueG: Int32 = 0     // 4 bytes
    var m_nRawValueB: Int32 = 0     // 4 bytes
    
    var m_nBeginTime: Int32 = 0     // 4 bytes
    var m_nEndTime: Int32 = 0       // 4 bytes
    
    var m_nTag: Int32 = 0           // 4 bytes
    
    private let m_nMultiplyFactor: Double = 10000

    //private var m_bIsAck: Bool = false
    init( isAck: Bool )
    {
        super.init()
        if( !isAck )
        {
            self.m_nMessageType = .MESSAGE_TYPE_SENSOR_RAWCOLOR
        }
        else
        {
            self.m_nMessageType = .MESSAGE_TYPE_SENSOR_RAWCOLOR_ACK
        }
        m_bIsAck = isAck
    }
    
    public func getRawR() -> Double { return Double(m_nRawValueR) / m_nMultiplyFactor }
    public func getRawG() -> Double { return Double(m_nRawValueG) / m_nMultiplyFactor }
    public func getRawB() -> Double { return Double(m_nRawValueB) / m_nMultiplyFactor }
    
    public func getRawIntR() -> Int32 { return m_nRawValueR }
    public func getRawIntG() -> Int32 { return m_nRawValueG }
    public func getRawIntB() -> Int32 { return m_nRawValueB }
    
    public func getSamplingTime() -> Int32 { return m_nEndTime }
    
    
    public override func buildRemoteMessage( messageId: Int32, buffer: NSData, offset: Int32, dataSize: Int32 ) -> Bool
    {
        var bRet: Bool = false
        
        m_nMessageId = messageId
        
        m_nRawValueR = BaseMessage.getInt32FromByteArray(buffer, offset: offset+4*0)
        m_nRawValueG = BaseMessage.getInt32FromByteArray(buffer, offset: offset+4*1)
        m_nRawValueB = BaseMessage.getInt32FromByteArray(buffer, offset: offset+4*2)
        
        m_nBeginTime = BaseMessage.getInt32FromByteArray(buffer, offset: offset+4*3)
        m_nEndTime = BaseMessage.getInt32FromByteArray(buffer, offset: offset+4*4)
        
        m_nTag = BaseMessage.getInt32FromByteArray(buffer, offset: offset+4*5)
        
        bRet = self.assembleRemoteMessage()
        return bRet
    }
    
    public override func assembleRemoteMessage() -> Bool
    {
        var bRet: Bool = false
        
        let remoteData: NSMutableData = NSMutableData()
        
        //    BaseMessage.writeIntToByteArray(m_nRawValueR, bufferBody, 4*0)
        //    BaseMessage.writeIntToByteArray(m_nRawValueG, bufferBody, 4*1)
        //    BaseMessage.writeIntToByteArray(m_nRawValueB, bufferBody, 4*2)
        //    BaseMessage.writeIntToByteArray((int) m_nBeginTime, bufferBody, 4*3)
        //    BaseMessage.writeIntToByteArray((int) m_nEndTime, bufferBody, 4*4)
        //    BaseMessage.writeIntToByteArray(m_nTag, bufferBody, 4*5)
        remoteData.appendBytes(&m_nRawValueR, length: 4)
        remoteData.appendBytes(&m_nRawValueG, length: 4)
        remoteData.appendBytes(&m_nRawValueB, length: 4)
        remoteData.appendBytes(&m_nBeginTime, length: 4)
        remoteData.appendBytes(&m_nEndTime, length: 4)
        remoteData.appendBytes(&m_nTag, length: 4)
        
        bRet = super.updateMessageBody( remoteData, bodyLength: Int32(remoteData.length) )
        
        return bRet
    }
}
