/*
* NSString+FontAwesomeSwift.swift
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
*
*
* appreciated: "Font Awesome by Dave Gandy - http://fontawesome.io"
*
*/

import Foundation

public enum enumFontAwesomeIcon : NSInteger {
    case FontAwesomeGlass
    case FontAwesomeMusic
    case FontAwesomeSearch
    case FontAwesomeEnvelopeO
    case FontAwesomeHeart
    case FontAwesomeStar
    case FontAwesomeStarO
    case FontAwesomeUser
    case FontAwesomeFilm
    case FontAwesomeThLarge
    case FontAwesomeTh
    case FontAwesomeThList
    case FontAwesomeCheck
    case FontAwesomeTimes
    case FontAwesomeSearchPlus
    case FontAwesomeSearchMinus
    case FontAwesomePowerOff
    case FontAwesomeSignal
    case FontAwesomeCog
    case FontAwesomeTrashO
    case FontAwesomeHome
    case FontAwesomeFileO
    case FontAwesomeClockO
    case FontAwesomeRoad
    case FontAwesomeDownload
    case FontAwesomeArrowCircleODown
    case FontAwesomeArrowCircleOUp
    case FontAwesomeInbox
    case FontAwesomePlayCircleO
    case FontAwesomeRepeat
    case FontAwesomeRefresh
    case FontAwesomeListAlt
    case FontAwesomeLock
    case FontAwesomeFlag
    case FontAwesomeHeadphones
    case FontAwesomeVolumeOff
    case FontAwesomeVolumeDown
    case FontAwesomeVolumeUp
    case FontAwesomeQrcode
    case FontAwesomeBarcode
    case FontAwesomeTag
    case FontAwesomeTags
    case FontAwesomeBook
    case FontAwesomeBookmark
    case FontAwesomePrint
    case FontAwesomeCamera
    case FontAwesomeFont
    case FontAwesomeBold
    case FontAwesomeItalic
    case FontAwesomeTextHeight
    case FontAwesomeTextWidth
    case FontAwesomeAlignLeft
    case FontAwesomeAlignCenter
    case FontAwesomeAlignRight
    case FontAwesomeAlignJustify
    case FontAwesomeList
    case FontAwesomeOutdent
    case FontAwesomeIndent
    case FontAwesomeVideoCamera
    case FontAwesomePictureO
    case FontAwesomePencil
    case FontAwesomeMapMarker
    case FontAwesomeAdjust
    case FontAwesomeTint
    case FontAwesomePencilSquareO
    case FontAwesomeShareSquareO
    case FontAwesomeCheckSquareO
    case FontAwesomeArrows
    case FontAwesomeStepBackward
    case FontAwesomeFastBackward
    case FontAwesomeBackward
    case FontAwesomePlay
    case FontAwesomePause
    case FontAwesomeStop
    case FontAwesomeForward
    case FontAwesomeFastForward
    case FontAwesomeStepForward
    case FontAwesomeEject
    case FontAwesomeChevronLeft
    case FontAwesomeChevronRight
    case FontAwesomePlusCircle
    case FontAwesomeMinusCircle
    case FontAwesomeTimesCircle
    case FontAwesomeCheckCircle
    case FontAwesomeQuestionCircle
    case FontAwesomeInfoCircle
    case FontAwesomeCrosshairs
    case FontAwesomeTimesCircleO
    case FontAwesomeCheckCircleO
    case FontAwesomeBan
    case FontAwesomeArrowLeft
    case FontAwesomeArrowRight
    case FontAwesomeArrowUp
    case FontAwesomeArrowDown
    case FontAwesomeShare
    case FontAwesomeExpand
    case FontAwesomeCompress
    case FontAwesomePlus
    case FontAwesomeMinus
    case FontAwesomeAsterisk
    case FontAwesomeExclamationCircle
    case FontAwesomeGift
    case FontAwesomeLeaf
    case FontAwesomeFire
    case FontAwesomeEye
    case FontAwesomeEyeSlash
    case FontAwesomeExclamationTriangle
    case FontAwesomePlane
    case FontAwesomeCalendar
    case FontAwesomeRandom
    case FontAwesomeComment
    case FontAwesomeMagnet
    case FontAwesomeChevronUp
    case FontAwesomeChevronDown
    case FontAwesomeRetweet
    case FontAwesomeShoppingCart
    case FontAwesomeFolder
    case FontAwesomeFolderOpen
    case FontAwesomeArrowsV
    case FontAwesomeArrowsH
    case FontAwesomeBarChartO
    case FontAwesomeTwitterSquare
    case FontAwesomeFacebookSquare
    case FontAwesomeCameraRetro
    case FontAwesomeKey
    case FontAwesomeCogs
    case FontAwesomeComments
    case FontAwesomeThumbsOUp
    case FontAwesomeThumbsODown
    case FontAwesomeStarHalf
    case FontAwesomeHeartO
    case FontAwesomeSignOut
    case FontAwesomeLinkedinSquare
    case FontAwesomeThumbTack
    case FontAwesomeExternalLink
    case FontAwesomeSignIn
    case FontAwesomeTrophy
    case FontAwesomeGithubSquare
    case FontAwesomeUpload
    case FontAwesomeLemonO
    case FontAwesomePhone
    case FontAwesomeSquareO
    case FontAwesomeBookmarkO
    case FontAwesomePhoneSquare
    case FontAwesomeTwitter
    case FontAwesomeFacebook
    case FontAwesomeGithub
    case FontAwesomeUnlock
    case FontAwesomeCreditCard
    case FontAwesomeRss
    case FontAwesomeHddO
    case FontAwesomeBullhorn
    case FontAwesomeBell
    case FontAwesomeCertificate
    case FontAwesomeHandORight
    case FontAwesomeHandOLeft
    case FontAwesomeHandOUp
    case FontAwesomeHandODown
    case FontAwesomeArrowCircleLeft
    case FontAwesomeArrowCircleRight
    case FontAwesomeArrowCircleUp
    case FontAwesomeArrowCircleDown
    case FontAwesomeGlobe
    case FontAwesomeWrench
    case FontAwesomeTasks
    case FontAwesomeFilter
    case FontAwesomeBriefcase
    case FontAwesomeArrowsAlt
    case FontAwesomeUsers
    case FontAwesomeLink
    case FontAwesomeCloud
    case FontAwesomeFlask
    case FontAwesomeScissors
    case FontAwesomeFilesO
    case FontAwesomePaperclip
    case FontAwesomeFloppyO
    case FontAwesomeSquare
    case FontAwesomeBars
    case FontAwesomeListUl
    case FontAwesomeListOl
    case FontAwesomeStrikethrough
    case FontAwesomeUnderline
    case FontAwesomeTable
    case FontAwesomeMagic
    case FontAwesomeTruck
    case FontAwesomePinterest
    case FontAwesomePinterestSquare
    case FontAwesomeGooglePlusSquare
    case FontAwesomeGooglePlus
    case FontAwesomeMoney
    case FontAwesomeCaretDown
    case FontAwesomeCaretUp
    case FontAwesomeCaretLeft
    case FontAwesomeCaretRight
    case FontAwesomeColumns
    case FontAwesomeSort
    case FontAwesomeSortAsc
    case FontAwesomeSortDesc
    case FontAwesomeEnvelope
    case FontAwesomeLinkedin
    case FontAwesomeUndo
    case FontAwesomeGavel
    case FontAwesomeTachometer
    case FontAwesomeCommentO
    case FontAwesomeCommentsO
    case FontAwesomeBolt
    case FontAwesomeSitemap
    case FontAwesomeUmbrella
    case FontAwesomeClipboard
    case FontAwesomeLightbulbO
    case FontAwesomeExchange
    case FontAwesomeCloudDownload
    case FontAwesomeCloudUpload
    case FontAwesomeUserMd
    case FontAwesomeStethoscope
    case FontAwesomeSuitcase
    case FontAwesomeBellO
    case FontAwesomeCoffee
    case FontAwesomeCutlery
    case FontAwesomeFileTextO
    case FontAwesomeBuildingO
    case FontAwesomeHospitalO
    case FontAwesomeAmbulance
    case FontAwesomeMedkit
    case FontAwesomeFighterJet
    case FontAwesomeBeer
    case FontAwesomeHSquare
    case FontAwesomePlusSquare
    case FontAwesomeAngleDoubleLeft
    case FontAwesomeAngleDoubleRight
    case FontAwesomeAngleDoubleUp
    case FontAwesomeAngleDoubleDown
    case FontAwesomeAngleLeft
    case FontAwesomeAngleRight
    case FontAwesomeAngleUp
    case FontAwesomeAngleDown
    case FontAwesomeDesktop
    case FontAwesomeLaptop
    case FontAwesomeTablet
    case FontAwesomeMobile
    case FontAwesomeCircleO
    case FontAwesomeQuoteLeft
    case FontAwesomeQuoteRight
    case FontAwesomeSpinner
    case FontAwesomeCircle
    case FontAwesomeReply
    case FontAwesomeGithubAlt
    case FontAwesomeFolderO
    case FontAwesomeFolderOpenO
    case FontAwesomeSmileO
    case FontAwesomeFrownO
    case FontAwesomeMehO
    case FontAwesomeGamepad
    case FontAwesomeKeyboardO
    case FontAwesomeFlagO
    case FontAwesomeFlagCheckered
    case FontAwesomeTerminal
    case FontAwesomeCode
    case FontAwesomeReplyAll
    case FontAwesomeMailReplyAll
    case FontAwesomeStarHalfO
    case FontAwesomeLocationArrow
    case FontAwesomeCrop
    case FontAwesomeCodeFork
    case FontAwesomeChainBroken
    case FontAwesomeQuestion
    case FontAwesomeInfo
    case FontAwesomeExclamation
    case FontAwesomeSuperscript
    case FontAwesomeSubscript
    case FontAwesomeEraser
    case FontAwesomePuzzlePiece
    case FontAwesomeMicrophone
    case FontAwesomeMicrophoneSlash
    case FontAwesomeShield
    case FontAwesomeCalendarO
    case FontAwesomeFireExtinguisher
    case FontAwesomeRocket
    case FontAwesomeMaxcdn
    case FontAwesomeChevronCircleLeft
    case FontAwesomeChevronCircleRight
    case FontAwesomeChevronCircleUp
    case FontAwesomeChevronCircleDown
    case FontAwesomeHtml5
    case FontAwesomeCss3
    case FontAwesomeAnchor
    case FontAwesomeUnlockAlt
    case FontAwesomeBullseye
    case FontAwesomeEllipsisH
    case FontAwesomeEllipsisV
    case FontAwesomeRssSquare
    case FontAwesomePlayCircle
    case FontAwesomeTicket
    case FontAwesomeMinusSquare
    case FontAwesomeMinusSquareO
    case FontAwesomeLevelUp
    case FontAwesomeLevelDown
    case FontAwesomeCheckSquare
    case FontAwesomePencilSquare
    case FontAwesomeExternalLinkSquare
    case FontAwesomeShareSquare
    case FontAwesomeCompass
    case FontAwesomeCaretSquareODown
    case FontAwesomeCaretSquareOUp
    case FontAwesomeCaretSquareORight
    case FontAwesomeEur
    case FontAwesomeGbp
    case FontAwesomeUsd
    case FontAwesomeInr
    case FontAwesomeJpy
    case FontAwesomeRub
    case FontAwesomeKrw
    case FontAwesomeBtc
    case FontAwesomeFile
    case FontAwesomeFileText
    case FontAwesomeSortAlphaAsc
    case FontAwesomeSortAlphaDesc
    case FontAwesomeSortAmountAsc
    case FontAwesomeSortAmountDesc
    case FontAwesomeSortNumericAsc
    case FontAwesomeSortNumericDesc
    case FontAwesomeThumbsUp
    case FontAwesomeThumbsDown
    case FontAwesomeYoutubeSquare
    case FontAwesomeYoutube
    case FontAwesomeXing
    case FontAwesomeXingSquare
    case FontAwesomeYoutubePlay
    case FontAwesomeDropbox
    case FontAwesomeStackOverflow
    case FontAwesomeInstagram
    case FontAwesomeFlickr
    case FontAwesomeAdn
    case FontAwesomeBitbucket
    case FontAwesomeBitbucketSquare
    case FontAwesomeTumblr
    case FontAwesomeTumblrSquare
    case FontAwesomeLongArrowDown
    case FontAwesomeLongArrowUp
    case FontAwesomeLongArrowLeft
    case FontAwesomeLongArrowRight
    case FontAwesomeApple
    case FontAwesomeWindows
    case FontAwesomeAndroid
    case FontAwesomeLinux
    case FontAwesomeDribbble
    case FontAwesomeSkype
    case FontAwesomeFoursquare
    case FontAwesomeTrello
    case FontAwesomeFemale
    case FontAwesomeMale
    case FontAwesomeGittip
    case FontAwesomeSunO
    case FontAwesomeMoonO
    case FontAwesomeArchive
    case FontAwesomeBug
    case FontAwesomeVk
    case FontAwesomeWeibo
    case FontAwesomeRenren
    case FontAwesomePagelines
    case FontAwesomeStackExchange
    case FontAwesomeArrowCircleORight
    case FontAwesomeArrowCircleOLeft
    case FontAwesomeCaretSquareOLeft
    case FontAwesomeDotCircleO
    case FontAwesomeWheelchair
    case FontAwesomeVimeoSquare
    case FontAwesomeTry
    case FontAwesomePlusSquareO
    
