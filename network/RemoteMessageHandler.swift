/*
* RemoteMessageHandler.swift
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

public class RemoteMessageHandler : BaseMessageHandler
{
    override public func handle(message: IDataMessage ) -> Bool
    {
        let bRet: Bool = false
        
        let messageType: enumRemoteCommand = message.getMessageType()
        //let messageSubType: enumRemoteSubCommand = message.getMessageSubType()
        let nMessageId: Int32 = message.getMessageId()
        
        switch( messageType )
        {
        case .MESSAGE_TYPE_REMOTE_COMMAND:
            print("WHY COMMAND MESSAGE? \n", terminator: "")
            break
        case .MESSAGE_TYPE_REMOTE_COMMAND_ACK:
            print("command ack: id=\(nMessageId) \n", terminator: "")
            break
            
        case .MESSAGE_TYPE_SENSOR_COLOR:
            break
        case .MESSAGE_TYPE_SENSOR_GYRO:
            break
        case .MESSAGE_TYPE_SENSOR_SONIC:
            break
        case .MESSAGE_TYPE_SENSOR_TOUCH:
            break
        case .MESSAGE_TYPE_SENSOR_RAWCOLOR:
            break
            
        case .MESSAGE_TYPE_UNKNOWN,
             .MESSAGE_TYPE_UNKNOWN_ACK,
             .MESSAGE_TYPE_SENSOR_COLOR_ACK,
             .MESSAGE_TYPE_SENSOR_GYRO_ACK,
             .MESSAGE_TYPE_SENSOR_SONIC_ACK,
             .MESSAGE_TYPE_SENSOR_TOUCH_ACK,
             .MESSAGE_TYPE_SENSOR_RAWCOLOR_ACK:
            print("not processed message:\(messageType.rawValue) \n", terminator: "")
            let n: Int32 = -2
            break
            
        default:
            print("WHAT message? \(messageType.rawValue) \n", terminator: "")
            let n: Int32 = -1
            break
        }
        
        return bRet
    }
}
