//
//  ChatViewModel.swift
//  ChatBubble
//
//  Created by Rahul kr on 06/06/18.
//

import Foundation

protocol ChatViewDelegate
{
    func onItemAdded() -> ()
}

protocol ChatViewPresentable
{
    var newchat: String? {get}
}

class ChatViewModel: ChatViewPresentable {
    
    var chats: [Chat] = []
    var newchat: String?
    weak var viewc: ChatViewControllerDelegate?
    
    
    init(view: ChatViewControllerDelegate) {
        
        viewc = view
        let chat1 = Chat(arg_user: "", arg_pic: "", arg_message: "Hi")
        let chat2 = Chat(arg_user: "", arg_pic: "", arg_message: "Hi")
        chats.append(contentsOf: [chat1,chat2])
    }
    
    deinit {
        print("ChatViewModel de-initialized")
    }
}

extension ChatViewModel: ChatViewDelegate
{
    func onItemAdded() {
        
        chats.append(Chat(arg_user: "", arg_pic: "", arg_message: newchat!))
        viewc?.didNewChatMessagesRecieved()
    }
}