    /* FontAwesome ver 4.1.0 */
    case FontAwesomeautomobile
    case FontAwesomebank
    case FontAwesomebehance
    case FontAwesomebehanceSquare
    case FontAwesomebomb
    case FontAwesomebuilding
    case FontAwesomecab
    case FontAwesomecar
    case FontAwesomechild
    case FontAwesomecircleONotch
    case FontAwesomecircleThin
    case FontAwesomecodepen
    case FontAwesomecube
    case FontAwesomecubes
    case FontAwesomedatabase
    case FontAwesomedelicious
    case FontAwesomedeviantart
    case FontAwesomedigg
    case FontAwesomedrupal
    case FontAwesomeempire
    case FontAwesomeenvelopeSquare
    case FontAwesomefax
    case FontAwesomefileArchiveO
    case FontAwesomefileAudioO
    case FontAwesomefileCodeO
    case FontAwesomefileExcelO
    case FontAwesomefileImageO
    case FontAwesomefileMovieO
    case FontAwesomefilePdfO
    case FontAwesomefilePhotoO
    case FontAwesomefilePictureO
    case FontAwesomefilePowerpointO
    case FontAwesomefileSoundO
    case FontAwesomefileVideoO
    case FontAwesomefileWordO
    case FontAwesomefileZipO
    case FontAwesomege
    case FontAwesomegit
    case FontAwesomegitSquare
    case FontAwesomegoogle
    case FontAwesomegraduationCap
    case FontAwesomehackerNews
    case FontAwesomeheader
    case FontAwesomehistory
    case FontAwesomeinstitution
    case FontAwesomejoomla
    case FontAwesomejsfiddle
    case FontAwesomelanguage
    case FontAwesomelifeBouy
    case FontAwesomelifeRing
    case FontAwesomelifeSaver
    case FontAwesomemortarBoard
    case FontAwesomeopenid
    case FontAwesomepaperPlane
    case FontAwesomepaperPlaneO
    case FontAwesomeparagraph
    case FontAwesomepaw
    case FontAwesomepiedPiper
    case FontAwesomepiedPiperalt
    case FontAwesomepiedPipersquare
    case FontAwesomeqq
    case FontAwesomera
    case FontAwesomerebel
    case FontAwesomerecycle
    case FontAwesomereddit
    case FontAwesomeredditSquare
    case FontAwesomesend
    case FontAwesomesendO
    case FontAwesomeshareAlt
    case FontAwesomeshareAltSquare
    case FontAwesomeslack
    case FontAwesomesliders
    case FontAwesomesoundcloud
    case FontAwesomespaceShuttle
    case FontAwesomespoon
    case FontAwesomespotify
    case FontAwesomesteam
    case FontAwesomesteamSquare
    case FontAwesomestumbleupon
    case FontAwesomestumbleuponCircle
    case FontAwesomesupport
    case FontAwesometaxi
    case FontAwesometencentWeibo
    case FontAwesometree
    case FontAwesomeuniversity
    case FontAwesomevine
    case FontAwesomewechat
    case FontAwesomeweixin
    case FontAwesomewordpress
    case FontAwesomeyahoo
    
    /* FontAwesome ver 4.2.0 */
    case FontAwesomeangellist
    case FontAwesomeareaChart
    case FontAwesomeat
    case FontAwesomebellSlash
    case FontAwesomebellSlashO
    case FontAwesomebicycle
    case FontAwesomebinoculars
    case FontAwesomebirthdayCake
    case FontAwesomebus
    case FontAwesomecalculator
    case FontAwesomecc
    case FontAwesomeccAmex
    case FontAwesomeccDiscover
    case FontAwesomeccMastercard
    case FontAwesomeccPaypal
    case FontAwesomeccStripe
    case FontAwesomeccVisa
    case FontAwesomecopyright
    case FontAwesomeeyedropper
    case FontAwesomefutbolO
    case FontAwesomegoogleWallet
    case FontAwesomeils
    case FontAwesomeioxhost
    case FontAwesomelastfm
    case FontAwesomelastfmSquare
    case FontAwesomelineChart
    case FontAwesomemeanpath
    case FontAwesomenewspaperO
    case FontAwesomepaintBrush
    case FontAwesomepaypal
    case FontAwesomepieChart
    case FontAwesomeplug
    case FontAwesomeshekel
    case FontAwesomesheqel
    case FontAwesomeslideshare
    case FontAwesomesoccerBallO
    case FontAwesometoggleOff
    case FontAwesometoggleOn
    case FontAwesometrash
    case FontAwesometty
    case FontAwesometwitch
    case FontAwesomewifi
    case FontAwesomeyelp
    
    /* FontAwesome ver 4.3.0 */
    case FontAwesomebed
    case FontAwesomebuysellads
    case FontAwesomecartArrowDown
    case FontAwesomecartPlus
    case FontAwesomeconnectdevelop
    case FontAwesomedashcube
    case FontAwesomediamond
    case FontAwesomefacebookOfficial
    case FontAwesomeforumbee
    case FontAwesomeheartbeat
    case FontAwesomehotel
    case FontAwesomeleanpub
    case FontAwesomemars
    case FontAwesomemarsDouble
    case FontAwesomemarsStroke
    case FontAwesomemarsStrokeH
    case FontAwesomemarsStrokeV
    case FontAwesomemedium
    case FontAwesomemercury
    case FontAwesomemotorcycle
    case FontAwesomeneuter
    case FontAwesomepinterestP
    case FontAwesomesellsy
    case FontAwesomeserver
    case FontAwesomeship
    case FontAwesomeshirtsinbulk
    case FontAwesomesimplybuilt
    case FontAwesomeskyatlas
    case FontAwesomestreetView
    case FontAwesomesubway
    case FontAwesometrain
    case FontAwesometransgender
    case FontAwesometransgenderAlt
    case FontAwesomeuserPlus
    case FontAwesomeuserSecret
    case FontAwesomeuserTimes
    case FontAwesomevenus
    case FontAwesomevenusDouble
    case FontAwesomevenusMars
    case FontAwesomeviacoin
}

public extension String {

