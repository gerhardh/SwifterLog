// =====================================================================================================================
//
//  File:       Target.OSLog.swift
//  Project:    SwifterLog
//
//  Version:    1.5.0
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterlog/swifterlog.html
//  Git:        https://github.com/Balancingrock/SwifterLog
//
//  Copyright:  (c) 2017-2018 Marinus van der Lugt, All rights reserved.
//
//  License:    Use or redistribute this code any way you like with the following two provision:
//
//  1) You ACCEPT this source code AS IS without any guarantees that it will work as intended. Any liability from its
//  use is YOURS.
//
//  2) You WILL NOT seek damages from the author or balancingrock.nl.
//
//  I also ask you to please leave this header with the source code.
//
//  I strongly believe that voluntarism is the way for societies to function optimally. Thus I have choosen to leave it
//  up to you to determine the price for this code. You pay me whatever you think this code is worth to you.
//
//   - You can send payment via paypal to: sales@balancingrock.nl
//   - Or wire bitcoins to: 1GacSREBxPy1yskLMc9de2nofNv2SNdwqH
//
//  I prefer the above two, but if these options don't suit you, you can also send me a gift from my amazon.co.uk
//  wishlist: http://www.amazon.co.uk/gp/registry/wishlist/34GNMPZKAQ0OO/ref=cm_sw_em_r_wsl_cE3Tub013CKN6_wb
//
//  If you like to pay in another way, please contact me at rien@balancingrock.nl
//
//  (It is always a good idea to visit the website/blog/google to ensure that you actually pay me and not some imposter)
//
//  For private and non-profit use the suggested price is the price of 1 good cup of coffee, say $4.
//  For commercial use the suggested price is the price of 1 good meal, say $20.
//
//  You are however encouraged to pay more ;-)
//
//  Prices/Quotes for support, modifications or enhancements can be obtained from: rien@balancingrock.nl
//
// =====================================================================================================================
//
// Purpose:
//
// Interface to write log entries to the OS Logger.
//
// =====================================================================================================================
//
// History:
//
// 1.5.0 - Added OSLog levels filtering
// 1.3.0 - Removed CAsl, renamed to OSLog
// 1.1.0 - Initial release in preperation for v2.0.0
//
// =====================================================================================================================

import Foundation
import os


/// An interface to write log entries to the OS Log.

public class OSLog: Target {

    
    /// This filter decides AFTER the osLogFacilityRecordAtAndAboveLevel setting if an entry at this level should be enabled or not.
    
    public var debugEnabled: Bool = true
    
    
    /// This filter decides AFTER the osLogFacilityRecordAtAndAboveLevel setting if an entry at this level should be enabled or not.

    public var infoEnabled: Bool = true


    /// This filter decides AFTER the osLogFacilityRecordAtAndAboveLevel setting if an entry at this level should be enabled or not.

    public var defaultEnabled: Bool = true


    /// This filter decides AFTER the osLogFacilityRecordAtAndAboveLevel setting if an entry at this level should be enabled or not.

    public var errorEnabled: Bool = true


    /// This filter decides AFTER the osLogFacilityRecordAtAndAboveLevel setting if an entry at this level should be enabled or not.

    public var faultEnabled: Bool = true
    
    
    /// Record one line of text (conditionally)
    
    public override func process(_ entry: Entry) {
        
        
        // Check OSLog custom levels
        
        switch entry.level {
        case .debug: if !debugEnabled { return }
        case .info: if !infoEnabled { return }
        case .notice: if !defaultEnabled { return }
        case .warning, .error, .critical, .alert: if !errorEnabled { return }
        case .emergency: if !faultEnabled { return }
        case .none: break
        }

        
        // Create the line with loginformation
        
        let str = (formatter ?? Logger.formatter).string(entry)
        
        // Create the entry in the OS Log
        
        os_log("%@", type: entry.level.osLogType, (str as NSString))
    }
}
