
import Foundation

@asmname("udpsocket_server") func c_udpsocket_server(host:UnsafePointer<Int8>,port:Int32) -> Int32
@asmname("udpsocket_recive") func c_udpsocket_recive(fd:Int32,buff:UnsafePointer<UInt8>,len:Int32,ip:UnsafePointer<Int8>,port:UnsafePointer<Int32>) -> Int32
@asmname("udpsocket_close") func c_udpsocket_close(fd:Int32) -> Int32
@asmname("udpsocket_client") func c_udpsocket_client() -> Int32
@asmname("udpsocket_get_server_ip") func c_udpsocket_get_server_ip(host:UnsafePointer<Int8>,ip:UnsafePointer<Int8>) -> Int32
@asmname("udpsocket_sentto") func c_udpsocket_sentto(fd:Int32,buff:UnsafePointer<UInt8>,len:Int32,ip:UnsafePointer<Int8>,port:Int32) -> Int32

public class UDPClient: BaseSocket
{
    public override init(addr a:String,port p:Int)
    {
        super.init()
        var remoteipbuff:[Int8] = [Int8](count:16,repeatedValue:0x0)
        var ret=c_udpsocket_get_server_ip(a, remoteipbuff)
        if ret==0{
            if let ip=String(CString: remoteipbuff, encoding: NSUTF8StringEncoding){
                self.addr=ip
                self.port=p
                var fd:Int32=c_udpsocket_client()
                if fd>0{
                    self.fd=fd
                }
            }
        }
    }

    public func send(data d:[UInt8])->(Bool,String)
    {
        if let fd:Int32=self.fd{
            var sendsize:Int32=c_udpsocket_sentto(fd, d, Int32(d.count), self.addr,Int32(self.port))
            if Int(sendsize)==d.count{
                return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    /*
    * send string
    * return success or fail with message
    */
    public func send(str s:String)->(Bool,String){
        if let fd:Int32=self.fd{
            var sendsize:Int32=c_udpsocket_sentto(fd, s, Int32(strlen(s)), self.addr,Int32(self.port))
            if sendsize==Int32(strlen(s)){
                return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    /*
    *
    * send nsdata
    */
    public func send(data d:NSData)->(Bool,String){
        if let fd:Int32=self.fd{
            var buff:[UInt8] = [UInt8](count:d.length,repeatedValue:0x0)
            d.getBytes(&buff, length: d.length)
            var sendsize:Int32=c_udpsocket_sentto(fd, buff, Int32(d.length), self.addr,Int32(self.port))
            if sendsize==Int32(d.length){
                return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    public func close()->(Bool,String){
        if let fd:Int32=self.fd{
            c_udpsocket_close(fd)
            self.fd=nil
            return (true,"close success")
        }else{
            return (false,"socket not open")
        }
    }
    //TODO add multycast and boardcast
}

public class UDPServer : BaseSocket{
    public override init(addr a:String,port p:Int){
        super.init(addr: a, port: p)
        var fd:Int32 = c_udpsocket_server(self.addr, Int32(self.port))
        if fd>0{
            self.fd=fd
        }
    }
    //TODO add multycast and boardcast
    public func recv(expectlen:Int)->([UInt8]?,String,Int){
        if let fd:Int32 = self.fd{
            var buff:[UInt8] = [UInt8](count:expectlen,repeatedValue:0x0)
            var remoteipbuff:[Int8] = [Int8](count:16,repeatedValue:0x0)
            var remoteport:Int32=0
            var readLen:Int32=c_udpsocket_recive(fd, buff, Int32(expectlen), &remoteipbuff, &remoteport)
            var port:Int=Int(remoteport)
            var addr:String=""
            if let ip=String(CString: remoteipbuff, encoding: NSUTF8StringEncoding){
                addr=ip
            }
            if readLen<=0{
                return (nil,addr,port)
            }
            var rs=buff[0...Int(readLen-1)]
            var data:[UInt8] = Array(rs)
            return (data,addr,port)
        }
        return (nil,"no ip",0)
    }
    public func close()->(Bool,String){
        if let fd:Int32=self.fd{
            c_udpsocket_close(fd)
            self.fd=nil
            return (true,"close success")
        }else{
            return (false,"socket not open")
        }
    }
}