    private static var staticDictFontAwesome : Dictionary<String, enumFontAwesomeIcon> {
        return [
            "fa-glass" : enumFontAwesomeIcon.FontAwesomeGlass,
            "fa-music" : enumFontAwesomeIcon.FontAwesomeMusic,
            "fa-search" : enumFontAwesomeIcon.FontAwesomeSearch,
            "fa-envelope-o" : enumFontAwesomeIcon.FontAwesomeEnvelopeO,
            "fa-heart" : enumFontAwesomeIcon.FontAwesomeHeart,
            "fa-star" : enumFontAwesomeIcon.FontAwesomeStar,
            "fa-star-o" : enumFontAwesomeIcon.FontAwesomeStarO,
            "fa-user" : enumFontAwesomeIcon.FontAwesomeUser,
            "fa-film" : enumFontAwesomeIcon.FontAwesomeFilm,
            "fa-th-large" : enumFontAwesomeIcon.FontAwesomeThLarge,
            "fa-th" : enumFontAwesomeIcon.FontAwesomeTh,
            "fa-th-list" : enumFontAwesomeIcon.FontAwesomeThList,
            "fa-check" : enumFontAwesomeIcon.FontAwesomeCheck,
            "fa-times" : enumFontAwesomeIcon.FontAwesomeTimes,
            "fa-search-plus" : enumFontAwesomeIcon.FontAwesomeSearchPlus,
            "fa-search-minus" : enumFontAwesomeIcon.FontAwesomeSearchMinus,
            "fa-power-off" : enumFontAwesomeIcon.FontAwesomePowerOff,
            "fa-signal" : enumFontAwesomeIcon.FontAwesomeSignal,
            "fa-cog" : enumFontAwesomeIcon.FontAwesomeCog,
            "fa-trash-o" : enumFontAwesomeIcon.FontAwesomeTrashO,
            "fa-home" : enumFontAwesomeIcon.FontAwesomeHome,
            "fa-file-o" : enumFontAwesomeIcon.FontAwesomeFileO,
            "fa-clock-o" : enumFontAwesomeIcon.FontAwesomeClockO,
            "fa-road" : enumFontAwesomeIcon.FontAwesomeRoad,
            "fa-download" : enumFontAwesomeIcon.FontAwesomeDownload,
            "fa-arrow-circle-o-down" : enumFontAwesomeIcon.FontAwesomeArrowCircleODown,
            "fa-arrow-circle-o-up" : enumFontAwesomeIcon.FontAwesomeArrowCircleOUp,
            "fa-inbox" : enumFontAwesomeIcon.FontAwesomeInbox,
            "fa-play-circle-o" : enumFontAwesomeIcon.FontAwesomePlayCircleO,
            "fa-repeat" : enumFontAwesomeIcon.FontAwesomeRepeat,
            "fa-refresh" : enumFontAwesomeIcon.FontAwesomeRefresh,
            "fa-list-alt" : enumFontAwesomeIcon.FontAwesomeListAlt,
            "fa-lock" : enumFontAwesomeIcon.FontAwesomeLock,
            "fa-flag" : enumFontAwesomeIcon.FontAwesomeFlag,
            "fa-headphones" : enumFontAwesomeIcon.FontAwesomeHeadphones,
            "fa-volume-off" : enumFontAwesomeIcon.FontAwesomeVolumeOff,
            "fa-volume-down" : enumFontAwesomeIcon.FontAwesomeVolumeDown,
            "fa-volume-up" : enumFontAwesomeIcon.FontAwesomeVolumeUp,
            "fa-qrcode" : enumFontAwesomeIcon.FontAwesomeQrcode,
            "fa-barcode" : enumFontAwesomeIcon.FontAwesomeBarcode,
            "fa-tag" : enumFontAwesomeIcon.FontAwesomeTag,
            "fa-tags" : enumFontAwesomeIcon.FontAwesomeTags,
            "fa-book" : enumFontAwesomeIcon.FontAwesomeBook,
            "fa-bookmark" : enumFontAwesomeIcon.FontAwesomeBookmark,
            "fa-print" : enumFontAwesomeIcon.FontAwesomePrint,
            "fa-camera" : enumFontAwesomeIcon.FontAwesomeCamera,
            "fa-font" : enumFontAwesomeIcon.FontAwesomeFont,
            "fa-bold" : enumFontAwesomeIcon.FontAwesomeBold,
            "fa-italic" : enumFontAwesomeIcon.FontAwesomeItalic,
            "fa-text-height" : enumFontAwesomeIcon.FontAwesomeTextHeight,
            "fa-text-width" : enumFontAwesomeIcon.FontAwesomeTextWidth,
            "fa-align-left" : enumFontAwesomeIcon.FontAwesomeAlignLeft,
            "fa-align-center" : enumFontAwesomeIcon.FontAwesomeAlignCenter,
            "fa-align-right" : enumFontAwesomeIcon.FontAwesomeAlignRight,
            "fa-align-justify" : enumFontAwesomeIcon.FontAwesomeAlignJustify,
            "fa-list" : enumFontAwesomeIcon.FontAwesomeList,
            "fa-outdent" : enumFontAwesomeIcon.FontAwesomeOutdent,
            "fa-indent" : enumFontAwesomeIcon.FontAwesomeIndent,
            "fa-video-camera" : enumFontAwesomeIcon.FontAwesomeVideoCamera,
            "fa-picture-o" : enumFontAwesomeIcon.FontAwesomePictureO,
            "fa-pencil" : enumFontAwesomeIcon.FontAwesomePencil,
            "fa-map-marker" : enumFontAwesomeIcon.FontAwesomeMapMarker,
            "fa-adjust" : enumFontAwesomeIcon.FontAwesomeAdjust,
            "fa-tint" : enumFontAwesomeIcon.FontAwesomeTint,
            "fa-pencil-square-o" : enumFontAwesomeIcon.FontAwesomePencilSquareO,
            "fa-share-square-o" : enumFontAwesomeIcon.FontAwesomeShareSquareO,
            "fa-check-square-o" : enumFontAwesomeIcon.FontAwesomeCheckSquareO,
            "fa-arrows" : enumFontAwesomeIcon.FontAwesomeArrows,
            "fa-step-backward" : enumFontAwesomeIcon.FontAwesomeStepBackward,
            "fa-fast-backward" : enumFontAwesomeIcon.FontAwesomeFastBackward,
            "fa-backward" : enumFontAwesomeIcon.FontAwesomeBackward,
            "fa-play" : enumFontAwesomeIcon.FontAwesomePlay,
            "fa-pause" : enumFontAwesomeIcon.FontAwesomePause,
            "fa-stop" : enumFontAwesomeIcon.FontAwesomeStop,
            "fa-forward" : enumFontAwesomeIcon.FontAwesomeForward,
            "fa-fast-forward" : enumFontAwesomeIcon.FontAwesomeFastForward,
            "fa-step-forward" : enumFontAwesomeIcon.FontAwesomeStepForward,
            "fa-eject" : enumFontAwesomeIcon.FontAwesomeEject,
            "fa-chevron-left" : enumFontAwesomeIcon.FontAwesomeChevronLeft,
            "fa-chevron-right" : enumFontAwesomeIcon.FontAwesomeChevronRight,
            "fa-plus-circle" : enumFontAwesomeIcon.FontAwesomePlusCircle,
            "fa-minus-circle" : enumFontAwesomeIcon.FontAwesomeMinusCircle,
            "fa-times-circle" : enumFontAwesomeIcon.FontAwesomeTimesCircle,
            "fa-check-circle" : enumFontAwesomeIcon.FontAwesomeCheckCircle,
            "fa-question-circle" : enumFontAwesomeIcon.FontAwesomeQuestionCircle,
            "fa-info-circle" : enumFontAwesomeIcon.FontAwesomeInfoCircle,
            "fa-crosshairs" : enumFontAwesomeIcon.FontAwesomeCrosshairs,
            "fa-times-circle-o" : enumFontAwesomeIcon.FontAwesomeTimesCircleO,
            "fa-check-circle-o" : enumFontAwesomeIcon.FontAwesomeCheckCircleO,
            "fa-ban" : enumFontAwesomeIcon.FontAwesomeBan,
            "fa-arrow-left" : enumFontAwesomeIcon.FontAwesomeArrowLeft,
            "fa-arrow-right" : enumFontAwesomeIcon.FontAwesomeArrowRight,
            "fa-arrow-up" : enumFontAwesomeIcon.FontAwesomeArrowUp,
            "fa-arrow-down" : enumFontAwesomeIcon.FontAwesomeArrowDown,
            "fa-share" : enumFontAwesomeIcon.FontAwesomeShare,
            "fa-expand" : enumFontAwesomeIcon.FontAwesomeExpand,
            "fa-compress" : enumFontAwesomeIcon.FontAwesomeCompress,
            "fa-plus" : enumFontAwesomeIcon.FontAwesomePlus,
            "fa-minus" : enumFontAwesomeIcon.FontAwesomeMinus,
            "fa-asterisk" : enumFontAwesomeIcon.FontAwesomeAsterisk,
            "fa-exclamation-circle" : enumFontAwesomeIcon.FontAwesomeExclamationCircle,
            "fa-gift" : enumFontAwesomeIcon.FontAwesomeGift,
            "fa-leaf" : enumFontAwesomeIcon.FontAwesomeLeaf,
            "fa-fire" : enumFontAwesomeIcon.FontAwesomeFire,
            "fa-eye" : enumFontAwesomeIcon.FontAwesomeEye,
            "fa-eye-slash" : enumFontAwesomeIcon.FontAwesomeEyeSlash,
            "fa-exclamation-triangle" : enumFontAwesomeIcon.FontAwesomeExclamationTriangle,
            "fa-plane" : enumFontAwesomeIcon.FontAwesomePlane,
            "fa-calendar" : enumFontAwesomeIcon.FontAwesomeCalendar,
            "fa-random" : enumFontAwesomeIcon.FontAwesomeRandom,
            "fa-comment" : enumFontAwesomeIcon.FontAwesomeComment,
            "fa-magnet" : enumFontAwesomeIcon.FontAwesomeMagnet,
            "fa-chevron-up" : enumFontAwesomeIcon.FontAwesomeChevronUp,
            "fa-chevron-down" : enumFontAwesomeIcon.FontAwesomeChevronDown,
            "fa-retweet" : enumFontAwesomeIcon.FontAwesomeRetweet,
            "fa-shopping-cart" : enumFontAwesomeIcon.FontAwesomeShoppingCart,
            "fa-folder" : enumFontAwesomeIcon.FontAwesomeFolder,
            "fa-folder-open" : enumFontAwesomeIcon.FontAwesomeFolderOpen,
            "fa-arrows-v" : enumFontAwesomeIcon.FontAwesomeArrowsV,
            "fa-arrows-h" : enumFontAwesomeIcon.FontAwesomeArrowsH,
            "fa-bar-chart-o" : enumFontAwesomeIcon.FontAwesomeBarChartO,
            "fa-twitter-square" : enumFontAwesomeIcon.FontAwesomeTwitterSquare,
            "fa-facebook-square" : enumFontAwesomeIcon.FontAwesomeFacebookSquare,
            "fa-camera-retro" : enumFontAwesomeIcon.FontAwesomeCameraRetro,
            "fa-key" : enumFontAwesomeIcon.FontAwesomeKey,
            "fa-cogs" : enumFontAwesomeIcon.FontAwesomeCogs,
            "fa-comments" : enumFontAwesomeIcon.FontAwesomeComments,
            "fa-thumbs-o-up" : enumFontAwesomeIcon.FontAwesomeThumbsOUp,
            "fa-thumbs-o-down" : enumFontAwesomeIcon.FontAwesomeThumbsODown,
            "fa-star-half" : enumFontAwesomeIcon.FontAwesomeStarHalf,
            "fa-heart-o" : enumFontAwesomeIcon.FontAwesomeHeartO,
            "fa-sign-out" : enumFontAwesomeIcon.FontAwesomeSignOut,
            "fa-linkedin-square" : enumFontAwesomeIcon.FontAwesomeLinkedinSquare,
            "fa-thumb-tack" : enumFontAwesomeIcon.FontAwesomeThumbTack,
            "fa-external-link" : enumFontAwesomeIcon.FontAwesomeExternalLink,
            "fa-sign-in" : enumFontAwesomeIcon.FontAwesomeSignIn,
            "fa-trophy" : enumFontAwesomeIcon.FontAwesomeTrophy,
            "fa-github-square" : enumFontAwesomeIcon.FontAwesomeGithubSquare,
            "fa-upload" : enumFontAwesomeIcon.FontAwesomeUpload,
            "fa-lemon-o" : enumFontAwesomeIcon.FontAwesomeLemonO,
            "fa-phone" : enumFontAwesomeIcon.FontAwesomePhone,
            "fa-square-o" : enumFontAwesomeIcon.FontAwesomeSquareO,
            "fa-bookmark-o" : enumFontAwesomeIcon.FontAwesomeBookmarkO,
            "fa-phone-square" : enumFontAwesomeIcon.FontAwesomePhoneSquare,
            "fa-twitter" : enumFontAwesomeIcon.FontAwesomeTwitter,
            "fa-facebook" : enumFontAwesomeIcon.FontAwesomeFacebook,
            "fa-github" : enumFontAwesomeIcon.FontAwesomeGithub,
            "fa-unlock" : enumFontAwesomeIcon.FontAwesomeUnlock,
            "fa-credit-card" : enumFontAwesomeIcon.FontAwesomeCreditCard,
            "fa-rss" : enumFontAwesomeIcon.FontAwesomeRss,
            "fa-hdd-o" : enumFontAwesomeIcon.FontAwesomeHddO,
            "fa-bullhorn" : enumFontAwesomeIcon.FontAwesomeBullhorn,
            "fa-bell" : enumFontAwesomeIcon.FontAwesomeBell,
            "fa-certificate" : enumFontAwesomeIcon.FontAwesomeCertificate,
            "fa-hand-o-right" : enumFontAwesomeIcon.FontAwesomeHandORight,
            "fa-hand-o-left" : enumFontAwesomeIcon.FontAwesomeHandOLeft,
            "fa-hand-o-up" : enumFontAwesomeIcon.FontAwesomeHandOUp,
            "fa-hand-o-down" : enumFontAwesomeIcon.FontAwesomeHandODown,
            "fa-arrow-circle-left" : enumFontAwesomeIcon.FontAwesomeArrowCircleLeft,
            "fa-arrow-circle-right" : enumFontAwesomeIcon.FontAwesomeArrowCircleRight,
            "fa-arrow-circle-up" : enumFontAwesomeIcon.FontAwesomeArrowCircleUp,
            "fa-arrow-circle-down" : enumFontAwesomeIcon.FontAwesomeArrowCircleDown,
            "fa-globe" : enumFontAwesomeIcon.FontAwesomeGlobe,
            "fa-wrench" : enumFontAwesomeIcon.FontAwesomeWrench,
            "fa-tasks" : enumFontAwesomeIcon.FontAwesomeTasks,
            "fa-filter" : enumFontAwesomeIcon.FontAwesomeFilter,
            "fa-briefcase" : enumFontAwesomeIcon.FontAwesomeBriefcase,
            "fa-arrows-alt" : enumFontAwesomeIcon.FontAwesomeArrowsAlt,
            "fa-users" : enumFontAwesomeIcon.FontAwesomeUsers,
            "fa-link" : enumFontAwesomeIcon.FontAwesomeLink,
            "fa-cloud" : enumFontAwesomeIcon.FontAwesomeCloud,
            "fa-flask" : enumFontAwesomeIcon.FontAwesomeFlask,
            "fa-scissors" : enumFontAwesomeIcon.FontAwesomeScissors,
            "fa-files-o" : enumFontAwesomeIcon.FontAwesomeFilesO,
            "fa-paperclip" : enumFontAwesomeIcon.FontAwesomePaperclip,
            "fa-floppy-o" : enumFontAwesomeIcon.FontAwesomeFloppyO,
            "fa-square" : enumFontAwesomeIcon.FontAwesomeSquare,
            "fa-bars" : enumFontAwesomeIcon.FontAwesomeBars,
            "fa-list-ul" : enumFontAwesomeIcon.FontAwesomeListUl,
            "fa-list-ol" : enumFontAwesomeIcon.FontAwesomeListOl,
            "fa-strikethrough" : enumFontAwesomeIcon.FontAwesomeStrikethrough,
            "fa-underline" : enumFontAwesomeIcon.FontAwesomeUnderline,
            "fa-table" : enumFontAwesomeIcon.FontAwesomeTable,
            "fa-magic" : enumFontAwesomeIcon.FontAwesomeMagic,
            "fa-truck" : enumFontAwesomeIcon.FontAwesomeTruck,
            "fa-pinterest" : enumFontAwesomeIcon.FontAwesomePinterest,
            "fa-pinterest-square" : enumFontAwesomeIcon.FontAwesomePinterestSquare,
            "fa-google-plus-square" : enumFontAwesomeIcon.FontAwesomeGooglePlusSquare,
            "fa-google-plus" : enumFontAwesomeIcon.FontAwesomeGooglePlus,
            "fa-money" : enumFontAwesomeIcon.FontAwesomeMoney,
            "fa-caret-down" : enumFontAwesomeIcon.FontAwesomeCaretDown,
            "fa-caret-up" : enumFontAwesomeIcon.FontAwesomeCaretUp,
            "fa-caret-left" : enumFontAwesomeIcon.FontAwesomeCaretLeft,
            "fa-caret-right" : enumFontAwesomeIcon.FontAwesomeCaretRight,
            "fa-columns" : enumFontAwesomeIcon.FontAwesomeColumns,
            "fa-sort" : enumFontAwesomeIcon.FontAwesomeSort,
            "fa-sort-asc" : enumFontAwesomeIcon.FontAwesomeSortAsc,
            "fa-sort-desc" : enumFontAwesomeIcon.FontAwesomeSortDesc,
            "fa-envelope" : enumFontAwesomeIcon.FontAwesomeEnvelope,
            "fa-linkedin" : enumFontAwesomeIcon.FontAwesomeLinkedin,
            "fa-undo" : enumFontAwesomeIcon.FontAwesomeUndo,
            "fa-gavel" : enumFontAwesomeIcon.FontAwesomeGavel,
            "fa-tachometer" : enumFontAwesomeIcon.FontAwesomeTachometer,
            "fa-comment-o" : enumFontAwesomeIcon.FontAwesomeCommentO,
            "fa-comments-o" : enumFontAwesomeIcon.FontAwesomeCommentsO,
            "fa-bolt" : enumFontAwesomeIcon.FontAwesomeBolt,
            "fa-sitemap" : enumFontAwesomeIcon.FontAwesomeSitemap,
            "fa-umbrella" : enumFontAwesomeIcon.FontAwesomeUmbrella,
            "fa-clipboard" : enumFontAwesomeIcon.FontAwesomeClipboard,
            "fa-lightbulb-o" : enumFontAwesomeIcon.FontAwesomeLightbulbO,
            "fa-exchange" : enumFontAwesomeIcon.FontAwesomeExchange,
            "fa-cloud-download" : enumFontAwesomeIcon.FontAwesomeCloudDownload,
            "fa-cloud-upload" : enumFontAwesomeIcon.FontAwesomeCloudUpload,
            "fa-user-md" : enumFontAwesomeIcon.FontAwesomeUserMd,
            "fa-stethoscope" : enumFontAwesomeIcon.FontAwesomeStethoscope,
            "fa-suitcase" : enumFontAwesomeIcon.FontAwesomeSuitcase,
            "fa-bell-o" : enumFontAwesomeIcon.FontAwesomeBellO,
            "fa-coffee" : enumFontAwesomeIcon.FontAwesomeCoffee,
            "fa-cutlery" : enumFontAwesomeIcon.FontAwesomeCutlery,
            "fa-file-text-o" : enumFontAwesomeIcon.FontAwesomeFileTextO,
            "fa-building-o" : enumFontAwesomeIcon.FontAwesomeBuildingO,
            "fa-hospital-o" : enumFontAwesomeIcon.FontAwesomeHospitalO,
            "fa-ambulance" : enumFontAwesomeIcon.FontAwesomeAmbulance,
            "fa-medkit" : enumFontAwesomeIcon.FontAwesomeMedkit,
            "fa-fighter-jet" : enumFontAwesomeIcon.FontAwesomeFighterJet,
            "fa-beer" : enumFontAwesomeIcon.FontAwesomeBeer,
            "fa-h-square" : enumFontAwesomeIcon.FontAwesomeHSquare,
            "fa-plus-square" : enumFontAwesomeIcon.FontAwesomePlusSquare,
            "fa-angle-double-left" : enumFontAwesomeIcon.FontAwesomeAngleDoubleLeft,
            "fa-angle-double-right" : enumFontAwesomeIcon.FontAwesomeAngleDoubleRight,
            "fa-angle-double-up" : enumFontAwesomeIcon.FontAwesomeAngleDoubleUp,
            "fa-angle-double-down" : enumFontAwesomeIcon.FontAwesomeAngleDoubleDown,
            "fa-angle-left" : enumFontAwesomeIcon.FontAwesomeAngleLeft,
            "fa-angle-right" : enumFontAwesomeIcon.FontAwesomeAngleRight,
            "fa-angle-up" : enumFontAwesomeIcon.FontAwesomeAngleUp,
            "fa-angle-down" : enumFontAwesomeIcon.FontAwesomeAngleDown,
            "fa-desktop" : enumFontAwesomeIcon.FontAwesomeDesktop,
            "fa-laptop" : enumFontAwesomeIcon.FontAwesomeLaptop,
            "fa-tablet" : enumFontAwesomeIcon.FontAwesomeTablet,
            "fa-mobile" : enumFontAwesomeIcon.FontAwesomeMobile,
            "fa-circle-o" : enumFontAwesomeIcon.FontAwesomeCircleO,
            "fa-quote-left" : enumFontAwesomeIcon.FontAwesomeQuoteLeft,
            "fa-quote-right" : enumFontAwesomeIcon.FontAwesomeQuoteRight,
            "fa-spinner" : enumFontAwesomeIcon.FontAwesomeSpinner,
            "fa-circle" : enumFontAwesomeIcon.FontAwesomeCircle,
            "fa-reply" : enumFontAwesomeIcon.FontAwesomeReply,
            "fa-github-alt" : enumFontAwesomeIcon.FontAwesomeGithubAlt,
            "fa-folder-o" : enumFontAwesomeIcon.FontAwesomeFolderO,
            "fa-folder-open-o" : enumFontAwesomeIcon.FontAwesomeFolderOpenO,
            "fa-smile-o" : enumFontAwesomeIcon.FontAwesomeSmileO,
            "fa-frown-o" : enumFontAwesomeIcon.FontAwesomeFrownO,
            "fa-meh-o" : enumFontAwesomeIcon.FontAwesomeMehO,
            "fa-gamepad" : enumFontAwesomeIcon.FontAwesomeGamepad,
            "fa-keyboard-o" : enumFontAwesomeIcon.FontAwesomeKeyboardO,
            "fa-flag-o" : enumFontAwesomeIcon.FontAwesomeFlagO,
            "fa-flag-checkered" : enumFontAwesomeIcon.FontAwesomeFlagCheckered,
            "fa-terminal" : enumFontAwesomeIcon.FontAwesomeTerminal,
            "fa-code" : enumFontAwesomeIcon.FontAwesomeCode,
            "fa-reply-all" : enumFontAwesomeIcon.FontAwesomeReplyAll,
            "fa-mail-reply-all" : enumFontAwesomeIcon.FontAwesomeMailReplyAll,
            "fa-star-half-o" : enumFontAwesomeIcon.FontAwesomeStarHalfO,
            "fa-location-arrow" : enumFontAwesomeIcon.FontAwesomeLocationArrow,
            "fa-crop" : enumFontAwesomeIcon.FontAwesomeCrop,
            "fa-code-fork" : enumFontAwesomeIcon.FontAwesomeCodeFork,
            "fa-chain-broken" : enumFontAwesomeIcon.FontAwesomeChainBroken,
            "fa-question" : enumFontAwesomeIcon.FontAwesomeQuestion,
            "fa-info" : enumFontAwesomeIcon.FontAwesomeInfo,
            "fa-exclamation" : enumFontAwesomeIcon.FontAwesomeExclamation,
            "fa-superscript" : enumFontAwesomeIcon.FontAwesomeSuperscript,
            "fa-subscript" : enumFontAwesomeIcon.FontAwesomeSubscript,
            "fa-eraser" : enumFontAwesomeIcon.FontAwesomeEraser,
            "fa-puzzle-piece" : enumFontAwesomeIcon.FontAwesomePuzzlePiece,
            "fa-microphone" : enumFontAwesomeIcon.FontAwesomeMicrophone,
            "fa-microphone-slash" : enumFontAwesomeIcon.FontAwesomeMicrophoneSlash,
            "fa-shield" : enumFontAwesomeIcon.FontAwesomeShield,
            "fa-calendar-o" : enumFontAwesomeIcon.FontAwesomeCalendarO,
            "fa-fire-extinguisher" : enumFontAwesomeIcon.FontAwesomeFireExtinguisher,
            "fa-rocket" : enumFontAwesomeIcon.FontAwesomeRocket,
            "fa-maxcdn" : enumFontAwesomeIcon.FontAwesomeMaxcdn,
            "fa-chevron-circle-left" : enumFontAwesomeIcon.FontAwesomeChevronCircleLeft,
            "fa-chevron-circle-right" : enumFontAwesomeIcon.FontAwesomeChevronCircleRight,
            "fa-chevron-circle-up" : enumFontAwesomeIcon.FontAwesomeChevronCircleUp,
            "fa-chevron-circle-down" : enumFontAwesomeIcon.FontAwesomeChevronCircleDown,
            "fa-html5" : enumFontAwesomeIcon.FontAwesomeHtml5,
            "fa-css3" : enumFontAwesomeIcon.FontAwesomeCss3,
            "fa-anchor" : enumFontAwesomeIcon.FontAwesomeAnchor,
            "fa-unlock-alt" : enumFontAwesomeIcon.FontAwesomeUnlockAlt,
            "fa-bullseye" : enumFontAwesomeIcon.FontAwesomeBullseye,
            "fa-ellipsis-h" : enumFontAwesomeIcon.FontAwesomeEllipsisH,
            "fa-ellipsis-v" : enumFontAwesomeIcon.FontAwesomeEllipsisV,
            "fa-rss-square" : enumFontAwesomeIcon.FontAwesomeRssSquare,
            "fa-play-circle" : enumFontAwesomeIcon.FontAwesomePlayCircle,
            "fa-ticket" : enumFontAwesomeIcon.FontAwesomeTicket,
            "fa-minus-square" : enumFontAwesomeIcon.FontAwesomeMinusSquare,
            "fa-minus-square-o" : enumFontAwesomeIcon.FontAwesomeMinusSquareO,
            "fa-level-up" : enumFontAwesomeIcon.FontAwesomeLevelUp,
            "fa-level-down" : enumFontAwesomeIcon.FontAwesomeLevelDown,
            "fa-check-square" : enumFontAwesomeIcon.FontAwesomeCheckSquare,
            "fa-pencil-square" : enumFontAwesomeIcon.FontAwesomePencilSquare,
            "fa-external-link-square" : enumFontAwesomeIcon.FontAwesomeExternalLinkSquare,
            "fa-share-square" : enumFontAwesomeIcon.FontAwesomeShareSquare,
            "fa-compass" : enumFontAwesomeIcon.FontAwesomeCompass,
            "fa-caret-square-o-down" : enumFontAwesomeIcon.FontAwesomeCaretSquareODown,
            "fa-caret-square-o-up" : enumFontAwesomeIcon.FontAwesomeCaretSquareOUp,
            "fa-caret-square-o-right" : enumFontAwesomeIcon.FontAwesomeCaretSquareORight,
            "fa-eur" : enumFontAwesomeIcon.FontAwesomeEur,
            "fa-gbp" : enumFontAwesomeIcon.FontAwesomeGbp,
            "fa-usd" : enumFontAwesomeIcon.FontAwesomeUsd,
            "fa-inr" : enumFontAwesomeIcon.FontAwesomeInr,
            "fa-jpy" : enumFontAwesomeIcon.FontAwesomeJpy,
            "fa-rub" : enumFontAwesomeIcon.FontAwesomeRub,
            "fa-krw" : enumFontAwesomeIcon.FontAwesomeKrw,
            "fa-btc" : enumFontAwesomeIcon.FontAwesomeBtc,
            "fa-file" : enumFontAwesomeIcon.FontAwesomeFile,
            "fa-file-text" : enumFontAwesomeIcon.FontAwesomeFileText,
            "fa-sort-alpha-asc" : enumFontAwesomeIcon.FontAwesomeSortAlphaAsc,
            "fa-sort-alpha-desc" : enumFontAwesomeIcon.FontAwesomeSortAlphaDesc,
            "fa-sort-amount-asc" : enumFontAwesomeIcon.FontAwesomeSortAmountAsc,
            "fa-sort-amount-desc" : enumFontAwesomeIcon.FontAwesomeSortAmountDesc,
            "fa-sort-numeric-asc" : enumFontAwesomeIcon.FontAwesomeSortNumericAsc,
            "fa-sort-numeric-desc" : enumFontAwesomeIcon.FontAwesomeSortNumericDesc,
            "fa-thumbs-up" : enumFontAwesomeIcon.FontAwesomeThumbsUp,
            "fa-thumbs-down" : enumFontAwesomeIcon.FontAwesomeThumbsDown,
            "fa-youtube-square" : enumFontAwesomeIcon.FontAwesomeYoutubeSquare,
            "fa-youtube" : enumFontAwesomeIcon.FontAwesomeYoutube,
            "fa-xing" : enumFontAwesomeIcon.FontAwesomeXing,
            "fa-xing-square" : enumFontAwesomeIcon.FontAwesomeXingSquare,
            "fa-youtube-play" : enumFontAwesomeIcon.FontAwesomeYoutubePlay,
            "fa-dropbox" : enumFontAwesomeIcon.FontAwesomeDropbox,
            "fa-stack-overflow" : enumFontAwesomeIcon.FontAwesomeStackOverflow,
            "fa-instagram" : enumFontAwesomeIcon.FontAwesomeInstagram,
            "fa-flickr" : enumFontAwesomeIcon.FontAwesomeFlickr,
            "fa-adn" : enumFontAwesomeIcon.FontAwesomeAdn,
            "fa-bitbucket" : enumFontAwesomeIcon.FontAwesomeBitbucket,
            "fa-bitbucket-square" : enumFontAwesomeIcon.FontAwesomeBitbucketSquare,
            "fa-tumblr" : enumFontAwesomeIcon.FontAwesomeTumblr,
            "fa-tumblr-square" : enumFontAwesomeIcon.FontAwesomeTumblrSquare,
            "fa-long-arrow-down" : enumFontAwesomeIcon.FontAwesomeLongArrowDown,
            "fa-long-arrow-up" : enumFontAwesomeIcon.FontAwesomeLongArrowUp,
            "fa-long-arrow-left" : enumFontAwesomeIcon.FontAwesomeLongArrowLeft,
            "fa-long-arrow-right" : enumFontAwesomeIcon.FontAwesomeLongArrowRight,
            "fa-apple" : enumFontAwesomeIcon.FontAwesomeApple,
            "fa-windows" : enumFontAwesomeIcon.FontAwesomeWindows,
            "fa-android" : enumFontAwesomeIcon.FontAwesomeAndroid,
            "fa-linux" : enumFontAwesomeIcon.FontAwesomeLinux,
            "fa-dribbble" : enumFontAwesomeIcon.FontAwesomeDribbble,
            "fa-skype" : enumFontAwesomeIcon.FontAwesomeSkype,
            "fa-foursquare" : enumFontAwesomeIcon.FontAwesomeFoursquare,
            "fa-trello" : enumFontAwesomeIcon.FontAwesomeTrello,
            "fa-female" : enumFontAwesomeIcon.FontAwesomeFemale,
            "fa-male" : enumFontAwesomeIcon.FontAwesomeMale,
            "fa-gittip" : enumFontAwesomeIcon.FontAwesomeGittip,
            "fa-sun-o" : enumFontAwesomeIcon.FontAwesomeSunO,
            "fa-moon-o" : enumFontAwesomeIcon.FontAwesomeMoonO,
            "fa-archive" : enumFontAwesomeIcon.FontAwesomeArchive,
            "fa-bug" : enumFontAwesomeIcon.FontAwesomeBug,
            "fa-vk" : enumFontAwesomeIcon.FontAwesomeVk,
            "fa-weibo" : enumFontAwesomeIcon.FontAwesomeWeibo,
            "fa-renren" : enumFontAwesomeIcon.FontAwesomeRenren,
            "fa-pagelines" : enumFontAwesomeIcon.FontAwesomePagelines,
            "fa-stack-exchange" : enumFontAwesomeIcon.FontAwesomeStackExchange,
            "fa-arrow-circle-o-right" : enumFontAwesomeIcon.FontAwesomeArrowCircleORight,
            "fa-arrow-circle-o-left" : enumFontAwesomeIcon.FontAwesomeArrowCircleOLeft,
            "fa-caret-square-o-left" : enumFontAwesomeIcon.FontAwesomeCaretSquareOLeft,
            "fa-dot-circle-o" : enumFontAwesomeIcon.FontAwesomeDotCircleO,
            "fa-wheelchair" : enumFontAwesomeIcon.FontAwesomeWheelchair,
            "fa-vimeo-square" : enumFontAwesomeIcon.FontAwesomeVimeoSquare,
            "fa-try" : enumFontAwesomeIcon.FontAwesomeTry,
            "fa-plus-square-o" : enumFontAwesomeIcon.FontAwesomePlusSquareO,

            /* FontAwesome ver 4.1.0 */
            "fa-automobile" : enumFontAwesomeIcon.FontAwesomeautomobile,
            "fa-bank" : enumFontAwesomeIcon.FontAwesomebank,
            "fa-behance" : enumFontAwesomeIcon.FontAwesomebehance,
            "fa-behance-square" : enumFontAwesomeIcon.FontAwesomebehanceSquare,
            "fa-bomb" : enumFontAwesomeIcon.FontAwesomebomb,
            "fa-building" : enumFontAwesomeIcon.FontAwesomebuilding,
            "fa-cab" : enumFontAwesomeIcon.FontAwesomecab,
            "fa-car" : enumFontAwesomeIcon.FontAwesomecar,
            "fa-child" : enumFontAwesomeIcon.FontAwesomechild,
            "fa-circle-o-notch" : enumFontAwesomeIcon.FontAwesomecircleONotch,
            "fa-circle-thin" : enumFontAwesomeIcon.FontAwesomecircleThin,
            "fa-codepen" : enumFontAwesomeIcon.FontAwesomecodepen,
            "fa-cube" : enumFontAwesomeIcon.FontAwesomecube,
            "fa-cubes" : enumFontAwesomeIcon.FontAwesomecubes,
            "fa-database" : enumFontAwesomeIcon.FontAwesomedatabase,
            "fa-delicious" : enumFontAwesomeIcon.FontAwesomedelicious,
            "fa-deviantart" : enumFontAwesomeIcon.FontAwesomedeviantart,
            "fa-digg" : enumFontAwesomeIcon.FontAwesomedigg,
            "fa-drupal" : enumFontAwesomeIcon.FontAwesomedrupal,
            "fa-empire" : enumFontAwesomeIcon.FontAwesomeempire,
            "fa-envelope-square" : enumFontAwesomeIcon.FontAwesomeenvelopeSquare,
            "fa-fax" : enumFontAwesomeIcon.FontAwesomefax,
            "fa-file-archive-o" : enumFontAwesomeIcon.FontAwesomefileArchiveO,
            "fa-file-audio-o" : enumFontAwesomeIcon.FontAwesomefileAudioO,
            "fa-file-code-o" : enumFontAwesomeIcon.FontAwesomefileCodeO,
            "fa-file-excel-o" : enumFontAwesomeIcon.FontAwesomefileExcelO,
            "fa-file-image-o" : enumFontAwesomeIcon.FontAwesomefileImageO,
            "fa-file-movie-o" : enumFontAwesomeIcon.FontAwesomefileMovieO,
            "fa-file-pdf-o" : enumFontAwesomeIcon.FontAwesomefilePdfO,
            "fa-file-photo-o" : enumFontAwesomeIcon.FontAwesomefilePhotoO,
            "fa-file-picture-o" : enumFontAwesomeIcon.FontAwesomefilePictureO,
            "fa-file-powerpoint-o" : enumFontAwesomeIcon.FontAwesomefilePowerpointO,
            "fa-file-sound-o" : enumFontAwesomeIcon.FontAwesomefileSoundO,
            "fa-file-video-o" : enumFontAwesomeIcon.FontAwesomefileVideoO,
            "fa-file-word-o" : enumFontAwesomeIcon.FontAwesomefileWordO,
            "fa-file-zip-o" : enumFontAwesomeIcon.FontAwesomefileZipO,
            "fa-ge" : enumFontAwesomeIcon.FontAwesomege,
            "fa-git" : enumFontAwesomeIcon.FontAwesomegit,
            "fa-git-square" : enumFontAwesomeIcon.FontAwesomegitSquare,
            "fa-google" : enumFontAwesomeIcon.FontAwesomegoogle,
            "fa-graduation-cap" : enumFontAwesomeIcon.FontAwesomegraduationCap,
            "fa-hacker-news" : enumFontAwesomeIcon.FontAwesomehackerNews,
            "fa-header" : enumFontAwesomeIcon.FontAwesomeheader,
            "fa-history" : enumFontAwesomeIcon.FontAwesomehistory,
            "fa-institution" : enumFontAwesomeIcon.FontAwesomeinstitution,
            "fa-joomla" : enumFontAwesomeIcon.FontAwesomejoomla,
            "fa-jsfiddle" : enumFontAwesomeIcon.FontAwesomejsfiddle,
            "fa-language" : enumFontAwesomeIcon.FontAwesomelanguage,
            "fa-life-bouy" : enumFontAwesomeIcon.FontAwesomelifeBouy,
            "fa-life-ring" : enumFontAwesomeIcon.FontAwesomelifeRing,
            "fa-life-saver" : enumFontAwesomeIcon.FontAwesomelifeSaver,
            "fa-mortar-board" : enumFontAwesomeIcon.FontAwesomemortarBoard,
            "fa-openid" : enumFontAwesomeIcon.FontAwesomeopenid,
            "fa-paper-plane" : enumFontAwesomeIcon.FontAwesomepaperPlane,
            "fa-paper-plane-o" : enumFontAwesomeIcon.FontAwesomepaperPlaneO,
            "fa-paragraph" : enumFontAwesomeIcon.FontAwesomeparagraph,
            "fa-paw" : enumFontAwesomeIcon.FontAwesomepaw,
            "fa-pied-piper" : enumFontAwesomeIcon.FontAwesomepiedPiper,
            "fa-pied-piper-alt" : enumFontAwesomeIcon.FontAwesomepiedPiperalt,
            "fa-pied-piper-square" : enumFontAwesomeIcon.FontAwesomepiedPipersquare,
            "fa-qq" : enumFontAwesomeIcon.FontAwesomeqq,
            "fa-ra" : enumFontAwesomeIcon.FontAwesomera,
            "fa-rebel" : enumFontAwesomeIcon.FontAwesomerebel,
            "fa-recycle" : enumFontAwesomeIcon.FontAwesomerecycle,
            "fa-reddit" : enumFontAwesomeIcon.FontAwesomereddit,
            "fa-reddit-square" : enumFontAwesomeIcon.FontAwesomeredditSquare,
            "fa-send" : enumFontAwesomeIcon.FontAwesomesend,
            "fa-send-o" : enumFontAwesomeIcon.FontAwesomesendO,
            "fa-share-alt" : enumFontAwesomeIcon.FontAwesomeshareAlt,
            "fa-share-alt-square" : enumFontAwesomeIcon.FontAwesomeshareAltSquare,
            "fa-slack" : enumFontAwesomeIcon.FontAwesomeslack,
            "fa-sliders" : enumFontAwesomeIcon.FontAwesomesliders,
            "fa-soundcloud" : enumFontAwesomeIcon.FontAwesomesoundcloud,
            "fa-space-shuttle" : enumFontAwesomeIcon.FontAwesomespaceShuttle,
            "fa-spoon" : enumFontAwesomeIcon.FontAwesomespoon,
            "fa-spotify" : enumFontAwesomeIcon.FontAwesomespotify,
            "fa-steam" : enumFontAwesomeIcon.FontAwesomesteam,
            "fa-steam-square" : enumFontAwesomeIcon.FontAwesomesteamSquare,
            "fa-stumbleupon" : enumFontAwesomeIcon.FontAwesomestumbleupon,
            "fa-stumbleupon-circle": enumFontAwesomeIcon.FontAwesomestumbleuponCircle,
            "fa-support" : enumFontAwesomeIcon.FontAwesomesupport,
            "fa-taxi" : enumFontAwesomeIcon.FontAwesometaxi,
            "fa-tencent-weibo" : enumFontAwesomeIcon.FontAwesometencentWeibo,
            "fa-tree" : enumFontAwesomeIcon.FontAwesometree,
            "fa-university" : enumFontAwesomeIcon.FontAwesomeuniversity,
            "fa-vine" : enumFontAwesomeIcon.FontAwesomevine,
            "fa-wechat" : enumFontAwesomeIcon.FontAwesomewechat,
            "fa-weixin" : enumFontAwesomeIcon.FontAwesomeweixin,
            "fa-wordpress" : enumFontAwesomeIcon.FontAwesomewordpress,
            "fa-yahoo" : enumFontAwesomeIcon.FontAwesomeyahoo,

            /* FontAwesome ver 4.2.0 */
            "fa-angellist" : enumFontAwesomeIcon.FontAwesomeangellist,
            "fa-area-chart" : enumFontAwesomeIcon.FontAwesomeareaChart,
            "fa-at" : enumFontAwesomeIcon.FontAwesomeat,
            "fa-bell-slash" : enumFontAwesomeIcon.FontAwesomebellSlash,
            "fa-bell-slash-o" : enumFontAwesomeIcon.FontAwesomebellSlashO,
            "fa-bicycle" : enumFontAwesomeIcon.FontAwesomebicycle,
            "fa-binoculars" : enumFontAwesomeIcon.FontAwesomebinoculars,
            "fa-birthday-cake" : enumFontAwesomeIcon.FontAwesomebirthdayCake,
            "fa-bus" : enumFontAwesomeIcon.FontAwesomebus,
            "fa-calculator" : enumFontAwesomeIcon.FontAwesomecalculator,
            "fa-cc" : enumFontAwesomeIcon.FontAwesomecc,
            "fa-cc-amex" : enumFontAwesomeIcon.FontAwesomeccAmex,
            "fa-cc-discover" : enumFontAwesomeIcon.FontAwesomeccDiscover,
            "fa-cc-mastercard" : enumFontAwesomeIcon.FontAwesomeccMastercard,
            "fa-cc-paypal" : enumFontAwesomeIcon.FontAwesomeccPaypal,
            "fa-cc-stripe" : enumFontAwesomeIcon.FontAwesomeccStripe,
            "fa-cc-visa" : enumFontAwesomeIcon.FontAwesomeccVisa,
            "fa-copyright" : enumFontAwesomeIcon.FontAwesomecopyright,
            "fa-eyedropper" : enumFontAwesomeIcon.FontAwesomeeyedropper,
            "fa-futbol-o" : enumFontAwesomeIcon.FontAwesomefutbolO,
            "fa-google-wallet" : enumFontAwesomeIcon.FontAwesomegoogleWallet,
            "fa-ils" : enumFontAwesomeIcon.FontAwesomeils,
            "fa-ioxhost" : enumFontAwesomeIcon.FontAwesomeioxhost,
            "fa-lastfm" : enumFontAwesomeIcon.FontAwesomelastfm,
            "fa-lastfm-square" : enumFontAwesomeIcon.FontAwesomelastfmSquare,
            "fa-line-chart" : enumFontAwesomeIcon.FontAwesomelineChart,
            "fa-meanpath" : enumFontAwesomeIcon.FontAwesomemeanpath,
            "fa-newspaper-o" : enumFontAwesomeIcon.FontAwesomenewspaperO,
            "fa-paint-brush" : enumFontAwesomeIcon.FontAwesomepaintBrush,
            "fa-paypal" : enumFontAwesomeIcon.FontAwesomepaypal,
            "fa-pie-chart" : enumFontAwesomeIcon.FontAwesomepieChart,
            "fa-plug" : enumFontAwesomeIcon.FontAwesomeplug,
            "fa-shekel" : enumFontAwesomeIcon.FontAwesomeshekel,
            "fa-sheqel" : enumFontAwesomeIcon.FontAwesomesheqel,
            "fa-slideshare" : enumFontAwesomeIcon.FontAwesomeslideshare,
            "fa-soccer-ball-o" : enumFontAwesomeIcon.FontAwesomesoccerBallO,
            "fa-toggle-off" : enumFontAwesomeIcon.FontAwesometoggleOff,
            "fa-toggle-on" : enumFontAwesomeIcon.FontAwesometoggleOn,
            "fa-trash" : enumFontAwesomeIcon.FontAwesometrash,
            "fa-tty" : enumFontAwesomeIcon.FontAwesometty,
            "fa-twitch" : enumFontAwesomeIcon.FontAwesometwitch,
            "fa-wifi" : enumFontAwesomeIcon.FontAwesomewifi,
            "fa-yelp" : enumFontAwesomeIcon.FontAwesomeyelp,
            
        ]
    }

