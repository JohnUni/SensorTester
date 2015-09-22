
import Foundation

//@asmname("tcpsocket_connect") func c_tcpsocket_connect( host: UnsafePointer<Int8>, port:Int32, timeout:Int32) -> Int32
//@asmname("tcpsocket_close") func c_tcpsocket_close(fd:Int32) -> Int32
//@asmname("tcpsocket_send") func c_tcpsocket_send(fd:Int32,buff:UnsafePointer<UInt8>,len:Int32) -> Int32
//@asmname("tcpsocket_pull") func c_tcpsocket_pull(fd:Int32,buff:UnsafePointer<UInt8>,len:Int32) -> Int32
//@asmname("tcpsocket_listen") func c_tcpsocket_listen(addr:UnsafePointer<Int8>,port:Int32)->Int32
//@asmname("tcpsocket_accept") func c_tcpsocket_accept(onsocketfd:Int32,ip:UnsafePointer<Int8>,port:UnsafePointer<Int32>) -> Int32


public class BaseSocket
{
    var addr: String
    var port: Int
    var fd: Int32?
    
    init()
    {
        self.addr = ""
        self.port = 0
        fd = 0
    }
    
    public init(addr :String, port :Int)
    {
        self.addr = addr
        self.port = port
        fd = 0
    }
}

public class TCP_Client : BaseSocket
{
    public func connect(timeout t:Int) -> (Bool, String)
    {
        var rs: Int32 = c_tcpsocket_connect(self.addr, Int32(self.port))
        if rs > 0
        {
            self.fd=rs
            return (true, "connect success")
        }
        else
        {
            switch rs
            {
            case -1:
                return (false,"qeury server fail")
            case -2:
                return (false,"connection closed")
            case -3:
                return (false,"connect timeout")
            default:
                return (false,"unknow err.")
            }
        }
    }

    public func close() -> (Bool, String)
    {
        if let fd:Int32 = self.fd
        {
            c_tcpsocket_close(fd)
            self.fd = nil
            return (true, "close success")
        }
        else
        {
            return (false, "socket not open")
        }
    }

    public func send(data: Array<UInt8>) -> (Bool, String)
    {
        if let fd:Int32=self.fd
        {
            let sendsize: Int32 = c_tcpsocket_send(fd, data, Int32(data.count))
            if Int(sendsize) == data.count
            {
               return (true,"send success")
            }
            else
            {
                return (false,"send error")
            }
        }
        else
        {
            return (false,"socket not open")
        }
    }

    public func send(str: String) -> (Bool, String)
    {
        if let fd:Int32=self.fd
        {
            let sendsize:Int32 = c_tcpsocket_send(fd, str, Int32(strlen(str)))
            if sendsize == Int32(strlen(str))
            {
                return (true,"send success")
            }
            else
            {
                return (false,"send error")
            }
        }
        else
        {
            return (false,"socket not open")
        }
    }

    public func send(data: NSData)->(Bool,String)
    {
        if let fd:Int32 = self.fd
        {
            var buff:Array<UInt8> = Array<UInt8>(count:data.length,repeatedValue:0x0)
            data.getBytes(&buff, length: data.length)
            var sendsize: Int32 = c_tcpsocket_send(fd, buff, Int32(data.length))
            if sendsize == Int32(data.length)
            {
                return (true,"send success")
            }
            else
            {
                return (false,"send error")
            }
        }
        else
        {
            return (false,"socket not open")
        }
    }

    public func read(expectlen: Int) -> Array<UInt8>?
    {
        if let fd:Int32 = self.fd
        {
            var buff:Array<UInt8> = Array<UInt8>(count:expectlen,repeatedValue:0x0)
            var readLen: Int32 = 0;// c_tcpsocket_pull(fd, &buff, Int32(expectlen))
            if readLen <= 0
            {
                return nil
            }
            var rs = buff[0...Int(readLen-1)]
            var data: Array<UInt8> = Array<UInt8>(rs)
            return data
        }
       return nil
    }
}

public class TCPServer : BaseSocket
{
    public func listen() -> (Bool, String)
    {
        var fd:Int32 = c_tcpsocket_listen(self.addr, Int32(self.port))
        if fd > 0
        {
            self.fd=fd
            return (true,"listen success")
        }
        else
        {
            return (false,"listen fail")
        }
    }
    
    /*
    public func accept() -> TCPClient?
    {
        if let serferfd = self.fd
        {
            var buff:Array<Int8> = Array<Int8>(count:16,repeatedValue:0x0)
            var port:Int32 = 0
            var clientfd:Int32 = c_tcpsocket_accept(serferfd, &buff,&port)
            if clientfd < 0
            {
                return nil
            }
            var tcpClient: TCPClient = TCPClient()
            tcpClient.fd = clientfd
            tcpClient.port = Int(port)
            if let addr = String(CString: buff, encoding: NSUTF8StringEncoding)
            {
               tcpClient.addr = addr
            }
            return tcpClient
        }
        return nil
    }
    */
    
    public func close() -> (Bool, String)
    {
        if let fd:Int32 = self.fd
        {
            c_tcpsocket_close(fd)
            self.fd = nil
            return (true,"close success")
        }
        else
        {
            return (false,"socket not open")
        }
    }
}
