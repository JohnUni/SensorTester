/*
 * TcpNetwork.c
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

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <dirent.h>
#include <netdb.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>

//int tcpsocket_connect_nonblock(const char *host, int port);
//int tcpsocket_set_nonblock(int socketfd, int nonblock);
//int tcpsocket_connect_block(const char *host,int port,int timeout);
int tcpsocket_listen(const char *serveraddress, int port);
int tcpsocket_accept(int serversocketfd, char* remoteip, int* remoteport);
int is_listened(int socketfd);
int is_acceptable(int socketfd);

int tcpsocket_connect(const char *host,int port);
int tcpsocket_send(int socketfd,const char *buffer,int datalen);
int tcpsocket_recv(int socketfd, char *buffer, int buffersize, int* recvdatalen);
int is_connected(int socketfd);
int is_readable(int socketfd);
int is_writable(int socketfd);
int tcpsocket_close(int socketfd);

// #define	O_NONBLOCK	0x0004		/* no delay */
//
// RETURN VALUES of fcntl
// F_DUPFD    A new file descriptor.
// F_GETFD    Value of flag (only the low-order bit is defined).
// F_GETFL    Value of flags.
// F_GETOWN   Value of file descriptor owner.
// other      Value other than -1.
//            Otherwise, a value of -1 is returned and errno is set to indicate the error.
int tcpsocket_set_nonblock(int socketfd, int nonblock)
{
    int nRet = -1;
    int nFlags = fcntl( socketfd,F_GETFL, 0 );
    if( nonblock > 0 )
    {
        printf("tcpsocket_set_nonblock. add O_NONBLOCK.\n" );
        nFlags |= O_NONBLOCK;
    }
    else
    {
        printf("tcpsocket_set_nonblock. remove O_NONBLOCK\n" );
        nFlags &= (~ O_NONBLOCK);
    }
    nRet = fcntl(socketfd, F_SETFL, nFlags);
    return nRet;
}

// RETURN VALUES of socket_fd: fd>0 success, fd<0 failure
//  expected status: initial => in-processing or failure
int tcpsocket_connect_nonblock(const char *host, int port)
{
    int nRet = -1;
    if( host && port > 0 )
    {
        struct hostent* hp = gethostbyname(host);
        if( hp )
        {
            struct sockaddr_in sa;
            sa.sin_len = sizeof(sa);
            memcpy( (char*)&sa.sin_addr, (char*)hp->h_addr, hp->h_length );
            sa.sin_family = AF_INET;
            //sa.sin_family = hp->h_addrtype;
            sa.sin_port = htons(port);
            
            // A -1 is returned if an error occurs, otherwise the return value is a descriptor referencing the socket.
            int sockfd = socket(hp->h_addrtype, SOCK_STREAM, 0);
            
            if( sockfd > 0 )
            {
                // non-blocking mode
                tcpsocket_set_nonblock(sockfd, 1);
                
                // Upon successful completion, a value of 0 is returned.
                // Otherwise, a value of -1 is returned and the global integer variable errno is set to indicate the error.
                int nConnect = connect(sockfd, (struct sockaddr *)&sa, sizeof(sa));
                
                if( 0 == nConnect )
                {
                    printf("tcpsocket_connect_block. OK\n" );
                    nRet = sockfd;
                }
                else if( EINPROGRESS == errno )
                {
                    printf("tcpsocket_connect_block. EINPROGRESS\n" );
                    nRet = sockfd;
                }
                else
                {
                    printf("tcpsocket_connect_block.create connect fail! host:%s port:%d err:%d\n", host, port, errno);
                    close(sockfd);
                    nRet = -5;
                }
            }
            else
            {
                printf("tcpsocket_connect_block.create socket fail! host:%s port:%d\n", host, port);
                close(sockfd);
                nRet = -4;
            }
        }
        else
        {
            printf("tcpsocket_connect_block.gethostbyname fail! host:%s\n", host);
            nRet = -3;
        }
    }
    else
    {
        printf("tcpsocket_connect_block.host cannot be null and port cannot be ZERO!\n");
        nRet = -2;
    }
    return nRet;
}

