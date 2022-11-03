//
//  MediaAttachmentView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/2/22.
//

import SwiftUI

struct MediaAttachmentView: View {
    let attachment:MediaAttachment
    
    var body: some View {
        Text(attachment.url)
    }
}

//struct MediaAttachmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MediaAttachmentView()
//    }
//}
