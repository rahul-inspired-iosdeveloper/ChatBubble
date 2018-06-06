//
//  Chat.swift
//  ChatBubble
//
//  Created by Rahul kr on 06/06/18.
//

import Foundation

class Chat {
    
    var chatUser: String?
    var chatUser_Pic: String? // Profile pic url
    var chatMessage: String?
    
    init(arg_user:String,arg_pic: String,arg_message:String) {
        
        chatUser = arg_user
        chatUser_Pic = arg_pic
        chatMessage = arg_message
    }
    
    deinit {
        print("Chat Model de-initialized")
    }
}