int tcpsocket_connect(const char *host,int port)
{
    return tcpsocket_connect_nonblock(host, port);
}

// RETURN VALUES: 0=success, -1=failure
//  expected status: initial => connected or failure
int tcpsocket_connect_block(const char *host,int port,int timeout)
{
    int nRet = -1;
    printf("tcpsocket_connect_block: not to use now! replaced by the func tcpsocket_connect_nonblock.\n");
    return nRet;
    
    if( host && port > 0 )
    {
        struct hostent* hp = gethostbyname(host);
        if( hp )
        {
            struct sockaddr_in sa;
            memcpy((char *)hp->h_addr, (char *)&sa.sin_addr, hp->h_length);
            sa.sin_family = hp->h_addrtype;
            sa.sin_port = htons(port);
            
            // A -1 is returned if an error occurs, otherwise the return value is a descriptor referencing the socket.
            int sockfd = socket(hp->h_addrtype, SOCK_STREAM, 0);
            
            if( sockfd > 0 )
            {
                // non-blocking mode
                tcpsocket_set_nonblock(sockfd, 1);
                
                // Upon successful completion, a value of 0 is returned.
                // Otherwise, a value of -1 is returned and the global integer variable errno is set to indicate the error.
                int nConnect = connect(sockfd, (struct sockaddr *)&sa, sizeof(sa));
                
                if( 0 == nConnect )
                {
                    fd_set          fdwrite;
                    struct timeval  tvSelect;
                    FD_ZERO(&fdwrite);
                    FD_SET(sockfd, &fdwrite);
                    tvSelect.tv_sec = timeout;
                    tvSelect.tv_usec = 0;
                    
                    // Select() returns the number of ready descriptors that are contained in the descriptor sets,
                    //    or -1 if an error occurred.
                    //    If the time limit expires, select() returns 0.
                    //    If select() returns with an error, including one due to an interrupted call,
                    //    the descriptor sets will be unmodified and the global vari-able errno will be set to indicate the error.
                    int nSelectRet = select( sockfd + 1,NULL, &fdwrite, NULL, &tvSelect );
                    if( nSelectRet > 0 )
                    {
                        int error = 0;
                        int errlen = sizeof(error);
                        getsockopt(sockfd, SOL_SOCKET, SO_ERROR, &error, (socklen_t *)&errlen);
                        if( 0 == error )
                        {
                            // set block mode
                            tcpsocket_set_nonblock(sockfd, 0);
                            
                            // to prevent from crashed
                            int set = 1;
                            setsockopt(sockfd, SOL_SOCKET, SO_NOSIGPIPE, (void *)&set, sizeof(int));
                            nRet = sockfd;
                        }
                        else
                        {
                            printf("tcpsocket_connect_block.select some error! host:%s port:%d error:%d\n", host, port, error);
                            close(sockfd);
                            nRet = -8;
                        }
                    }
                    else if ( nSelectRet < 0 )
                    {
                        printf("tcpsocket_connect_block.select fail! host:%s port:%d\n", host, port);
                        close(sockfd);
                        nRet = -7;
                    }
                    else if( nSelectRet == 0 )
                    {
                        printf("tcpsocket_connect_block.select time expired! host:%s port:%d\n", host, port);
                        close(sockfd);
                        nRet = -6;
                    }
                }
                else
                {
                    printf("tcpsocket_connect_block.create connect fail! host:%s port:%d\n", host, port);
                    close(sockfd);
                    nRet = -5;
                }
            }
            else
            {
                printf("tcpsocket_connect_block.create socket fail! host:%s port:%d\n", host, port);
                close(sockfd);
                nRet = -4;
            }
        }
        else
        {
            printf("tcpsocket_connect_block.gethostbyname fail! host:%s\n", host);
            nRet = -3;
        }
    }
    else
    {
        printf("tcpsocket_connect_block.host cannot be null and port cannot be ZERO!\n");
        nRet = -2;
    }
    return nRet;
}

// Upon successful completion, a value of 0 is returned.  Otherwise, a value of -1 is returned
//  expected status: connected => closed
int tcpsocket_close(int socketfd)
{
    int nRet = -1;
    if( socketfd > 0 )
    {
        nRet = close(socketfd);
    }
    return nRet;
}

