/*
* RemoteNetworkDataHandler.swift
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

public class RemoteNetworkDataHandler : BaseNetworkDataHandler
{
    public override init( messageHandler: IMessageHandler )
    {
        super.init(messageHandler: messageHandler)
    }
    
    override func processParseBuffer() -> Bool
    {
        var bRet: Bool = true
        
        if( m_byteDataBuffer != nil )
        {
            let nDataInBufferLength: Int32 = Int32(m_byteDataBuffer!.length)
            
            var nProcessingOffset: Int32 = 0
            
            if ( nDataInBufferLength < MESSAGE_HEADER_LENGTH )
            {
                print("less than header:", terminator: "")
                print(" nDataInBufferLength=\(nDataInBufferLength)", terminator: "")
                print("\n", terminator: "")
            }
            
            while (nDataInBufferLength >= (nProcessingOffset+MESSAGE_HEADER_LENGTH) )
            {
                var chSize: UInt8 = 0
                var chMessageType: UInt8 = 0
                var chMesageIdLow: UInt8 = 0
                var chMesageIdHigh: UInt8 = 0
                
                m_byteDataBuffer!.getBytes(&chSize,         range: NSMakeRange(Int(nProcessingOffset+0), 1))
                m_byteDataBuffer!.getBytes(&chMessageType,  range: NSMakeRange(Int(nProcessingOffset+1), 1))
                m_byteDataBuffer!.getBytes(&chMesageIdLow,  range: NSMakeRange(Int(nProcessingOffset+2), 1))
                m_byteDataBuffer!.getBytes(&chMesageIdHigh, range: NSMakeRange(Int(nProcessingOffset+3), 1))
                
                let nSize:          Int32 = Int32(chSize)
                let nMessageType:   Int32 = Int32(chMessageType)
                let nMesageIdLow:   Int32 = Int32(chMesageIdLow)
                let nMesageIdHigh:  Int32 = Int32(chMesageIdHigh)
                let nMessageId:     Int32 = nMesageIdLow | (nMesageIdHigh << 8)
                
                print("BaseRemoteCompletionHandler ReceiveData[\(m_byteDataBuffer!.length)]:", terminator: "")
                print(" offset=\(nProcessingOffset)", terminator: "")
                print(" size=\(nSize)", terminator: "")
                print(" type=\(nMessageType)", terminator: "")
                print(" MessageId=\(nMessageId)", terminator: "")
                print("\n", terminator: "")
                
                //print(" chSize:\(chSize)")
                //print(" chMessageType:\(chMessageType)")
                //print(" chMesageIdLow:\(chMesageIdLow)")
                //print(" chMesageIdHigh:\(chMesageIdHigh)")
                //print("\n")
                
                let messageType: enumRemoteCommand = BaseMessage.GetMessageType( nMessageType )
                //var subType: enumRemoteSubCommand = .MESSAGE_SUBTYPE_UNKNOWN
                
                if( .MESSAGE_TYPE_UNKNOWN == messageType )
                {
                    print("NOT VALID message type! clear buffer. type:\(nMessageType)\n", terminator: "")
                    m_byteDataBuffer = nil
                    bRet = false
                    break
                }
                else if( 0 == (Int32(MESSAGE_EXTEND_SIZE_MASK) & nSize) )
                {
                    if( nDataInBufferLength >= ( nProcessingOffset + nSize ) )
                    {
                        var bErrorOccur: Bool = false
                        
                        var objMessage: IDataMessage? = nil
                        
                        switch( messageType )
                        {
                        case .MESSAGE_TYPE_REMOTE_COMMAND:
                            objMessage = RemoteCommandMessage( isAck: false )
                            break
                        case .MESSAGE_TYPE_REMOTE_COMMAND_ACK:
                            objMessage = RemoteCommandMessage( isAck: true )
                            break
                            
                        case .MESSAGE_TYPE_SENSOR_COLOR:
                            objMessage = SensorColorNotificationMessage(isAck: false)
                            break
                        case .MESSAGE_TYPE_SENSOR_GYRO, .MESSAGE_TYPE_SENSOR_SONIC, .MESSAGE_TYPE_SENSOR_TOUCH:
                            objMessage = SensorNotificationMessage( sensorType: messageType, isAck: false )
                            break
                        case .MESSAGE_TYPE_SENSOR_RAWCOLOR:
                            objMessage = SensorRawColorNotificationMessage( isAck: false )
                            break
                        case .MESSAGE_TYPE_SENSOR_COLOR_ACK:
                            objMessage = SensorColorNotificationMessage(isAck: true)
                            break
                        case .MESSAGE_TYPE_SENSOR_RAWCOLOR_ACK:
                            objMessage = SensorRawColorNotificationMessage( isAck: true )
                        case .MESSAGE_TYPE_SENSOR_GYRO_ACK,.MESSAGE_TYPE_SENSOR_SONIC_ACK,.MESSAGE_TYPE_SENSOR_TOUCH_ACK:
                            objMessage = SensorNotificationMessage( sensorType: messageType, isAck: false )
                            break
                            
                        case .MESSAGE_TYPE_UNKNOWN, .MESSAGE_TYPE_UNKNOWN_ACK:
                            print("process unknown message type2!\n", terminator: "")
                            bErrorOccur = true
                            break
                            
                        default:
                            print("process unknown message type! \(messageType.rawValue)\n", terminator: "")
                            bErrorOccur = true
                            break
                        }
                        
                        if( objMessage != nil && !bErrorOccur )
                        {
                            let nBodyOffset: Int32 = nProcessingOffset + MESSAGE_HEADER_LENGTH
                            let nBodyLength: Int32 = nSize - MESSAGE_HEADER_LENGTH
                            let bBuild: Bool = objMessage!.buildRemoteMessage(nMessageId, buffer: m_byteDataBuffer!, offset: nBodyOffset, dataSize: nBodyLength )
                            if( bBuild )
                            {
                                // var objAckMessage: IDataMessage? =
                                
                                let bHandle: Bool = handleMessage( objMessage! )
                                if( !bHandle )
                                {
                                    print("remote handle fail!\n", terminator: "")
                                }
                            }
                            else
                            {
                                bErrorOccur = true
                                print("build message fail!\n", terminator: "")
                            }
                        }
                        
                        if( bErrorOccur )
                        {
                            print("process error, remove all buffer!\n", terminator: "")
                            m_byteDataBuffer = nil
                            bRet = false
                            break
                        }
                        else
                        {
                            nProcessingOffset += nSize
                        }
                    }
                    else
                    {
                        print("no enough data:", terminator: "")
                        print(" nSize=\(nSize)", terminator: "")
                        print(" nDataInBufferLength=\(nDataInBufferLength)", terminator: "")
                        print(" nProcessingOffset=\(nProcessingOffset)", terminator: "")
                        print("\n", terminator: "")
                    }
                }
                else
                {
                    print("unknown message, remove all buffer!\n", terminator: "")
                    m_byteDataBuffer = nil
                    bRet = false
                    break
                }
            }
            
            
            if( m_byteDataBuffer != nil )
            {
                let nFinalDataLength: Int32 = Int32(m_byteDataBuffer!.length)
                if( nFinalDataLength > 0 )
                {
                    if( nFinalDataLength == nDataInBufferLength )
                    {
                        if( nFinalDataLength == nProcessingOffset )
                        {
                            m_byteDataBuffer = nil
                        }
                        else if( nFinalDataLength > nProcessingOffset )
                        {
                            let nRemainLength: Int32 = nFinalDataLength - nProcessingOffset
                            var remainBuffer:Array<UInt8> = Array<UInt8>(count:Int(nRemainLength), repeatedValue:0x0)
                            
                            let remainRange: NSRange = NSMakeRange(Int(nProcessingOffset), Int(nRemainLength))
                            m_byteDataBuffer!.getBytes( &remainBuffer, range: remainRange )
                            let newData: NSMutableData = NSMutableData(bytes: remainBuffer, length: Int(nRemainLength))

                            m_byteDataBuffer = nil
                            m_byteDataBuffer = newData
                        }
                    }
                    else
                    {
                        print("WHY CHANGED??\n", terminator: "")
                    }
                }
            }
            
        }
        
        return bRet
    }
}
