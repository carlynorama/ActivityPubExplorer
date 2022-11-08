//
//  MediaAttachmentView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/2/22.
//

import SwiftUI

struct MediaAttachmentView: View {
    let attachment:ItemMediaAttachment
    let url:URL?
    
    @State var displayFullAltText = false
    @State var textDisplay = "ALT"
    
    init(attachment:ItemMediaAttachment) {
        self.attachment = attachment
        self.url = URL(string: attachment.previewURL)
    }
    
    var body: some View {
        ImageGetter().overlay(alignment: .bottomLeading, content: Overlay)
    }
    
    //TODO: Which show-hide process do is better? 
    
    @ViewBuilder func Overlay() -> some View {
        if let altText = attachment.mediaAttachmentDescription {
            Text("\(textDisplay)")
                    .font(.caption)
                    .padding()
                    .background(.ultraThinMaterial)
                    .onTapGesture() {
                        withAnimation {
                            if displayFullAltText == true {
                                displayFullAltText = false
                                textDisplay = "ALT"
                            } else {
                                displayFullAltText = true
                                textDisplay = altText
                            }
                        }
                    }
        } else {
            EmptyView()
        }
    }
    
//    @ViewBuilder func Overlay() -> some View {
//        if let altText = attachment.mediaAttachmentDescription {
//            if displayFullAltText {
//                Text("\(altText)")
//                    .font(.caption)
//                    .padding()
//                    .background(.ultraThinMaterial)
//                    .transition(.scale(scale: 0.01, anchor: .bottomLeading))
//                    .onTapGesture() {
//                        withAnimation {
//                            displayFullAltText = false
//                        }
//                    }
//            } else {
//                Text("ALT")
//                    .font(.caption)
//                    .padding()
//                    .background(.ultraThinMaterial)
//                    //.animation(.easeInOut)
//                    .transition(.scale(scale: 0.01, anchor: .bottomLeading))
//                    .onTapGesture() {
//                        withAnimation {
//                            displayFullAltText = true
//                        }
//                    }
//            }
//        } else {
//            EmptyView()
//        }
//    }
    
    @ViewBuilder func ImageGetter() -> some View {
        if let url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                    //.frame(maxWidth: 100, maxHeight: 100)
                        .border(.orange)
                case .failure(let error):
                    let _ = print(url)
                    let _ = print(error)
                    Image(systemName: "person.circle.fill")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
                
            }
        } else {
            Image(systemName: "slash.circle.fill")
            //Image(systemName: "rectangle.fill.on.rectangle.fill.slash.fill")
        }
    }
}


struct MediaAttachmentView_Previews: PreviewProvider {
    static var previews: some View {
        MediaAttachmentView(attachment: ItemMediaAttachment.example)
    }
}

extension ItemMediaAttachment {
    static var example:ItemMediaAttachment {
        ItemMediaAttachment(
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
