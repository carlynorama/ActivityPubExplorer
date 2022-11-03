////
////  ContentView.swift
////  HTMLTests
////
////  Created by Carlyn Maw on 10/30/22.
////
//
import SwiftUI



extension String {
    //Usage
    //List(ExampleText.harderHTMLTests, id:\.self) { item in
    //    Text(item.listCrasher() ?? "Nothing to see").id(UUID()) <- Will need id() somewhere if view scrolls
    //}
    //Parses emoji's correctly by adding characterEncoding option.
    func parseAsHTML() -> AttributedString? {
        let data = Data(self.utf8)
        return try? AttributedString(NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,  .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil))
     }
    
    //Usage
    //List(ExampleText.harderHTMLTests, id:\.self) { item in
    //    Text(item.htmlToAttributedString()).id(UUID())  <-Will need id() somewhere if view scrolls
    //}
    func catchingParseAsHTML() -> AttributedString {
        do {
            let data = Data(self.utf8)
            let result = try AttributedString(NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,  .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil))
            return result
        } catch {
            return AttributedString("Error parsing HTML: \(error)")
        }
    }
    
    func parseAsMarkdown() -> AttributedString? {
        return try? AttributedString(markdown: self)
    }
    
    func catchingParseAsMarkdown() -> AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            return AttributedString("Error parsing HTML: \(error)")
        }
    }
    
