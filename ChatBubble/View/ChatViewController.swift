//
//  ViewController.swift
//  ChatBubble
//
//  Created by Rahul kr on 06/06/18.
//

import UIKit

protocol ChatViewControllerDelegate: class {
    func didNewChatMessagesRecieved() -> ()
}

class ChatViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var chatTXTBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var chatTXT: UITextField!
    
    //MARK:- Properties
    var chatviewmodel: ChatViewModel?
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        KeyboardNotificationController.sharedKC.registerforKeyBoardNotification(delegate: self)
        addOnTapDismissKeyboard()
        chatviewmodel = ChatViewModel(view: self)
    }
    
    deinit {
        print("ChatViewController de-initialized")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChatViewController: KeyBoardNotificationDelegate,UITableViewDataSource,ChatViewControllerDelegate
{
    func didNewChatMessagesRecieved() {
        chatTable.reloadData()
        scrollToBottom()
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatviewmodel?.chats.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.row % 2
        {
            
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "leftbubblecell")!
            let lccell = cell as! LeftChatCell
            lccell.configureLeftChatCell(chat: (chatviewmodel?.chats[indexPath.row])!)
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "rightbubblecell")!
            let rccell = cell as! RightChatCell
            rccell.configureRightChatCell(chat: (chatviewmodel?.chats[indexPath.row])!)
        }
        
        return cell
    }
    
    
    //MARK: - KeyBoardNotificationDelegate
    
    func didKeyBoardAppeared(keyboardHeight: CGFloat) {
        
        self.chatTXTBottomConstraint.constant = (keyboardHeight == 0) ? 0 : -keyboardHeight
        chatTable.reloadData()
        scrollToBottom()
    }
    
    //MARK: - Custom Accessors
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: (self.chatviewmodel?.chats.count)!-1, section: 0)
            self.chatTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    fileprivate func addOnTapDismissKeyboard() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        print("**************Table view didSelect maynot work!!!!!!!!!!!!!!!")
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    fileprivate func addChat()
    {
        chatviewmodel?.newchat = chatTXT.text
        chatviewmodel?.onItemAdded()
        chatTXT.text = ""
    }
    
    //MARK: - IBAction
    
    @IBAction func sendChat(_ sender: UIButton)
    {
        (chatTXT.text?.isEmpty)! ? nil : addChat()
    }
}

class RightChatCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var chatLBL: UILabel!
    
    //MARK: - View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureRightChatCell(chat: Chat)
    {
        chatLBL.text = chat.chatMessage
    }
}

class LeftChatCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var chatLBL: UILabel!
    
    //MARK: - View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureLeftChatCell(chat: Chat)
    {
        chatLBL.text = chat.chatMessage
    }
}

