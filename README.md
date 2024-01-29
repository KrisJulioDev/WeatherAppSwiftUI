# WeatherAppSwiftUI
A sample project showcasing weather app using Swift UI in MVVM + Clean Architecture 


<img width="912" alt="Screenshot 2024-01-19 at 6 54 23 PM" src="https://github.com/KrisJulioDev/WeatherAppSwiftUI/assets/8087709/471ec5f0-441c-45d7-96c9-4ac496f9242d">

<img width="905" alt="Screenshot 2024-01-19 at 6 56 09 PM" src="https://github.com/KrisJulioDev/WeatherAppSwiftUI/assets/8087709/44b3ea57-22c7-4c82-bc8a-df34503c3820">

# Requirement:
 - iOS 17
 - XCode

# To Install:
`git clone https://github.com/KrisJulioDev/WeatherAppSwiftUI.git`

# Schemes
`WeatherAppFeed scheme` is a framework that is platform agnostic of iOS and the tests included here runs on mac catalyst. Testing on mac is much faster than with the simulator since we it does not need to wait for the simulator to open up.
`WeatherAppFeediOS scheme` is an iOS framework module, integrated with some UI using SwiftUI framework hence tests must run in iOS simulator
`WeatherAppFeedEndToEndTests scheme` is an end to end tests or App to Server tests. Runs on Mac
Finally, `WeatherApp scheme` is the one to use when running the whole app integrated with all the frameworks. Run on simulator or device

# Tests Includes
- CoreData Local caching tests
- URLHTTPSession tests using ProtocolStub
- Openweather API Endpoint tests
- Data mapping tests
- End to end tests