//    //https://wwdcbysundell.com/2021/a-first-look-at-attributed-string/
//    func appendLink(
//        to string: AttributedString,
//        label: String,
//        url: URL
//    ) -> AttributedString {
//        var attributes = AttributeContainer()
//        attributes.link = url
//
//        let link = AttributedString(label, attributes: attributes)
//
//        var string = string
//        string.append(link)
//        return string
//    }
//    
    func linkedText(url: URL) -> AttributedString {
        var attributes = AttributeContainer()
        attributes.link = url

        let link = AttributedString(self, attributes: attributes)

        var string = AttributedString()
        string.append(link)
        return string
    }
}
////
//struct ContentView: View {
//    
//    var body: some View {
//        VStack {
//            Group {
//                Text(ExampleText.htmlTests[0].listCrasher() ?? "Nothing to see")
//                Text(ExampleText.htmlTests[1].listCrasher() ?? "Nothing to see")
//                Text(ExampleText.htmlTests[2].listCrasher() ?? "Nothing to see")
//                Text(ExampleText.htmlTests[3].listCrasher() ?? "Nothing to see")
//            }
//            
//            List(ExampleText.harderHTMLTests, id:\.self) { item in
//                // Fixed height does not fix the problem. https://stackoverflow.com/questions/59889020/how-to-use-an-nsattributedstring-with-a-scrollview-in-swiftui
//                Text(item.listCrasher() ?? "Nothing to see").id(UUID())
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//enum ExampleText {
//    
//    static let htmlTests  = [#"<p>test me</p>"#,
//                             #"Hello <b>World</b>"#,
//                             #"<p>Hello <a href="http://www.apple.com">World</a></p>"#,
//                             #"<i>what is</i><h3>Happening??</h3>"#,
//                             #"Something long so scrolling is required. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at urna vitae leo viverra fermentum. Maecenas nec porttitor massa, non feugiat turpis. Donec pretium, enim quis porttitor feugiat, nunc erat pulvinar urna, vel posuere nunc turpis at diam. Nam vehicula lectus nisi, a lacinia lacus euismod id. Curabitur rutrum nunc in purus rutrum elementum. Curabitur ac maximus enim, eget sodales ex. Maecenas at sem eget leo commodo suscipit. Praesent non aliquet sem. Cras et erat dapibus, semper turpis at, dictum ligula. Cras faucibus fringilla nunc, nec molestie risus finibus sed. Aliquam a cursus elit. Aenean convallis dui vitae eros elementum pretium. Aenean dolor sapien, laoreet id urna vel, finibus imperdiet ex. Pellentesque suscipit justo eu augue commodo tempor. Ut id facilisis massa. "#,
//                             #"Is this long enough?"#,
//                             #"How about now?"#,
//                             #"Something long so scrolling is required. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at urna vitae leo viverra fermentum. Maecenas nec porttitor massa, non feugiat turpis. Donec pretium, enim quis porttitor feugiat, diam. Nam vehicula lectus nisi, a lacinia lacus euismod id. Curabitur rutrum nunc in purus rutrum elementum. Curabitur ac maximus enim, eget sodales ex. Maecenas at sem eget leo commodo suscipit. Praesent non aliquet sem. Cras et erat dapibus, semper turpis at, dictum ligula. Cras faucibus fringilla nunc, nec molestie risus finibus sed. Aliquam a cursus elit. Aenean convallis dui vitae eros elementum pretium. Aenean dolor sapien, laoreet id urna vel, finibus imperdiet ex. Pellentesque suscipit justo eu augue commodo tempor. Ut id facilisis massa. "#,
//                             #"Something long required. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at urna vitae leo viverra fermentum. Maecenas nec porttitor massa, non feugiat turpis. Donec pretium, enim quis porttitor feugiat, nunc erat pulvinar urna, vel posuere nunc turpis at diam. Nam vehicula lectus nisi, a lacinia lacus euismod id. Curabitur rutrum nunc in purus rutrum elementum. Curabitur ac maximus enim, eget sodales ex. Maecenas at sem eget leo commodo suscipit. Praesent non aliquet sem. Cras et erat dapibus, semper turpis at, dictum ligula. Cras faucibus fringilla nunc, nec molestie risus finibus sed. Aliquam a cursus elit. Aenean convallis dui vitae eros elementum pretium. Aenean dolor sapien, laoreet id urna vel, finibus imperdiet ex. Pellentesque suscipit justo eu augue commodo tempor. Ut id facilisis massa. "#,
//                             #"Something long so scrolling is required. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at urna vitae leo viverra fermentum. Maecenas nec porttitor massa, non feugiat turpis. Donec pretium, enim quis porttitor feugiat, diam. Nam vehicula lectus nisi, a lacinia lacus euismod id. Curabitur rutrum nunc in purus rutrum elemmus enim, eget sodales ex. Maecenas at sem eget leo commodo suscipit. Praesent non aliquet sem. Cras et erat dapibus, semper turpis at, dictum ligula. Cras faucibus fringilla nunc, nec molestie risus finibus sed. Aliquam a cursus elit. Aenean convallis dui vitae eros elementum pretium. Aenean dolor sapien, laoreet id urna vel, finibus imperdiet ex. Pellentesque suscipit justo eu augue commodo tempor. Ut id facilisis massa. "#,
//                             #"Something long required. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at urna vitae leo viverra fermentum. Maecenas nec porttitor massa, non feugiat turpis. Donec pretium, enim quis porttitor feugiat, nunc erat pulvinar urna, vel posuere nunc turpis at diam. Nam vehicula lectus nisi, a lacinia lacus euismod id. Curabitur rutrum nunc in purus rutrum elementum. Curabitur ac maximus enim, eget sodales ex. Maecenas at sem eget leo commodo suscipit. Praesent non aliquet sem. Cras et erat dapibus, semper turpis at, dictum ligula. Cras faucibus fringilla nunc, nec moles elementum pretium. Aenean dolor sapien, laoreet id urna vel, finibus imperdiet ex. Pellentesque suscipit justo eu augue commodo tempor. Ut id facilisis massa. "#,
//                             #"Something long required. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusceo viverra fermentum. Maecenas nec porttitor massa, non feugiat turpis. Donec pretium, enim quis porttitor feugiat, nunc erat pulvinar urna, vel posuere nunc turpis at diam. Nam vehicula lectus nisi, a lacinia lacus euismod id. Curabitur rutrum nunc in purus rutrum elementum. Curabitur ac maximus enim, eget sodales ex. Maecenas at sem eget leo commodo suscipit. Praesent non aliquet la nunc, nec moles elementum pretium. Aenean dolor sapien, laoreet id urna vel, finibus imperdiet ex. Pellentesque suscipit justo eu augue commodo tempor. Ut id facilisis massa. "#,
//                             #"Something long required. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusceo viverra fermentum. Maecenas nec porttitt diam. Nam vehicula lectus nisi, a lacinia lacus euismod id. Curabitur rutrum nunc in purus rutrum elementum. Curabitur ac maximus enim, eget sodales ex. Maecenas at sem eget leo commodo suscipit. Praesent non aliquet la nunc, nec moles elementum pretium. Aenean dolor sapien, laoreet id urna vel, finibus imperdiet ex. Pellentesque suscipit justo eu augue commodo tempor. Ut id facilisis massa. "#
//    ]
//    
//    static let harderHTMLTests = [#"<p>Today I had some spare time to play with the <a href="https://fosstodon.org/tags/M5Stack" class="mention hashtag" rel="nofollow noopener noreferrer" target="_blank">#<span>M5Stack</span></a> CoreInk E-ink display and the <a href="https://fosstodon.org/tags/OpenMeteo" class="mention hashtag" rel="nofollow noopener noreferrer" target="_blank">#<span>OpenMeteo</span></a> weather API.</p><p>In addition to the weather forecast it is displaying the current time, although that might not be viable as far as power consumption goes.</p><p>We'll see if it's still running tomorrow...</p>"#,#"<p><a href="https://fosstodon.org/tags/making" class="mention hashtag" rel="nofollow noopener noreferrer" target="_blank">#<span>making</span></a> <a href="https://fosstodon.org/tags/MicroPython" class="mention hashtag" rel="nofollow noopener noreferrer" target="_blank">#<span>MicroPython</span></a></p>"#,
//                                  #"<p>I just got up at 6:30 to do my friend's face makeup for the ween. I am half alive and not sure whether to go back to sleep or just roll in this state</p>"#,
//                                  #"<p>Hey linux crew: i'm running into this issue with pipewire: <a href="https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/1697" rel="nofollow noopener noreferrer" target="_blank"><span class="invisible">https://</span><span class="ellipsis">gitlab.freedesktop.org/pipewir</span><span class="invisible">e/pipewire/-/issues/1697</span></a> and a suggested workaround is to install pulseaudio-alsa. Does somebody know what the matching package for ubuntu would be?</p>"#,
//                                  #"<p>I always think I should dress up for Halloween then never prioritize or get around to actually putting any effort in. So, I'm just myself again this year. But at least I have cute, comfy sock-slippers?</p>"#,
//                                  #"<p><a href="https://mastodon.social/tags/introductions" class="mention hashtag" rel="nofollow noopener noreferrer" target="_blank">#<span>introductions</span></a></p>"#,#"<p>Hey, I'm Windell Oskay!</p><p>My background is in atomic physics. I co-founded, with Lenore Edman <a href="https://mastodon.social/@lenore1" rel="nofollow noopener noreferrer" target="_blank"><span class="invisible">https://</span><span class="">mastodon.social/@lenore1</span><span class="invisible"></span></a>, Evil Mad Scientist ( <a href="https://www.evilmadscientist.com" rel="nofollow noopener noreferrer" target="_blank"><span class="invisible">https://www.</span><span class="">evilmadscientist.com</span><span class="invisible"></span></a> ), where I design the hardware and software of the AxiDraw pen plotters. Past projects include BristleBots, WaterColorBot, CandyFab.</p>"#,#"<p>Latest project, with co-author Eric Schlaepfer <a href="https://mastodon.social/@tubetime" rel="nofollow noopener noreferrer" target="_blank"><span class="invisible">https://</span><span class="">mastodon.social/@tubetime</span><span class="invisible"></span></a>, is Open Circuits ( <a href="https://opencircuitsbook.com" rel="nofollow noopener noreferrer" target="_blank"><span class="invisible">https://</span><span class="">opencircuitsbook.com</span><span class="invisible"></span></a> ), a coffee-table book photographic tour inside electronic components.</p>"#,
//                                  #"<p>and hoo man cross-posting really does not work very well in practice - too many differences between the two platforms, especially with visibility and threads.  Still figuring out how to not bungle this.</p>"#,
//                                  #"<p>Let's talk voting!  US elections are in a week and we're excited about filling in those dots on the ballot.  But do you know that some US citizens are still denied the right to vote and voting representation in Congress?  And they just happen to be places that are majority Black &amp; indigenous?  That's right, we're talking about US territories, which is why we support Equally American, a non-profit working toward equal represenation for everyone.</p>"#]
//}