// RETURN VALUES: >0 number of bytes sent, -1=failure
//  expected status: connected => connected, not action while any error occurs
int tcpsocket_send(int socketfd,const char *buffer,int datalen)
{
    int nRet = -1;
    // Upon successful completion, send() shall return the number of bytes sent.
    // Otherwise, -1 shall be returned and errno set to indicate the error.
    ssize_t nSend = send(socketfd, buffer, datalen, 0);
    if( nSend < 0 )
    {
        printf("tcpsocket_send fail!\n");
    }
    nRet = (int)nSend;
    return nRet;
}

// RETURN VALUES: >0 number of bytes recv, 0=closed by peer, -1=failure
//  expected status: connected => connected, not action while any error occurs
int tcpsocket_recv(int socketfd, char *buffer, int buffersize, int* recvdatalen)
{
    int nRet = -1;
    // These calls return the number of bytes received,
    // or -1 if an error occurred.
    // For TCP sockets, the return value 0 means the peer has closed its half side of the connection.
    ssize_t nRecv = recv(socketfd, buffer, buffersize, 0);
    if( nRecv > 0 )
    {
        nRet = (int)nRecv;
        if( recvdatalen )
        {
            *recvdatalen = (int)nRecv;
        }
    }
    else if( 0 == nRecv )
    {
        printf("tcpsocket_recv.recv close by peer!\n");
        nRet = (int)nRecv;
        if( recvdatalen )
        {
            *recvdatalen = 0;
        }
    }
    else
    {
        printf("tcpsocket_recv.recv fail!\n");
        nRet = (int)nRecv;
    }
    return nRet;
}

// RETURN VALUES of socket_fd: fd>0 success, fd<0 failure
//  expected status: initial => in-processing or failure
int tcpsocket_listen(const char *serveraddress, int port)
{
    int nRet = -1;
    
    int socketfd = socket(AF_INET, SOCK_STREAM, 0);
    if( socketfd > 0 )
    {
        // http://stackoverflow.com/questions/14388706/socket-options-so-reuseaddr-and-so-reuseport-how-do-they-differ-do-they-mean-t
        int reuseon = 1;
        setsockopt( socketfd, SOL_SOCKET, SO_REUSEADDR, &reuseon, sizeof(reuseon) );
        
        //bind
        struct sockaddr_in serv_addr;
        memset( &serv_addr, '\0', sizeof(serv_addr));
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_addr.s_addr = inet_addr(serveraddress);
        serv_addr.sin_port = htons(port);
        
        // Upon successful completion, bind() shall return 0;
        // otherwise, -1 shall be returned and errno set to indicate the error.
        int nBind = bind(socketfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr));
        if( nBind == 0 )
        {
            // The backlog parameter defines the maximum length for the queue of pending connections.
            // If a connection request arrives with the queue full, the client may receive an error with an indication of ECONNREFUSED.
            // Alternatively, if the underlying protocol supports retransmission, the request may be ignored so that retries may succeed.
            int backlog = 128;
            // Upon successful completions, listen() shall return 0;
            // otherwise, -1 shall be returned and errno set to indicate the error.
            int nListen = listen(socketfd, backlog);
            if( nListen == 0 )
            {
                int error = 0;
                int errlen = sizeof(error);
                getsockopt(socketfd, SOL_SOCKET, SO_ERROR, &error, (socklen_t *)&errlen);
                if( 0 == error )
                {
                    nRet = socketfd;
                }
                else
                {
                    printf("tcpsocket_listen.listen socket fail with error:%d \n", error);
                    nRet = -5;
                }
            }
            else
            {
                printf("tcpsocket_listen.listen socket fail!\n");
                nRet = -4;
            }
        }
        else
        {
            printf("tcpsocket_listen.bind socket fail!\n");
            nRet = -3;
        }
    }
    else
    {
        printf("tcpsocket_listen.create socket fail!\n");
        nRet = -2;
    }
    return nRet;
}

