# Story App

This app includes the main features of Instagram Stories.

## Technical specification

Language: Swift 5
Frameworks: SwiftUI
Minimum iOS deployment version: iOS 17.0

## Project Architecture
The project is based on MVVM architecture. The various data consumed by the ViewModels come from two repositories : StoryRepository and UserRepository. These repositories are protocol and are injected into the ViewModels.

## Improvement

- We don't have any unit tests on this project which is not great. This is a huge point that should be solved.
- We should also migrate this project in Swift 6 in order to be sure that there is any concurrency issues.
- In the app, the way that images are loaded is not perfect. In fact, the user experience can be affected if there is a bad network for example. A solution to this problem is to provide a caching system for assets. Moreover, when displaying stories, we can load all images in background to smoothen the different transition.
- Finally, there is a lack of gestures in the detail screen. For example, user should be able to long press on the screen to hide/display the buttons over the image.
