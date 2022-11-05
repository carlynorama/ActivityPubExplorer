#  Activity Pub Explorer

[![Swift Version][swift-image]][swift-url]

Toy app to explore how Mastodon and ActivityPub feeds in general might be handled with Swift / SwiftUI

None of this should be used as an example of best practices. 

## Files this Repo

- ContentView: The main view, right now an example of a Mastodon server's public timeline

### General
- API: Generic Framework baseline for REST APIs
- HTMLSnippetRender: How to get `HTML` -> `AttributedString` for use in `SwiftUI`
- RequestService: File with the network connection

### Mastodon Specific
- MNStatusExample: JSON examplar of what Mastodon API sends back
- MastodonStatusItem: https://app.quicktype.io/ generated Struct for a Status item and related types
- MSTDNStatusItem+Display: Things that will likely be useful to other API's as well to prep for viewing. Creates the AttributedString. Introspects for available displayable parameters
- MastodonAPI: Mastodon API calls
- StatusListSubViews - Right now all dependent on the Mastodon types
- Sample Content - Mastodon Style JSON

### ActivityPub/Fediverse compliance
- ActivityPubGeneral - Directory for AP general stuff. Not really in use yet.

## Resources

### Working with URLS and HTTP
- See also the resources from Networking Example: https://github.com/carlynorama/NetworkingExample

### Working with API
- https://docs.joinmastodon.org/client/intro/
- https://app.quicktype.io/
- https://www.w3.org/TR/activitypub/
- https://docs.joinmastodon.org/client/public/

### Working with the JSON
- https://swiftsenpai.com/testing/implemented-http-request-helper-without-server/
- https://jsonformatter.org/

### Rendering HTML in the UI
WARNING: Using `NSAttributedStrings` in a scrolling view, even when passed off to an `AttributedString` can crash the program if an .id(UUID()) is not used on the view. Which view need the `.id` exactly seems to change depending on the exact scenario.  
- https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-html-string-into-a-wkwebview-or-uiwebview-loadhtmlstring
- https://developer.apple.com/forums/thread/682431
- https://developer.apple.com/forums/thread/677823
- https://developer.apple.com/documentation/foundation/attributedstring
- https://wwdcbysundell.com/2021/a-first-look-at-attributed-string/
- https://www.kodeco.com/29501177-attributedstring-tutorial-for-swift-getting-started
- https://www.hackingwithswift.com/quick-start/swiftui/how-to-open-web-links-in-safari
- https://stackoverflow.com/questions/56892691/how-to-show-html-or-markdown-in-a-swiftui-text
- https://stackoverflow.com/questions/72689505/attributegraph-precondition-failure-setting-value-during-update-when-using-nsat
- https://stackoverflow.com/questions/59889020/how-to-use-an-nsattributedstring-with-a-scrollview-in-swiftui

### AsyncImage
- https://developer.apple.com/documentation/swiftui/asyncimage
- https://wwdcbysundell.com/2021/using-swiftui-async-image/
- https://www.hackingwithswift.com/quick-start/swiftui/how-to-load-a-remote-image-from-a-url
- https://www.hackingwithswift.com/books/ios-swiftui/loading-an-image-from-a-remote-server

### Misc
- https://www.hackingwithswift.com/books/ios-swiftui/how-to-use-gestures-in-swiftui
- https://www.hackingwithswift.com/books/ios-swiftui/animating-gestures
- https://www.hackingwithswift.com/books/ios-swiftui/fixing-bookworm


## Release History

Current State: Wouldn't exactly call it "released".

* 0.0.0.0 - "hello_world"
    *  current state of main



[swift-image]:https://img.shields.io/badge/swift-5.7-orange.svg
[swift-url]: https://swift.org/
