Who’s who App 
Tomasz Wyszomirski
tomek.wyszomirski@gmail.com

The app works on iOS6, 6.1, 7 on iPhones, iPads, iPod touches. No support for native iPad resolution although it’d work as expected on both widescreen and ‘old’ iPhones/iPod Touches. 

Required functionality has been fully covered. 

Chosen approach relays on parsing http://theappbusiness.net/people/ webpage using NSXMLParser. Would be easier to use a library which supports html parsing out of the box (like hpple). Choosing xml parser meant the app converts part of the page source to proper xhtml (closing img, br tags).

Of course in real life we’d just use a REST API instead of parsing html page. 

Html parsing and network requests are being made in background, image fetch calls are canceled when cell is no longer visible. 

Error handling is limited to console logs, no alert views, etc. 

No fancy build steps required - just XCode 5 (or 4.6) will suffice.
