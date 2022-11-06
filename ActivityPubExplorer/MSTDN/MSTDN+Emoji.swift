//
//  MSTDN+Emoji.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/5/22.
//  https://docs.joinmastodon.org/methods/instance/custom_emojis/
//  https://mastodon.example/api/v1/custom_emojis

import Foundation


extension MastodonAPIServer {
    
    func fetchCustomEmoji() {
        
    }
    
    static var exampleEmoji:Data {
        """
        [
          {
            "shortcode": "aaaa",
            "url": "https://files.mastodon.social/custom_emojis/images/000/007/118/original/aaaa.png",
            "static_url": "https://files.mastodon.social/custom_emojis/images/000/007/118/static/aaaa.png",
            "visible_in_picker": true
          },
          {
            "shortcode": "AAAAAA",
            "url": "https://files.mastodon.social/custom_emojis/images/000/071/387/original/AAAAAA.png",
            "static_url": "https://files.mastodon.social/custom_emojis/images/000/071/387/static/AAAAAA.png",
            "visible_in_picker": true
          },
          {
            "shortcode": "blobaww",
            "url": "https://files.mastodon.social/custom_emojis/images/000/011/739/original/blobaww.png",
            "static_url": "https://files.mastodon.social/custom_emojis/images/000/011/739/static/blobaww.png",
            "visible_in_picker": true,
            "category": "Blobs"
          },
          {
            "shortcode": "yikes",
            "url": "https://files.mastodon.social/custom_emojis/images/000/031/275/original/yikes.png",
            "static_url": "https://files.mastodon.social/custom_emojis/images/000/031/275/static/yikes.png",
            "visible_in_picker": true
          },
          {
            "shortcode": "ziltoid",
            "url": "https://files.mastodon.social/custom_emojis/images/000/017/094/original/05252745eb087806.png",
            "static_url": "https://files.mastodon.social/custom_emojis/images/000/017/094/static/05252745eb087806.png",
            "visible_in_picker": true
          }
        ]
        """.data(using: .utf8)!
    }
    
}
