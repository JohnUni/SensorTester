/*
* NetworkServerTest.swift
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


class NetworkServer : NSObject
{
    // "127.0.0.1"  "10.0.1.1"  8090
    var strHost: String = "127.0.0.1"
    var nPort: Int32 = 8090
    
    var server: AsyncTcpServerSocket  = AsyncTcpServerSocket()

    var m_arrayHandlers: Array<INetworkDataHandler> = Array<INetworkDataHandler>()
    var m_arrayClients : Array<AsyncTcpClientSocket> = Array<AsyncTcpClientSocket>()
    
    override init()
    {
        //m_arrayHandlers = Array<INetworkDataHandler>()
        //m_arrayClients = Array<AsyncTcpClientSocket>()
        super.init()
    }
    
    internal func start( callbackHandler: INetworkDataHandler ) -> Bool
    {
        let bRet: Bool = false
        
        m_arrayHandlers.removeAll(keepCapacity: true)
        m_arrayHandlers.append(callbackHandler)
        
        let threadNetwork: NSThread = NSThread(target:self, selector:#selector(NetworkServer.threadNetworkFunc(_:)), object:nil)
        threadNetwork.start()
        
        return bRet
    }

    
    func threadNetworkFunc(sender : AnyObject)
    {
        // the unit is in second
        var nLastStartTime: NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        let MIN_WAIT_BEFORE_ERROR_RETRY: NSTimeInterval = 2.0
        let MIN_WAIT: NSTimeInterval = 0.20
        
        while( true )
        {
            let nCurrentTime: NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
            let nDiff: NSTimeInterval = nCurrentTime - nLastStartTime
            
            //print("nDiff:\(nDiff) \n")
            //nLastStartTime = nCurrentTime
            //usleep(1000)
            
            var bHaveTask: Bool = false
            
            switch( server.getSocketStatus() )
            {
            case .ASYNC_SOCKET_STATUS_UNKNOWN, .ASYNC_SOCKET_STATUS_INIT:
                if( nDiff > MIN_WAIT_BEFORE_ERROR_RETRY )
                {
                    print( "start async listen \(strHost):\(nPort) \n", terminator: "" )
                    server.startAsyncListen( strHost, port: nPort )
                    nLastStartTime = nCurrentTime
                }
            case .ASYNC_SOCKET_STATUS_LISTENING:
                if( nDiff > MIN_WAIT )
                {
                    if( server.isListened() )
                    {
                        print( " async is listened now. \n", terminator: "" )
                        // Okay
                    }
                    else
                    {
                        print( " async waiting for listened. \n", terminator: "" )
                    }
                    nLastStartTime = nCurrentTime
                }
                else
                {
                    // nothing only wait
                }
            case .ASYNC_SOCKET_STATUS_LISTENED:
                if( server.isAcceptable() )
                {
                    //print( " async try to accept \n" )
                    let clientSocket: AsyncTcpClientSocket? = server.acceptClient()
                    if( clientSocket != nil )
                    {
                        self.m_arrayClients.append( clientSocket! )
                        bHaveTask = true
                    }
                    else
                    {
                        print( " async try to accept error! \n", terminator: "" )
                    }
                }
            case .ASYNC_SOCKET_STATUS_ERROR:
                server.reset()
                nLastStartTime = nCurrentTime
            default:
                break
            }
            
            for client: AsyncTcpClientSocket in m_arrayClients
            {
                if( client.isReadable() )
                {
                    let nBufferSize: Int32 = 64*1024
                    let (bResult, dataBuffer): (Bool, NSData?) = client.recv( nBufferSize )
                    if( bResult && dataBuffer != nil )
                    {
                        bHaveTask = true
                        for dataHandler: INetworkDataHandler in m_arrayHandlers
                        {
                            let nProcess: Bool = dataHandler.receiveData( client, data: dataBuffer! )
                            if( nProcess )
                            {
                                // break
                            }
                        }
                    }
                    else
                    {
                        print( " nothing to read from client, might be closed by client \n", terminator: "" )
                    }
                }
            }
            
            for( var i: Int = m_arrayClients.count-1; i >= 0 ; i -= 1 )
            {
                let client: AsyncTcpClientSocket = m_arrayClients[i]
                let nStatus: enumAsyncSocketStatus = client.getSocketStatus()
                if( .ASYNC_SOCKET_STATUS_CONNECTED != nStatus )
                {
                    print( " client status is not connected, removed! \n", terminator: "" )
                    m_arrayClients.removeAtIndex( i )
                    bHaveTask = true
                }
            }
            
            if( !bHaveTask )
            {
                usleep( useconds_t(MIN_WAIT) )
            }
        }
    }
    
}
