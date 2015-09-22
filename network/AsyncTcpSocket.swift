/*
* TcpSocket.swift
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

// server socket
@asmname("tcpsocket_listen") func c_tcpsocket_listen(serveraddress: UnsafePointer<UInt8>, port: Int32) -> Int32
@asmname("tcpsocket_accept") func c_tcpsocket_accept(serversocketfd: Int32, remoteip: UnsafePointer<UInt8>, remoteport: UnsafePointer<Int32>) -> Int32
// server check acceptable
@asmname("is_listened") func c_is_listened(socketfd: Int32) -> Int32
@asmname("is_acceptable") func c_is_acceptable(socketfd: Int32) -> Int32

// client socket
@asmname("tcpsocket_connect") func c_tcpsocket_connect(host: UnsafePointer<UInt8>, port: Int32) -> Int32
@asmname("tcpsocket_send") func c_tcpsocket_send(socketfd: Int32, buffer: UnsafePointer<UInt8>, datalen: Int32) -> Int32
@asmname("tcpsocket_recv") func c_tcpsocket_recv(socketfd: Int32, buffer: UnsafePointer<UInt8>, buffersize: Int32, recvdatalen: UnsafePointer<Int32>) -> Int32
// client check connected, readable and writable
@asmname("is_connected") func c_is_connected(socketfd: Int32) -> Int32
@asmname("is_readable") func c_is_readable(socketfd: Int32) -> Int32
@asmname("is_writable") func c_is_writable(socketfd: Int32) -> Int32

// close socket
@asmname("tcpsocket_close") func c_tcpsocket_close(socketfd: Int32) -> Int32

public enum enumAsyncSocketStatus: Int32
{
    // for initial
    case ASYNC_SOCKET_STATUS_UNKNOWN = 0
    case ASYNC_SOCKET_STATUS_INIT = 1
    // for server socket
    case ASYNC_SOCKET_STATUS_LISTENING = 2
    case ASYNC_SOCKET_STATUS_LISTENED = 3
    // for client socket
    case ASYNC_SOCKET_STATUS_CONNECTING = 4
    case ASYNC_SOCKET_STATUS_CONNECTED = 5
    // for exception
    case ASYNC_SOCKET_STATUS_ERROR = 6
}

//public enum enumAsyncServerSocketStatus: Int32
//{
//    case ASYNC_SERVER_SOCKET_STATUS_UNKNOWN = 0
//    case ASYNC_SERVER_SOCKET_STATUS_INIT = 1
//    case ASYNC_SERVER_SOCKET_STATUS_LISTENING = 2
//    case ASYNC_SERVER_SOCKET_STATUS_ERROR = 4
//}
//
//public enum enumAsyncClientSocketStatus: Int32
//{
//    case ASYNC_CLIENT_SOCKET_STATUS_UNKNOWN = 0
//    case ASYNC_CLIENT_SOCKET_STATUS_INIT = 1
//    case ASYNC_CLIENT_SOCKET_STATUS_CONNECTING = 2
//    case ASYNC_CLIENT_SOCKET_STATUS_CONNECTED = 3
//    case ASYNC_CLIENT_SOCKET_STATUS_ERROR = 4
//}

public class AsyncTcpSocket : NSObject
{
    var m_fd: Int32 = 0
    var m_bAutoCloseSocketWhenErrorOccurs: Bool = true
    
    var m_nMessageQueueId: Int32 = 1
}

public class AsyncTcpServerSocket : AsyncTcpSocket
{
    private var m_nServerSocketStatus: enumAsyncSocketStatus = .ASYNC_SOCKET_STATUS_UNKNOWN
    
    public func getSocketStatus() -> enumAsyncSocketStatus
    {
        return m_nServerSocketStatus
    }
    
    public func reset() -> Bool
    {
        var bRet: Bool = false
        
        if( m_fd != 0 )
        {
            c_tcpsocket_close( m_fd )
            m_fd = 0
        }
        
        m_nServerSocketStatus = .ASYNC_SOCKET_STATUS_UNKNOWN
        bRet = true
        return bRet
    }
    
    public func startAsyncListen(host: String,  port: Int32) -> Bool
    {
        var bRet: Bool = false
        
        if( .ASYNC_SOCKET_STATUS_ERROR == m_nServerSocketStatus )
        {
            self.reset()
        }
        
        if( .ASYNC_SOCKET_STATUS_UNKNOWN == m_nServerSocketStatus )
        {
            m_nServerSocketStatus = .ASYNC_SOCKET_STATUS_INIT
            
            //@asmname("tcpsocket_listen") func c_tcpsocket_listen(serveraddress: UnsafePointer<Int8>, port: Int32) -> Int32
            // RETURN VALUES of socket_fd: fd>0 success, fd<0 failure
            //  expected status: initial => in-processing or failure
            let nListen: Int32 = c_tcpsocket_listen( host, port: port )
            if( nListen > 0 )
            {
                m_fd = nListen
                m_nServerSocketStatus = .ASYNC_SOCKET_STATUS_LISTENING
                bRet = true
            }
            else if( nListen < 0 )
            {
                m_nServerSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                print( "TcpSocket startAsyncListen error! nConnect:\(nListen)\n", terminator: "" )
            }
            else
            {
                // nothing else
                m_nServerSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
            }
        }
        else
        {
            print( "TcpSocket startAsyncListen status error! \(m_nServerSocketStatus)\n", terminator: "" )
        }
        
        return bRet
    }
    
    public func isListened() -> Bool
    {
        var bRet: Bool = false
        if( m_fd != 0 )
        {
            if( .ASYNC_SOCKET_STATUS_LISTENED == m_nServerSocketStatus )
            {
                bRet = true
            }
            else if( .ASYNC_SOCKET_STATUS_LISTENING == m_nServerSocketStatus )
            {
                // RETURN VALUES 1=connected, 0=timeout(nothing), <0 is error
                let nCheck: Int32 = c_is_listened( m_fd )
                if( nCheck > 0 )
                {
                    m_nServerSocketStatus = .ASYNC_SOCKET_STATUS_LISTENED
                    bRet = true
                }
                else if( 0 == nCheck )
                {
                    // timeout, nothing todo, only wait
                }
                else if( nCheck < 0 )
                {
                    m_nServerSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                    if( m_bAutoCloseSocketWhenErrorOccurs )
                    {
                        c_tcpsocket_close( m_fd )
                        m_fd = 0
                        print( "TcpSocket check listened error! and close\n", terminator: "" )
                    }
                    else
                    {
                        print( "TcpSocket check listened error! not close\n", terminator: "" )
                    }
                }
            }
            else
            {
            }
        }
        return bRet
    }

    //@asmname("is_acceptable") func c_is_acceptable(socketfd: Int32) -> Int32
    public func isAcceptable() -> Bool
    {
        var bRet: Bool = false
        if( m_fd != 0 )
        {
            if( .ASYNC_SOCKET_STATUS_LISTENED == m_nServerSocketStatus )
            {
                // RETURN VALUES 1=data arrived, 0=timeout(nothing), <0 is error
                let nCheck: Int32 = c_is_acceptable( m_fd )
                if( nCheck > 0 )
                {
                    bRet = true
                }
                else if( 0 == nCheck )
                {
                    // timeout, no client try to connect
                }
                else if( nCheck < 0 )
                {
                    m_nServerSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                    if( m_bAutoCloseSocketWhenErrorOccurs )
                    {
                        c_tcpsocket_close( m_fd )
                        m_fd = 0
                        print( "TcpSocket check acceptable error! and close error:%d\n", nCheck, terminator: "" )
                    }
                    else
                    {
                        print( "TcpSocket check acceptable error! not close error:%d\n", nCheck, terminator: "" )
                    }
                }
            }
        }
        return bRet
    }

    //@asmname("tcpsocket_accept") func c_tcpsocket_accept(serversocketfd: Int32, remoteip: UnsafePointer<Int8>, remoteport: UnsafePointer<Int32>) -> Int32
    public func acceptClient() -> AsyncTcpClientSocket?
    {
        var pClient: AsyncTcpClientSocket?
        
        let bufferSize: Int32 = 4096
        var byteIpBuffer:Array<UInt8> = Array<UInt8>(count:Int(bufferSize), repeatedValue:0x0)
        var nPort: Int32 = 0
        let nAccept: Int32 = c_tcpsocket_accept( m_fd, remoteip: &byteIpBuffer, remoteport: &nPort )
        
        if( nAccept > 0 )
        {
            print( "accept client. port:\(nPort) \n", terminator: "" )
            pClient = AsyncTcpClientSocket( fd: nAccept )
        }
        else if( nAccept == 0 )
        {
            // time out
        }
        else
        {
            print( "accept eror!! \n", terminator: "" )
        }
        
        return pClient
    }

}

public class AsyncTcpClientSocket : AsyncTcpSocket
{
    
    private var m_nClientSocketStatus: enumAsyncSocketStatus = .ASYNC_SOCKET_STATUS_UNKNOWN
    
    public func getSocketStatus() -> enumAsyncSocketStatus
    {
        return m_nClientSocketStatus
    }
    
    override init()
    {
        super.init()
    }
    
    init( fd: Int32 )
    {
        super.init()
        m_fd = fd
        m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_CONNECTED
    }
    
    public func reset() -> Bool
    {
        var bRet: Bool = false
        
        if( m_fd != 0 )
        {
            c_tcpsocket_close( m_fd )
            m_fd = 0
        }
        
        m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_UNKNOWN
        bRet = true
        return bRet
    }
    
    public func startAsyncConnect(host: String,  port: Int32) -> Bool
    {
        var bRet: Bool = false
        
        if( .ASYNC_SOCKET_STATUS_ERROR == m_nClientSocketStatus )
        {
            self.reset()
        }
        
        if( .ASYNC_SOCKET_STATUS_UNKNOWN == m_nClientSocketStatus )
        {
            m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_INIT
            //@asmname("tcpsocket_connect") func c_tcpsocket_connect(host: UnsafePointer<Int8>, port: Int32) -> Int32
            // RETURN VALUES of socket_fd: fd>0 success, fd<0 failure
            //   expected status: initial => in-processing or failure
            let nConnect: Int32 = c_tcpsocket_connect( host, port: port )
            if( nConnect > 0 )
            {
                m_fd = nConnect
                m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_CONNECTING
                bRet = true
            }
            else if( nConnect < 0 )
            {
                m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                print( "TcpSocket startAsyncConnect error! nConnect:\(nConnect)\n", terminator: "" )
            }
            else
            {
                // nothing else
                m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
            }
        }
        else
        {
            print( "TcpSocket startAsyncConnect status error! \(m_nClientSocketStatus)\n", terminator: "" )
        }
        
        return bRet
    }
    
    //@asmname("is_connected") func c_is_connected(socketfd: Int32) -> Int32
    public func isConnected() -> Bool
    {
        var bRet: Bool = false
        if( m_fd != 0 )
        {
            if( .ASYNC_SOCKET_STATUS_CONNECTED == m_nClientSocketStatus )
            {
                bRet = true
            }
            else if( .ASYNC_SOCKET_STATUS_CONNECTING == m_nClientSocketStatus )
            {
                // RETURN VALUES 1=connected, 0=timeout(nothing), <0 is error
                let nCheck: Int32 = c_is_connected( m_fd )
                if( nCheck > 0 )
                {
                    m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_CONNECTED
                    bRet = true
                }
                else if( 0 == nCheck )
                {
                    // timeout, nothing todo, only wait
                }
                else if( nCheck < 0 )
                {
                    m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                    if( m_bAutoCloseSocketWhenErrorOccurs )
                    {
                        c_tcpsocket_close( m_fd )
                        m_fd = 0
                        print( "TcpSocket check connected error! and close\n", terminator: "" )
                    }
                    else
                    {
                        print( "TcpSocket check connected error! not close\n", terminator: "" )
                    }
                }
            }
            else
            {
            }
        }
        return bRet
    }
    
    //@asmname("is_writable") func c_is_writable(socketfd: Int32) -> Int32
    public func isWritable() -> Bool
    {
        var bRet: Bool = false
        if( m_fd != 0 )
        {
            if( .ASYNC_SOCKET_STATUS_CONNECTED == m_nClientSocketStatus )
            {
                // RETURN VALUES 1=writable, 0=timeout(nothing), <0 is error
                let nCheck: Int32 = c_is_writable( m_fd )
                if( nCheck > 0 )
                {
                    bRet = true
                }
                else if( 0 == nCheck )
                {
                    // timeout, cannot write
                }
                else if( nCheck < 0 )
                {
                    m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                    if( m_bAutoCloseSocketWhenErrorOccurs )
                    {
                        c_tcpsocket_close( m_fd )
                        m_fd = 0
                        print( "TcpSocket check writable error! and close\n", terminator: "" )
                    }
                    else
                    {
                        print( "TcpSocket check writable error! not close\n", terminator: "" )
                    }
                }
            }
        }
        return bRet
    }
    
    //@asmname("is_readable") func c_is_readable(socketfd: Int32) -> Int32
    public func isReadable() -> Bool
    {
        var bRet: Bool = false
        if( m_fd != 0 )
        {
            if( .ASYNC_SOCKET_STATUS_CONNECTED == m_nClientSocketStatus )
            {
                // RETURN VALUES 1=data arrived, 0=timeout(nothing), <0 is error
                let nCheck: Int32 = c_is_readable( m_fd )
                if( nCheck > 0 )
                {
                    bRet = true
                }
                else if( 0 == nCheck )
                {
                    // timeout, no data arrived
                }
                else if( nCheck < 0 )
                {
                    m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                    if( m_bAutoCloseSocketWhenErrorOccurs )
                    {
                        c_tcpsocket_close( m_fd )
                        m_fd = 0
                        print( "TcpSocket check readable error! and close error:%d\n", nCheck, terminator: "" )
                    }
                    else
                    {
                        print( "TcpSocket check readable error! not close error:%d\n", nCheck, terminator: "" )
                    }
                }
            }
        }
        return bRet
    }
    
    public func send(data: Array<UInt8>) -> ( result: Bool, sendCount: Int32 )
    {
        var bRet: Bool = false
        var nSendCount: Int32 = 0
        
        if( .ASYNC_SOCKET_STATUS_CONNECTED == m_nClientSocketStatus && m_fd > 0 )
        {
            let nDataLen: Int32 = Int32(data.count)
            nSendCount = c_tcpsocket_send(m_fd, buffer: data, datalen: nDataLen)
            if( nSendCount > 0 )
            {
                if( nSendCount == nDataLen )
                {
                    bRet = true
                }
                else
                {
                    bRet = true
                    print( "TcpSocket send partly, size:\(nDataLen), send:\(nSendCount), as success \n", terminator: "" )
                }
            }
            else
            {
                m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                if( m_bAutoCloseSocketWhenErrorOccurs )
                {
                    c_tcpsocket_close( m_fd )
                    m_fd = 0
                    print( "TcpSocket send error! and close\n", terminator: "" )
                }
                else
                {
                    print( "TcpSocket send error! not close\n", terminator: "" )
                }
            }
        }
        else
        {
            print( "TcpSocket cannot send since there is no fd.\n", terminator: "" )
        }
        return (bRet, nSendCount)
    }
    
    public func send(str: String) -> ( result: Bool, sendCount: Int32 )
    {
        var bRet: Bool = false
        var nSendCount: Int32 = 0
        
        if( .ASYNC_SOCKET_STATUS_CONNECTED == m_nClientSocketStatus && m_fd > 0 )
        {
            let nDataLen: Int32 = Int32(strlen(str))
            nSendCount = c_tcpsocket_send(m_fd, buffer: str, datalen: nDataLen)
            if( nSendCount > 0 )
            {
                if( nSendCount == nDataLen )
                {
                    bRet = true
                }
                else
                {
                    m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                    if( m_bAutoCloseSocketWhenErrorOccurs )
                    {
                        print( "TcpSocket send string partly, size:\(nDataLen), send:\(nSendCount), as failure and close!\n", terminator: "" )
                        c_tcpsocket_close( m_fd )
                        m_fd = 0
                    }
                    else
                    {
                        print( "TcpSocket send string partly, size:\(nDataLen), send:\(nSendCount), as failure but not close!\n", terminator: "" )
                    }
                }
            }
            else
            {
                m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                if( m_bAutoCloseSocketWhenErrorOccurs )
                {
                    c_tcpsocket_close( m_fd )
                    m_fd = 0
                    print( "TcpSocket send string error! and close\n", terminator: "" )
                }
                else
                {
                    print( "TcpSocket send string error! but not close\n", terminator: "" )
                }
            }
        }
        else
        {
            print( "TcpSocket cannot send string since there is no fd.\n", terminator: "" )
        }
        
        return (bRet, nSendCount)
    }
    
    public func send(data: NSData) -> ( result: Bool, sendCount: Int32 )
    {
        var bRet: Bool = false
        var nSendCount: Int32 = 0
        
        if( .ASYNC_SOCKET_STATUS_CONNECTED == m_nClientSocketStatus && m_fd > 0 )
        {
            let nDataLen: Int32 = Int32(data.length)
            var buffer:Array<UInt8> = Array<UInt8>(count:Int(nDataLen),repeatedValue:0x0)
            data.getBytes( &buffer, length: Int(nDataLen) )
            
            nSendCount = c_tcpsocket_send(m_fd, buffer: buffer, datalen: nDataLen)
            if( nSendCount > 0 )
            {
                if( nSendCount == nDataLen )
                {
                    bRet = true
                }
                else
                {
                    bRet = true
                    print( "TcpSocket send NSData partly, size:\(nDataLen), send:\(nSendCount), as success!\n", terminator: "" )
                }
            }
            else
            {
                m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                if( m_bAutoCloseSocketWhenErrorOccurs )
                {
                    c_tcpsocket_close( m_fd )
                    m_fd = 0
                    print( "TcpSocket send NSData error! and close\n", terminator: "" )
                }
                else
                {
                    print( "TcpSocket send NSData error! but not close\n", terminator: "" )
                }
            }
        }
        else
        {
            print( "TcpSocket cannot send NSData since there is no fd.\n", terminator: "" )
        }
        
        return (bRet, nSendCount)
    }
    
    public func sendMessage( message: IDataMessage ) -> Bool
    {
        var bRet: Bool = false
        var nSendCount: Int32 = -1
        
        m_nMessageQueueId++
        message.updateMessageId( m_nMessageQueueId )
        
        let data: NSData? = message.getMessageBuffer()
        if( data != nil )
        {
            if( data!.length > 0 )
            {
                (bRet, nSendCount) = self.send( data! )
            }
        }
        return bRet
    }
    
    public func recv( bufferSize: Int32 ) -> ( result: Bool, data: NSData? )
    {
        var bRet: Bool = false
        var dataRet: NSData? = nil
        
        if( .ASYNC_SOCKET_STATUS_CONNECTED == m_nClientSocketStatus && m_fd > 0 )
        {
            let buffer:Array<UInt8> = Array<UInt8>(count:Int(bufferSize), repeatedValue:0x0)
            
            // RETURN VALUES: >0 number of bytes recv, 0=closed by peer, -1=failure
            var nRecvCount: Int32 = 0
            let nResult: Int32 = c_tcpsocket_recv(m_fd, buffer: buffer, buffersize: bufferSize, recvdatalen: &nRecvCount)
            if( nResult > 0 )
            {
                dataRet = NSData( bytes: buffer, length: Int(nRecvCount) )
                bRet = true
            }
            else if( 0 == nResult )
            {
                bRet = false
                m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                if( m_bAutoCloseSocketWhenErrorOccurs )
                {
                    c_tcpsocket_close( m_fd )
                    m_fd = 0
                    print( "TcpSocket recv closed by peer! and close\n", terminator: "" )
                }
                else
                {
                    print( "TcpSocket recv closed by peer! but not close\n", terminator: "" )
                }
            }
            else
            {
                m_nClientSocketStatus = .ASYNC_SOCKET_STATUS_ERROR
                if( m_bAutoCloseSocketWhenErrorOccurs )
                {
                    c_tcpsocket_close( m_fd )
                    m_fd = 0
                    print( "TcpSocket recv NSData error! and close\n", terminator: "" )
                }
                else
                {
                    print( "TcpSocket recv NSData error! but not close\n", terminator: "" )
                }
            }
        }
        else
        {
            print( "TcpSocket cannot recv NSData since there is no fd.\n", terminator: "" )
        }
        
        return (result: bRet, data: dataRet)
    }

}
