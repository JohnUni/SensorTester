
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <string.h>
#include <unistd.h>
#include <netdb.h>

#define udpsocket_buff_len 8192

int udpsocket_server(const char *addr,int port)
{
    //create socket
    int socketfd=socket(AF_INET, SOCK_DGRAM, 0);
    int reuseon   = 1;
    setsockopt( socketfd, SOL_SOCKET, SO_REUSEADDR, &reuseon, sizeof(reuseon) );
    //bind
    struct sockaddr_in serv_addr;
    memset( &serv_addr, '\0', sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr(addr);
    serv_addr.sin_port = htons(port);
    int r=bind(socketfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr));
    if(r==0)
    {
        return socketfd;
    }
    else
    {
        return -1;
    }
}

int udpsocket_recive(int socket_fd,char *outdata,int expted_len,char *remoteip,int* remoteport)
{
    struct sockaddr_in  cli_addr;
    socklen_t clilen=sizeof(cli_addr);
    memset(&cli_addr, 0x0, sizeof(struct sockaddr_in));
    int len=(int)recvfrom(socket_fd, outdata, expted_len, 0, (struct sockaddr *)&cli_addr, &clilen);
    char *clientip=inet_ntoa(cli_addr.sin_addr);
    memcpy(remoteip, clientip, strlen(clientip));
    *remoteport=cli_addr.sin_port;
    return len;
}

int udpsocket_close(int socket_fd)
{
    return close(socket_fd);
}

int udpsocket_client()
{
    //create socket
    int socketfd=socket(AF_INET, SOCK_DGRAM, 0);
    int reuseon   = 1;
    setsockopt( socketfd, SOL_SOCKET, SO_REUSEADDR, &reuseon, sizeof(reuseon) );
    return socketfd;
}

int udpsocket_get_server_ip(char *host,char *ip)
{
    struct hostent *hp;
    struct sockaddr_in addr;
    hp = gethostbyname(host);
    if(hp==NULL)
    {
        return -1;
    }
    bcopy((char *)hp->h_addr, (char *)&addr.sin_addr, hp->h_length);
    char *clientip=inet_ntoa(addr.sin_addr);
    memcpy(ip, clientip, strlen(clientip));
    return 0;
}

int udpsocket_sentto(int socket_fd,char *msg,int len, char *toaddr, int topotr)
{
    struct sockaddr_in addr;
    socklen_t addrlen=sizeof(addr);
    memset(&addr, 0x0, sizeof(struct sockaddr_in));
    addr.sin_family=AF_INET;
    addr.sin_port=htons(topotr);
    addr.sin_addr.s_addr=inet_addr(toaddr);
    int sendlen=(int)sendto(socket_fd, msg, len, 0, (struct sockaddr *)&addr, addrlen);
    return sendlen;
}
