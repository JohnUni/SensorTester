/*
* FantasticRawNetworkHandler.swift
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

public class FantasticRawNetworkHandler : BaseNetworkDataHandler
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
            //var nProcessingOffset: Int32 = 0
            
            // 68 58 68 59 10  D:D;
            // 68 58 83 59 10  D:S;
            // 68 58 82 59 10
            // 68 58 82 59 10 68 58 82 59 10
            
            var buffer:Array<UInt8> = Array<UInt8>(count:Int(nDataInBufferLength), repeatedValue:0x0)
            m_byteDataBuffer!.getBytes( &buffer, length: Int(nDataInBufferLength))
            
            //    for( var i: Int32 = 0; i<nDataInBufferLength; ++i )
            //    {
            //        let ch:  UInt8 = buffer[Int(i)]
            //        print( "\(ch) " )
            //    }
            //    print( "\n" )
            
            //nProcessingOffset = nDataInBufferLength - 1
            //for( var i: Int32 = nDataInBufferLength - 1; i>=0; i-- )
            //{
            //    let ch:  UInt8 = buffer[Int(i)]
            //    if( 0x0A == ch )
            //    {
            //        nProcessingOffset = i
            //        break
            //    }
            //}
            
            let strData: NSString? = NSString(data: m_byteDataBuffer!, encoding:NSUTF8StringEncoding )
            if( strData != nil )
            {
                let strValue: String = strData as! String
                let strSplit: String = "\n"
                let arrayStringData: Array<String> = strValue.componentsSeparatedByString( strSplit )
                let nCount: Int32 = Int32(arrayStringData.count)
                
                for( var i: Int32=0; i<nCount; i++ )
                {
                    let str: String = arrayStringData[Int(i)]
                    let nStrLen: Int = str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
                    // print( "\(i):\(str), len:\(str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))\n" )
                    if( nStrLen > 0 )
                    {
                        //0:D:S;, len:4
                        let charArray: Array<Character> = Array<Character>(str.characters)
                        if( ("D" == charArray[0]) && (":" == charArray[1]) )
                        {
                            processCommand( str )
                        }
                        else if( ("C" == charArray[0]) && (":" == charArray[1]) )
                        {
                            processColor( str )
                        }
                        else if( ("S" == charArray[0]) && (":" == charArray[1]) )
                        {
                            processSensor( str )
                        }
                        else if( ("N" == charArray[0]) && (":" == charArray[1]) )
                        {
                            processNotification( str )
                        }
                        else
                        {
                            print( "unknown command:\(charArray[0]),\(charArray[1]) \n", terminator: "" )
                        }
                    }
                    else
                    {
                        // Okay
                    }
                }
            }
            else
            {
                print("unknown message format, remove all buffer!\n", terminator: "")
                m_byteDataBuffer = nil
                bRet = false
            }
            
            if( m_byteDataBuffer != nil )
            {
                m_byteDataBuffer = nil
                bRet = true
            }
        }
        
        return bRet
    }
    
    private func processCommand( strLine: String ) -> Bool
    {
        var bRet: Bool = false
        
        // U D L R S E
        // up, down, left, right, stop, exit
        
        let charArray: Array<Character> = Array<Character>(strLine.characters)
        
        //let messageType: enumRemoteCommand = .MESSAGE_TYPE_REMOTE_COMMAND
        var subType: enumRemoteSubCommand = .MESSAGE_SUBTYPE_UNKNOWN
        
        var bErrorOccur: Bool = false
        
        let chDirection: Character = charArray[2]
        switch( chDirection )
        {
        case "U":
            subType = .MESSAGE_SUBTYPE_REMOTE_COMMAND_FORWARD
            break
        case "D":
            subType = .MESSAGE_SUBTYPE_REMOTE_COMMAND_BACKWARD
            break
        case "L":
            subType = .MESSAGE_SUBTYPE_REMOTE_COMMAND_TURN_LEFT
            break
        case "R":
            subType = .MESSAGE_SUBTYPE_REMOTE_COMMAND_TURN_RIGHT
            break
        case "S":
            subType = .MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP
            break
        case "E":
            subType = .MESSAGE_SUBTYPE_REMOTE_COMMAND_RESET
            break
        default:
            print( "unknown direction in command:\(charArray[0]),\(charArray[1]),\(charArray[2]) \n", terminator: "" )
            bErrorOccur = true
            break
        }
        
        if( bErrorOccur )
        {
            print("fantastic process error, remove !\n", terminator: "")
            // m_byteDataBuffer = nil
            bRet = false
        }
        else
        {
            let objMessage: IDataMessage = RemoteCommandMessage(subType: subType, isAck: false)
            // var objAckMessage: IDataMessage? =
            
            let bHandle: Bool = handleMessage( objMessage )
            if( !bHandle )
            {
                print("fantastic remote handle fail!\n", terminator: "")
            }
        }
        return bRet
    }
    
    private func processColor( strLine: String ) -> Bool
    {
        let bRet: Bool = false
        print( "color:\(strLine) \n", terminator: "" )
        return bRet
    }
    
    private func processSensor( strLine: String ) -> Bool
    {
        let bRet: Bool = false
        print( "sensor:\(strLine) \n", terminator: "" )
        return bRet
    }
    
    private func processNotification( strLine: String ) -> Bool
    {
        let bRet: Bool = false
        print( "notification:\(strLine) \n", terminator: "" )
        return bRet
    }

}
