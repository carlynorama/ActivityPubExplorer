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
        HStack(alignment: .top) {
            Image(systemName: "photo")
            Text(attachment.url).font(.caption)
        }
        
    }
}

struct MediaAttachmentView_Previews: PreviewProvider {
    static var previews: some View {
        MediaAttachmentView(attachment: MediaAttachment.example)
    }
}

extension MediaAttachment {
    static var example:MediaAttachment {
        MediaAttachment(
            id: "109275885117921166",
            type: "image",
            url: "https://cdn.masto.host/socialcozytronicscom/cache/media_attachments/files/109/275/885/117/921/166/original/67813195cca6d7d0.png",
            previewURL: "https://cdn.masto.host/socialcozytronicscom/cache/media_attachments/files/109/275/885/117/921/166/small/67813195cca6d7d0.png",
            remoteURL: "https://friend.camp/system/media_attachments/files/109/275/865/927/555/457/original/050a015305c5b77e.png",
            previewRemoteURL: nil,
            textURL: nil,
            meta: MediaMeta(original: MediaDimensions(width: 684, height: 264, size: "684x264", aspect: 2.590909090909091),
                            small: MediaDimensions(width: 644, height: 249, size: "644x249", aspect: 2.5863453815261046),
                            focus: MediaFocus(x: 0, y: 0)),
            mediaAttachmentDescription: "The Bargaining Committee won record-breaking raises in a six year contract, including compensation for work done outside of the classroom. A standard 4-credit course that was previously compensated at a minimum rate of $6,268.50 will now be compensated at $10,400, increasing to nearly $13,000 over the life of the agreement. Where university administration had previously devalued teaching artists and performers, the tentative agreement raises all boats, paying studio and performing arts instructors at the same rate as lecture courses by year three of the contract. With landmark pay increases across the full spectrum of adjunct instructors, NYU adjuncts now stand among the highest paid unionized contingent instructors in the nation.",
            blurhash: "U9Q]+wD%?bM{9Ft7ofWB~qt7offQ~qxuRjj[")
    }
}