// RETURN VALUES of client_socket_fd: fd>0 success, fd<0 failure
//  expected status: connected => connected, not action while any error occurs
int tcpsocket_accept(int serversocketfd, char* remoteip, int* remoteport)
{
    int nRet = -1;
    struct sockaddr_in cli_addr;
    socklen_t client_len = sizeof(cli_addr);
    memset(&cli_addr, 0, sizeof(cli_addr));
    
    // Upon successful completion, accept() shall return the non-negative file descriptor of the accepted socket.
    // Otherwise, -1 shall be returned and errno set to indicate the error.
    int client_socketfd = accept( serversocketfd, (struct sockaddr *) &cli_addr, &client_len );
    if( client_socketfd > 0 )
    {
        nRet = client_socketfd;
        
        if( remoteip )
        {
            char *clientip = inet_ntoa(cli_addr.sin_addr);
            if( clientip )
            {
                memcpy(remoteip, clientip, strlen(clientip));
            }
            else
            {
                printf("tcpsocket_accept.inet_ntoa unable to get client ip\n");
            }

        }
        if( remoteport )
        {
            *remoteport = cli_addr.sin_port;
        }
    }
    else
    {
        printf("tcpsocket_accept.accept socket fail!\n");
        nRet = -2;
    }
    return nRet;
}

// RETURN VALUES 1=connected, 0=timeout(nothing), <0 is error
//  expected status: in-processing => in-processing or connected, not action while any error occurs
int is_connected(int socketfd)
{
    int nRet = -1;
    if( socketfd > 0 )
    {
        fd_set          fdwrite;
        fd_set          fderror;
        FD_ZERO(&fdwrite);
        FD_ZERO(&fderror);
        FD_SET(socketfd, &fdwrite);
        FD_SET(socketfd, &fderror);
        
        struct timeval  tvSelect;
        tvSelect.tv_sec = 0;
        tvSelect.tv_usec = 1;
        
        // Select() returns the number of ready descriptors that are contained in the descriptor sets,
        //    or -1 if an error occurred.
        //    If the time limit expires, select() returns 0.
        //    If select() returns with an error, including one due to an interrupted call,
        //    the descriptor sets will be unmodified and the global vari-able errno will be set to indicate the error.
        int nSelectRet = select( socketfd + 1, NULL, &fdwrite, &fderror, &tvSelect );
        if( nSelectRet > 0 )
        {
            if( FD_ISSET(socketfd, &fdwrite) )
            {
                int error = 0;
                int errlen = sizeof(error);
                getsockopt(socketfd, SOL_SOCKET, SO_ERROR, &error, (socklen_t *)&errlen);
                if( 0 == error )
                {
                    // set block mode
                    //tcpsocket_set_nonblock(socketfd, 0);
                    
                    // to prevent from crashed
                    int set = 1;
                    setsockopt(socketfd, SOL_SOCKET, SO_NOSIGPIPE, (void *)&set, sizeof(int));
                    nRet = 1;
                }
                else if( ETIMEDOUT == error )
                {
                    nRet = 0;
                }
                else if( ECONNREFUSED == error )
                {
                    printf("is_connected.select error! ECONNREFUSED:%d \n", error);
                }
                else
                {
                    printf("is_connected.select some error! error:%d\n", error);
                    nRet = -5;
                }
            }
            else if( FD_ISSET(socketfd, &fderror) )
            {
                printf("is_connected.select with error fd!\n");
                nRet = -4;
            }
            else
            {
                printf("is_connected.select CANNOT understand!\n");
            }
        }
        else if ( nSelectRet < 0 )
        {
            printf("is_connected.select fail!\n");
            nRet = -3;
        }
        else if( nSelectRet == 0 )
        {
            printf("is_connected.select time expired!\n");
            //nRet = -2;
            nRet = 0;
        }
    }
    else
    {
        printf("is_connected.select socketfd must be > 0!\n");
    }
    return nRet;
}

