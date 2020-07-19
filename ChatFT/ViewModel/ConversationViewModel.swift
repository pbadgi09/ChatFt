//
//  ConversationViewModel.swift
//  ChatFT
//
//  Created by Pranav Badgi on 14/04/20.
//  Copyright © 2020 Pranav Badgi. All rights reserved.
//

import Foundation
struct ConversationViewModel {
    private let conversation: Conversation
    
    var profileImageUrl: URL? {
        return URL(string: conversation.user.profileImageUrl)
    }
    
    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
}