    private static var staticArrayAwesomeUnicodeStrings : Array<String> {
        return Array<String>( arrayLiteral:
            "\u{f000}", "\u{f001}", "\u{f002}", "\u{f003}", "\u{f004}", "\u{f005}", "\u{f006}", "\u{f007}",
            "\u{f008}", "\u{f009}", "\u{f00a}", "\u{f00b}", "\u{f00c}", "\u{f00d}", "\u{f00e}",
            "\u{f010}", "\u{f011}", "\u{f012}", "\u{f013}", "\u{f014}", "\u{f015}", "\u{f016}", "\u{f017}",
            "\u{f018}", "\u{f019}", "\u{f01a}", "\u{f01b}", "\u{f01c}", "\u{f01d}", "\u{f01e}",
            "\u{f021}", "\u{f022}", "\u{f023}", "\u{f024}", "\u{f025}", "\u{f026}", "\u{f027}",
            "\u{f028}", "\u{f029}", "\u{f02a}", "\u{f02b}", "\u{f02c}", "\u{f02d}", "\u{f02e}", "\u{f02f}",
            "\u{f030}", "\u{f031}", "\u{f032}", "\u{f033}", "\u{f034}", "\u{f035}", "\u{f036}", "\u{f037}",
            "\u{f038}", "\u{f039}", "\u{f03a}", "\u{f03b}", "\u{f03c}", "\u{f03d}", "\u{f03e}",
            "\u{f040}", "\u{f041}", "\u{f042}", "\u{f043}", "\u{f044}", "\u{f045}", "\u{f046}", "\u{f047}",
            "\u{f048}", "\u{f049}", "\u{f04a}", "\u{f04b}", "\u{f04c}", "\u{f04d}", "\u{f04e}",
            "\u{f050}", "\u{f051}", "\u{f052}", "\u{f053}", "\u{f054}", "\u{f055}", "\u{f056}", "\u{f057}",
            "\u{f058}", "\u{f059}", "\u{f05a}", "\u{f05b}", "\u{f05c}", "\u{f05d}", "\u{f05e}",
            "\u{f060}", "\u{f061}", "\u{f062}", "\u{f063}", "\u{f064}", "\u{f065}", "\u{f066}", "\u{f067}",
            "\u{f068}", "\u{f069}", "\u{f06a}", "\u{f06b}", "\u{f06c}", "\u{f06d}", "\u{f06e}",
            "\u{f070}", "\u{f071}", "\u{f072}", "\u{f073}", "\u{f074}", "\u{f075}", "\u{f076}", "\u{f077}",
            "\u{f078}", "\u{f079}", "\u{f07a}", "\u{f07b}", "\u{f07c}", "\u{f07d}", "\u{f07e}",
            "\u{f080}", "\u{f081}", "\u{f082}", "\u{f083}", "\u{f084}", "\u{f085}", "\u{f086}", "\u{f087}",
            "\u{f088}", "\u{f089}", "\u{f08a}", "\u{f08b}", "\u{f08c}", "\u{f08d}", "\u{f08e}",
            "\u{f090}", "\u{f091}", "\u{f092}", "\u{f093}", "\u{f094}", "\u{f095}", "\u{f096}", "\u{f097}",
            "\u{f098}", "\u{f099}", "\u{f09a}", "\u{f09b}", "\u{f09c}", "\u{f09d}", "\u{f09e}",
            "\u{f0a0}", "\u{f0a1}", "\u{f0f3}", "\u{f0a3}", "\u{f0a4}", "\u{f0a5}", "\u{f0a6}", "\u{f0a7}",
            "\u{f0a8}", "\u{f0a9}", "\u{f0aa}", "\u{f0ab}", "\u{f0ac}", "\u{f0ad}", "\u{f0ae}",
            "\u{f0b0}", "\u{f0b1}", "\u{f0b2}",
            "\u{f0c0}", "\u{f0c1}", "\u{f0c2}", "\u{f0c3}", "\u{f0c4}", "\u{f0c5}", "\u{f0c6}", "\u{f0c7}",
            "\u{f0c8}", "\u{f0c9}", "\u{f0ca}", "\u{f0cb}", "\u{f0cc}", "\u{f0cd}", "\u{f0ce}",
            "\u{f0d0}", "\u{f0d1}", "\u{f0d2}", "\u{f0d3}", "\u{f0d4}", "\u{f0d5}", "\u{f0d6}", "\u{f0d7}",
            "\u{f0d8}", "\u{f0d9}", "\u{f0da}", "\u{f0db}", "\u{f0dc}", "\u{f0dd}", "\u{f0de}",
            "\u{f0e0}", "\u{f0e1}", "\u{f0e2}", "\u{f0e3}", "\u{f0e4}", "\u{f0e5}", "\u{f0e6}", "\u{f0e7}",
            "\u{f0e8}", "\u{f0e9}", "\u{f0ea}", "\u{f0eb}", "\u{f0ec}", "\u{f0ed}", "\u{f0ee}",
            "\u{f0f0}", "\u{f0f1}", "\u{f0f2}", "\u{f0a2}", "\u{f0f4}", "\u{f0f5}", "\u{f0f6}", "\u{f0f7}",
            "\u{f0f8}", "\u{f0f9}", "\u{f0fa}", "\u{f0fb}", "\u{f0fc}", "\u{f0fd}", "\u{f0fe}",
            "\u{f100}", "\u{f101}", "\u{f102}", "\u{f103}", "\u{f104}", "\u{f105}", "\u{f106}", "\u{f107}",
            "\u{f108}", "\u{f109}", "\u{f10a}", "\u{f10b}", "\u{f10c}", "\u{f10d}", "\u{f10e}",
            "\u{f110}", "\u{f111}", "\u{f112}", "\u{f113}", "\u{f114}", "\u{f115}",
            "\u{f118}", "\u{f119}", "\u{f11a}", "\u{f11b}", "\u{f11c}", "\u{f11d}", "\u{f11e}",
            "\u{f120}", "\u{f121}", "\u{f122}", "\u{f122}", "\u{f123}", "\u{f124}", "\u{f125}", "\u{f126}", "\u{f127}",
            "\u{f128}", "\u{f129}", "\u{f12a}", "\u{f12b}", "\u{f12c}", "\u{f12d}", "\u{f12e}",
            "\u{f130}", "\u{f131}", "\u{f132}", "\u{f133}", "\u{f134}", "\u{f135}", "\u{f136}", "\u{f137}",
            "\u{f138}", "\u{f139}", "\u{f13a}", "\u{f13b}", "\u{f13c}", "\u{f13d}", "\u{f13e}",
            "\u{f140}", "\u{f141}", "\u{f142}", "\u{f143}", "\u{f144}", "\u{f145}", "\u{f146}", "\u{f147}",
            "\u{f148}", "\u{f149}", "\u{f14a}", "\u{f14b}", "\u{f14c}", "\u{f14d}", "\u{f14e}",
            "\u{f150}", "\u{f151}", "\u{f152}", "\u{f153}", "\u{f154}", "\u{f155}", "\u{f156}", "\u{f157}",
            "\u{f158}", "\u{f159}", "\u{f15a}", "\u{f15b}", "\u{f15c}", "\u{f15d}", "\u{f15e}",
            "\u{f160}", "\u{f161}", "\u{f162}", "\u{f163}", "\u{f164}", "\u{f165}", "\u{f166}", "\u{f167}",
            "\u{f168}", "\u{f169}", "\u{f16a}", "\u{f16b}", "\u{f16c}", "\u{f16d}", "\u{f16e}",
            "\u{f170}", "\u{f171}", "\u{f172}", "\u{f173}", "\u{f174}", "\u{f175}", "\u{f176}", "\u{f177}",
            "\u{f178}", "\u{f179}", "\u{f17a}", "\u{f17b}", "\u{f17c}", "\u{f17d}", "\u{f17e}",
            "\u{f180}", "\u{f181}", "\u{f182}", "\u{f183}", "\u{f184}", "\u{f185}", "\u{f186}", "\u{f187}",
            "\u{f188}", "\u{f189}", "\u{f18a}", "\u{f18b}", "\u{f18c}", "\u{f18d}", "\u{f18e}",
            "\u{f190}", "\u{f191}", "\u{f192}", "\u{f193}", "\u{f194}", "\u{f195}", "\u{f196}",
            /* Font Awesome ver 4.10 */
            "\u{f1b9}", "\u{f19c}", "\u{f1b4}", "\u{f1b5}", "\u{f1e2}", "\u{f1ad}", "\u{f1ba}", "\u{f1b9}",
            "\u{f1ae}", "\u{f1ce}", "\u{f1db}", "\u{f1cb}", "\u{f1b2}", "\u{f1b3}", "\u{f1c0}", "\u{f1a5}",
            "\u{f1bd}", "\u{f1a6}", "\u{f1a9}", "\u{f1d1}", "\u{f199}", "\u{f1ac}", "\u{f1c6}", "\u{f1c7}",
            "\u{f1c9}", "\u{f1c3}", "\u{f1c5}", "\u{f1c8}", "\u{f1c1}", "\u{f1c5}", "\u{f1c5}", "\u{f1c4}",
            "\u{f1c7}", "\u{f1c8}", "\u{f1c2}", "\u{f1c6}", "\u{f1d1}", "\u{f1d3}", "\u{f1d2}", "\u{f1a0}",
            "\u{f19d}", "\u{f1d4}", "\u{f1dc}", "\u{f1da}", "\u{f19c}", "\u{f1aa}", "\u{f1cc}", "\u{f1ab}",
            "\u{f1cd}", "\u{f1cd}", "\u{f1cd}", "\u{f19d}", "\u{f19b}", "\u{f1d8}", "\u{f1d9}", "\u{f1dd}",
            "\u{f1b0}", "\u{f1a7}", "\u{f1a8}", "\u{f1a7}", "\u{f1d6}", "\u{f1d0}", "\u{f1d0}", "\u{f1b8}",
            "\u{f1a1}", "\u{f1a2}", "\u{f1d8}", "\u{f1d9}", "\u{f1e0}", "\u{f1e1}", "\u{f198}", "\u{f1de}",
            "\u{f1be}", "\u{f197}", "\u{f1b1}", "\u{f1bc}", "\u{f1b6}", "\u{f1b7}", "\u{f1a4}", "\u{f1a3}",
            "\u{f1cd}", "\u{f1ba}", "\u{f1d5}", "\u{f1bb}", "\u{f19c}", "\u{f1ca}", "\u{f1d7}", "\u{f1d7}",
            "\u{f19a}", "\u{f19e}",
            /* Font Awesome ver 4.20 */
            "\u{f209}", "\u{f1fe}", "\u{f1fa}", "\u{f1f6}", "\u{f1f7}", "\u{f206}", "\u{f1e5}", "\u{f1fd}",
            "\u{f207}", "\u{f1ec}", "\u{f20a}", "\u{f1f3}", "\u{f1f2}", "\u{f1f1}", "\u{f1f4}", "\u{f1f5}",
            "\u{f1f0}", "\u{f1f9}", "\u{f1fb}", "\u{f1e3}", "\u{f1ee}", "\u{f20b}", "\u{f208}", "\u{f202}",
            "\u{f203}", "\u{f201}", "\u{f20c}", "\u{f1ea}", "\u{f1fc}", "\u{f1ed}", "\u{f200}", "\u{f1e6}",
            "\u{f20b}", "\u{f20b}", "\u{f1e7}", "\u{f1e3}", "\u{f204}", "\u{f205}", "\u{f1f8}", "\u{f1e4}",
            "\u{f1e8}", "\u{f1eb}", "\u{f1e9}"
        )
    }

    public static func fontAwesomeEnumForIconIdentifier(string: String) -> enumFontAwesomeIcon {
        var nRet: enumFontAwesomeIcon = .FontAwesomeGlass
        if let icon: enumFontAwesomeIcon = staticDictFontAwesome[string]
        {
            nRet = icon
        }
        return nRet
    }

    public static func fontAwesomeIconStringForEnum(enumValue: enumFontAwesomeIcon) -> String {
        return staticArrayAwesomeUnicodeStrings[enumValue.rawValue]
    }

    public static func fontAwesomeIconStringForIconIdentifier(strIdentifier: String) -> String {
        return fontAwesomeIconStringForEnum(fontAwesomeEnumForIconIdentifier(strIdentifier))
    }
}