int is_listened(int socketfd)
{
    int nRet = -1;
    if( socketfd > 0 )
    {
        // cannot detect whether the socket is listened ready now.
        return 1;
        
        fd_set          fdread;
        fd_set          fderror;
        FD_ZERO(&fdread);
        FD_ZERO(&fderror);
        FD_SET(socketfd, &fdread);
        FD_SET(socketfd, &fderror);
        
        struct timeval  tvSelect;
        tvSelect.tv_sec = 0;
        tvSelect.tv_usec = 1;
        
        // Select() returns the number of ready descriptors that are contained in the descriptor sets,
        //    or -1 if an error occurred.
        //    If the time limit expires, select() returns 0.
        //    If select() returns with an error, including one due to an interrupted call,
        //    the descriptor sets will be unmodified and the global vari-able errno will be set to indicate the error.
        int nSelectRet = select( socketfd + 1, &fdread, NULL, &fderror, &tvSelect );
        if( nSelectRet > 0 )
        {
            if( FD_ISSET(socketfd, &fdread) )
            {
                int error = 0;
                int errlen = sizeof(error);
                getsockopt(socketfd, SOL_SOCKET, SO_ERROR, &error, (socklen_t *)&errlen);
                if( 0 == error )
                {
                    nRet = 1;
                }
                else
                {
                    printf("is_acceptable.select some error! error:%d\n", error);
                    nRet = -5;
                }
            }
            else if( FD_ISSET(socketfd, &fderror) )
            {
                printf("is_acceptable.select with error fd!\n");
                nRet = -4;
            }
            else
            {
                printf("is_acceptable.select CANNOT understand!\n");
            }
        }
        else if ( nSelectRet < 0 )
        {
            printf("is_acceptable.select fail!\n");
            nRet = -3;
        }
        else if( nSelectRet == 0 )
        {
            //printf("is_acceptable.select time expired!\n");
            //nRet = -2;
            nRet = 0;
        }
    }
    else
    {
        printf("is_acceptable.select socketfd must be > 0!\n");
    }
    
    return nRet;
}

// RETURN VALUES 1=connect request arrived, 0=timeout(nothing), <0 is error
//  expected status: in-listening => in-listening, not action while any error occurs
int is_acceptable(int socketfd)
{
    int nRet = -1;
    if( socketfd > 0 )
    {
        fd_set          fdread;
        fd_set          fderror;
        FD_ZERO(&fdread);
        FD_ZERO(&fderror);
        FD_SET(socketfd, &fdread);
        FD_SET(socketfd, &fderror);
        
        struct timeval  tvSelect;
        tvSelect.tv_sec = 0;
        tvSelect.tv_usec = 1;
        
        // Select() returns the number of ready descriptors that are contained in the descriptor sets,
        //    or -1 if an error occurred.
        //    If the time limit expires, select() returns 0.
        //    If select() returns with an error, including one due to an interrupted call,
        //    the descriptor sets will be unmodified and the global vari-able errno will be set to indicate the error.
        int nSelectRet = select( socketfd + 1, &fdread, NULL, &fderror, &tvSelect );
        if( nSelectRet > 0 )
        {
            if( FD_ISSET(socketfd, &fdread) )
            {
                int error = 0;
                int errlen = sizeof(error);
                getsockopt(socketfd, SOL_SOCKET, SO_ERROR, &error, (socklen_t *)&errlen);
                if( 0 == error )
                {
                    nRet = 1;
                }
                else
                {
                    printf("is_acceptable.select some error! error:%d\n", error);
                    nRet = -5;
                }
            }
            else if( FD_ISSET(socketfd, &fderror) )
            {
                printf("is_acceptable.select with error fd!\n");
                nRet = -4;
            }
            else
            {
                printf("is_acceptable.select CANNOT understand!\n");
            }
        }
        else if ( nSelectRet < 0 )
        {
            printf("is_acceptable.select fail!\n");
            nRet = -3;
        }
        else if( nSelectRet == 0 )
        {
            //printf("is_acceptable.select time expired!\n");
            //nRet = -2;
            nRet = 0;
        }
    }
    else
    {
        printf("is_acceptable.select socketfd must be > 0!\n");
    }
    
    return nRet;
}

