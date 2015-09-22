/*
* ViewController.swift
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
import UIKit

class ViewController: UIViewController, IMessageHandler {

    @IBOutlet weak var labelColor: UILabel!
    
    @IBOutlet weak var buttonForward: UIButton!
    @IBOutlet weak var buttonBackward: UIButton!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    
    @IBOutlet weak var buttonBrake: UIButton!
    @IBOutlet weak var buttonSpeedUp: UIButton!
    @IBOutlet weak var buttonSpeedDown: UIButton!
    
    @IBOutlet weak var buttonForwardOneUnit: UIButton!
    @IBOutlet weak var buttonBackwardOneUnit: UIButton!
    
    @IBOutlet weak var labelCarDirection: UILabel!
    
    @IBOutlet weak var viewColorDataArea: ColorDataView!
    
    @IBOutlet weak var viewSpeedDataArea: UIView!
    
    @IBOutlet weak var viewDirectionDataArea: UIView!
    
    private var m_remote: NetworkRemote!
    private var m_server: NetworkServer!
    
    private var m_clientDataHandler: INetworkDataHandler?
    private var m_serverDataHandler: INetworkDataHandler?
    
    private var m_serverMessageHandler: IMessageHandler?
    
    private var m_rawColorBuffer: DataBuffer<RawColor> = DataBuffer<RawColor>()
    private var m_speedBuffer: DataBuffer<SpeedItem> = DataBuffer<SpeedItem>()
    private var m_directionBuffer: DataBuffer<DirectionItem> = DataBuffer<DirectionItem>()
    
    // public enum FAIcon : NSInteger {
    private enum enumButtonIndex : NSInteger
    {
        case BUTTON_FORWARD = 1
        case BUTTON_BACKWARD = 2
        case BUTTON_LEFT = 3
        case BUTTON_RIGHT = 4
        case BUTTON_BRAKE = 5
        case BUTTON_SPEEDUP = 6
        case BUTTON_SPEEDDOWN = 7
        case BUTTON_FORWARD_ONEUNIT = 8
        case BUTTON_BACKWARD_ONEUNIT = 9
    }
    
    internal func getRawColorBuffer() -> DataBuffer<RawColor>
    {
        return m_rawColorBuffer
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        m_serverMessageHandler = ServerMessageHandler()
        m_serverDataHandler = FantasticRawNetworkHandler( messageHandler: m_serverMessageHandler! )
        
        m_server = NetworkServer()
        m_server.start( m_serverDataHandler! )
        
        m_clientDataHandler = RemoteNetworkDataHandler( messageHandler: self )
        
        m_remote = NetworkRemote()
        m_remote.start( m_clientDataHandler! )
        
        // buttonForward, buttonBackward, buttonLeft, buttonRight
        buttonForward.tag = enumButtonIndex.BUTTON_FORWARD.rawValue
        buttonBackward.tag = enumButtonIndex.BUTTON_BACKWARD.rawValue
        buttonLeft.tag = enumButtonIndex.BUTTON_LEFT.rawValue
        buttonRight.tag = enumButtonIndex.BUTTON_RIGHT.rawValue
        
        buttonForward.addTarget(self, action: "touchedDown:", forControlEvents: UIControlEvents.TouchDown)
        buttonBackward.addTarget(self, action: "touchedDown:", forControlEvents: UIControlEvents.TouchDown)
        buttonLeft.addTarget(self, action: "touchedDown:", forControlEvents: UIControlEvents.TouchDown)
        buttonRight.addTarget(self, action: "touchedDown:", forControlEvents: UIControlEvents.TouchDown)
        
        buttonForward.addTarget(self, action: "touchedUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonBackward.addTarget(self, action: "touchedUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonLeft.addTarget(self, action: "touchedUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonRight.addTarget(self, action: "touchedUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        
        buttonForward.addTarget(self, action: "touchedUpOutside:", forControlEvents: UIControlEvents.TouchUpOutside)
        buttonBackward.addTarget(self, action: "touchedUpOutside:", forControlEvents: UIControlEvents.TouchUpOutside)
        buttonLeft.addTarget(self, action: "touchedUpOutside:", forControlEvents: UIControlEvents.TouchUpOutside)
        buttonRight.addTarget(self, action: "touchedUpOutside:", forControlEvents: UIControlEvents.TouchUpOutside)

        // buttonBrake
        buttonBrake.tag = enumButtonIndex.BUTTON_BRAKE.rawValue
        buttonBrake.addTarget(self, action: "touchedDown:", forControlEvents: UIControlEvents.TouchDown)

        // buttonSpeedUp, buttonSpeedDown
        buttonSpeedUp.tag = enumButtonIndex.BUTTON_SPEEDUP.rawValue
        buttonSpeedUp.addTarget(self, action: "touchedDown:", forControlEvents: UIControlEvents.TouchDown)
        buttonSpeedDown.tag = enumButtonIndex.BUTTON_SPEEDDOWN.rawValue
        buttonSpeedDown.addTarget(self, action: "touchedDown:", forControlEvents: UIControlEvents.TouchDown)
        
        // buttonForwardOneUnit, buttonSpeedDown
        buttonForwardOneUnit.tag = enumButtonIndex.BUTTON_FORWARD_ONEUNIT.rawValue
        buttonForwardOneUnit.addTarget(self, action: "touchedDown:", forControlEvents: UIControlEvents.TouchDown)
        buttonBackwardOneUnit.tag = enumButtonIndex.BUTTON_BACKWARD_ONEUNIT.rawValue
        buttonBackwardOneUnit.addTarget(self, action: "touchedDown:", forControlEvents: UIControlEvents.TouchDown)

        let fontFA: UIFont? = UIFont(name: "FontAwesome", size: 100)
        if( fontFA != nil )
        {
            labelCarDirection.font = fontFA!
        }
        
        let strFA: String = String.fontAwesomeIconStringForIconIdentifier("fa-space-shuttle")
        labelCarDirection.text = strFA
        
        self.rotateRobotDirectionInDegree( 0 )
        
        viewColorDataArea.setDataController(self)
        
        //var timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "delayTimer", userInfo: nil, repeats: true)
    }
    
    func delayTimer() -> Void
    {
        var timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "timerCountUp", userInfo: nil, repeats: true)
    }
    
    func rotateRobotDirectionInDegree(nAngleInDegree: CGFloat) -> Void
    {
        let nFactor: CGFloat = CGFloat(2.0 * M_PI / 360.0)
        let nAngle: CGFloat = nAngleInDegree * nFactor
        rotateRobotDirection( nAngle )
    }
    
    func rotateRobotDirection(nAngle: CGFloat) -> Void
    {
        //let nAngle: CGFloat = CGFloat( (M_PI_4)/2.0 )
        let rotate = CGAffineTransformMakeRotation( -CGFloat(M_PI_2) + nAngle )
        let translate = CGAffineTransformMakeTranslation((labelCarDirection.bounds.height / 2)-(labelCarDirection.bounds.width / 2), (labelCarDirection.bounds.width / 2)-(labelCarDirection.bounds.height / 2))
        labelCarDirection.transform = CGAffineTransformConcat(rotate, translate)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchedDown(sender: UIButton)
    {
        let nIndex: enumButtonIndex =  enumButtonIndex( rawValue: sender.tag )!
        switch(nIndex)
        {
        case enumButtonIndex.BUTTON_FORWARD:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_FORWARD,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_BACKWARD:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_BACKWARD,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_LEFT:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_TURN_LEFT,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_RIGHT:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_TURN_RIGHT,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_BRAKE:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_SPEEDUP:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_SPEEDUP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_SPEEDDOWN:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_SPEEDDOWN,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_FORWARD_ONEUNIT:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_FORWARD_DISTANCE,
                nData: 1,
                nTag: 0)
        case enumButtonIndex.BUTTON_BACKWARD_ONEUNIT:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_BACKWARD_DISTANCE,
                nData: 1,
                nTag: 0)
        }
    }
    
    @IBAction func touchedUpInside(sender: UIButton)
    {
        let nIndex: enumButtonIndex =  enumButtonIndex( rawValue: sender.tag )!
        switch(nIndex)
        {
        case enumButtonIndex.BUTTON_FORWARD:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_BACKWARD:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_LEFT:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_RIGHT:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_BRAKE:
            let n: NSInteger = 0
        case enumButtonIndex.BUTTON_SPEEDUP:
            let n: NSInteger = 0
        case enumButtonIndex.BUTTON_SPEEDDOWN:
            let n: NSInteger = 0
        case enumButtonIndex.BUTTON_FORWARD_ONEUNIT:
            let n: NSInteger = 0
        case enumButtonIndex.BUTTON_BACKWARD_ONEUNIT:
            let n: NSInteger = 0
        }
    }
    
    @IBAction func touchedUpOutside(sender: UIButton)
    {
        let nIndex: enumButtonIndex =  enumButtonIndex( rawValue: sender.tag )!
        switch(nIndex)
        {
        case enumButtonIndex.BUTTON_FORWARD:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_BACKWARD:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_LEFT:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_RIGHT:
            m_remote.sendControlCommand(enumRemoteSubCommand.MESSAGE_SUBTYPE_REMOTE_COMMAND_STOP,
                nData: 0,
                nTag: 0)
        case enumButtonIndex.BUTTON_BRAKE:
            let n: NSInteger = 0
        case enumButtonIndex.BUTTON_SPEEDUP:
            let n: NSInteger = 0
        case enumButtonIndex.BUTTON_SPEEDDOWN:
            let n: NSInteger = 0
        case enumButtonIndex.BUTTON_FORWARD_ONEUNIT:
            let n: NSInteger = 0
        case enumButtonIndex.BUTTON_BACKWARD_ONEUNIT:
            let n: NSInteger = 0
        }
    }
    
    internal func handle(message: IDataMessage ) -> Bool
    {
        var bRet: Bool = false
        
        let messageType: enumRemoteCommand = message.getMessageType()
        let nMessageId: Int32 = message.getMessageId()
        
        switch( messageType )
        {
        case .MESSAGE_TYPE_REMOTE_COMMAND:
            print("ViewController WHY COMMAND MESSAGE? \n", terminator: "")
            break
        case .MESSAGE_TYPE_REMOTE_COMMAND_ACK:
            print("ViewController.command ack: id=\(nMessageId) \n", terminator: "")
            break
            
        case .MESSAGE_TYPE_SENSOR_COLOR:
            break
        case .MESSAGE_TYPE_SENSOR_GYRO:
            dispatch_async( dispatch_get_main_queue() ) {
                
                let gyroMessage: SensorNotificationMessage = message as! SensorNotificationMessage
                let nValue: Double = gyroMessage.getValue()
                
                self.rotateRobotDirectionInDegree( CGFloat(nValue) )
            }
            
            break
        case .MESSAGE_TYPE_SENSOR_SONIC:
            break
        case .MESSAGE_TYPE_SENSOR_TOUCH:
            break
        case .MESSAGE_TYPE_SENSOR_RAWCOLOR:
            dispatch_async( dispatch_get_main_queue() ) {
                
                let rawColor: SensorRawColorNotificationMessage = message as! SensorRawColorNotificationMessage
                
                let nRawIntR: Int32 = rawColor.getRawIntR()
                let nRawIntG: Int32 = rawColor.getRawIntG()
                let nRawIntB: Int32 = rawColor.getRawIntB()
                
                let nRawR: Double = rawColor.getRawR()
                let nRawG: Double = rawColor.getRawG()
                let nRawB: Double = rawColor.getRawB()
                let nSamplingTime: Int32 = rawColor.getSamplingTime()
                
                let color: RawColor = RawColor(rawR: nRawR, rawG: nRawG, rawB: nRawB)
                self.m_rawColorBuffer.addData(nSamplingTime, data: color)
                self.viewColorDataArea.setNeedsDisplay()
                
                var strColor: String = "Color:"
                strColor = strColor + "R\(nRawR) "
                strColor = strColor + "G\(nRawG) "
                strColor = strColor + "B\(nRawB)"
                self.labelColor.text = strColor;
                
                print("ViewController.MESSAGE_TYPE_SENSOR_RAWCOLOR R:\(nRawR) G:\(nRawG) B:\(nRawB) \n", terminator: "")
                
            }
            
            break
            
        case .MESSAGE_TYPE_UNKNOWN,
        .MESSAGE_TYPE_UNKNOWN_ACK,
        .MESSAGE_TYPE_SENSOR_COLOR_ACK,
        .MESSAGE_TYPE_SENSOR_GYRO_ACK,
        .MESSAGE_TYPE_SENSOR_SONIC_ACK,
        .MESSAGE_TYPE_SENSOR_TOUCH_ACK,
        .MESSAGE_TYPE_SENSOR_RAWCOLOR_ACK:
            print("ViewController. not processed message:\(messageType.rawValue) \n", terminator: "")
            let n: Int32 = -2
            break
            
        default:
            print("WHAT message? \(messageType.rawValue) \n", terminator: "")
            let n: Int32 = -1
            break
        }
        
        bRet = true
        
        return bRet

    }
    
    private var m_nTestRawRed: Double = 0.0
    private var m_nTestRawGreen: Double = 0.3
    private var m_nTestRawBlue: Double = 0.7
    private var m_nSamplingTime: Int32 = 1000
    func timerCountUp() -> Void
    {
        // print("timerCountUp \n")
        
        m_nSamplingTime++
        m_nTestRawRed += 0.005
        m_nTestRawGreen += 0.005
        m_nTestRawBlue += 0.005
        
        if( m_nTestRawRed >= 1 )
        {
            m_nTestRawRed = 0
        }
        if( m_nTestRawGreen >= 1 )
        {
            m_nTestRawGreen = 0
        }
        if( m_nTestRawBlue >= 1 )
        {
            m_nTestRawBlue = 0
        }
        
        let color: RawColor = RawColor(rawR: m_nTestRawRed, rawG: m_nTestRawGreen, rawB: m_nTestRawBlue)
        //m_rawColorBuffer.addData(m_nSamplingTime, data: color)
        
        viewColorDataArea.setNeedsDisplay()
    }
    
}