// RETURN VALUES 1=data arrived, 0=timeout(nothing), <0 is error
//  expected status: in-processing => in-processing, not action while any error occurs
int is_readable(int socketfd)
{
    int nRet = -1;
    if( socketfd > 0 )
    {
        fd_set          fdread;
        fd_set          fderror;
        FD_ZERO(&fdread);
        FD_ZERO(&fderror);
        FD_SET(socketfd, &fdread);
        FD_SET(socketfd, &fderror);
        
        struct timeval  tvSelect;
        tvSelect.tv_sec = 0;
        tvSelect.tv_usec = 1;
        
        // Select() returns the number of ready descriptors that are contained in the descriptor sets,
        //    or -1 if an error occurred.
        //    If the time limit expires, select() returns 0.
        //    If select() returns with an error, including one due to an interrupted call,
        //    the descriptor sets will be unmodified and the global vari-able errno will be set to indicate the error.
        int nSelectRet = select( socketfd + 1, &fdread, NULL, &fderror, &tvSelect );
        if( nSelectRet > 0 )
        {
            if( FD_ISSET(socketfd, &fdread) )
            {
                int error = 0;
                int errlen = sizeof(error);
                getsockopt(socketfd, SOL_SOCKET, SO_ERROR, &error, (socklen_t *)&errlen);
                if( 0 == error )
                {
                    nRet = 1;
                }
                else
                {
                    printf("is_readable.select some error! error:%d\n", error);
                    nRet = -5;
                }
            }
            else if( FD_ISSET(socketfd, &fderror) )
            {
                printf("is_readable.select with error fd!\n");
                nRet = -4;
            }
            else
            {
                printf("is_readable.select CANNOT understand!\n");
            }
        }
        else if ( nSelectRet < 0 )
        {
            printf("is_readable.select fail!\n");
            nRet = -3;
        }
        else if( nSelectRet == 0 )
        {
            //printf("is_readable.select time expired!\n");
            //nRet = -2;
            nRet = 0;
        }
    }
    else
    {
        printf("is_readable.select socketfd must be > 0!\n");
    }
    
    return nRet;
}

// RETURN VALUES 1=writable, 0=timeout(nothing), <0 is error
//  expected status: in-processing => in-processing, not action while any error occurs
int is_writable(int socketfd)
{
    int nRet = -1;
    if( socketfd > 0 )
    {
        fd_set          fdwrite;
        fd_set          fderror;
        FD_ZERO(&fdwrite);
        FD_ZERO(&fderror);
        FD_SET(socketfd, &fdwrite);
        FD_SET(socketfd, &fderror);
        
        struct timeval  tvSelect;
        tvSelect.tv_sec = 0;
        tvSelect.tv_usec = 1;
        
        // Select() returns the number of ready descriptors that are contained in the descriptor sets,
        //    or -1 if an error occurred.
        //    If the time limit expires, select() returns 0.
        //    If select() returns with an error, including one due to an interrupted call,
        //    the descriptor sets will be unmodified and the global vari-able errno will be set to indicate the error.
        int nSelectRet = select( socketfd + 1, NULL, &fdwrite, &fderror, &tvSelect );
        if( nSelectRet > 0 )
        {
            if( FD_ISSET(socketfd, &fdwrite) )
            {
                int error = 0;
                int errlen = sizeof(error);
                getsockopt(socketfd, SOL_SOCKET, SO_ERROR, &error, (socklen_t *)&errlen);
                if( 0 == error )
                {
                    nRet = 1;
                }
                else
                {
                    printf("is_writable.select some error! error:%d\n", error);
                    nRet = -5;
                }
            }
            else if( FD_ISSET(socketfd, &fderror) )
            {
                printf("is_writable.select with error fd!\n");
                nRet = -4;
            }
            else
            {
                printf("is_writable.select CANNOT understand!\n");
            }
        }
        else if ( nSelectRet < 0 )
        {
            printf("is_writable.select fail!\n");
            nRet = -3;
        }
        else if( nSelectRet == 0 )
        {
            //printf("is_writable.select time expired!\n");
            //nRet = -2;
            nRet = 0;
        }
    }
    else
    {
        printf("is_writable.select socketfd must be > 0!\n");
    }
    
    return nRet;
}
