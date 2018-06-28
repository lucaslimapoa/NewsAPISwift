# NewsAPISwift

[![CI Status](http://img.shields.io/travis/lucaslimapoa/NewsAPISwift.svg?style=flat)](https://travis-ci.org/lucaslimapoa/NewsAPISwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/NewsAPISwift.svg?style=flat)](http://cocoapods.org/pods/NewsAPISwift)
[![License](https://img.shields.io/cocoapods/l/NewsAPISwift.svg?style=flat)](http://cocoapods.org/pods/NewsAPISwift)
[![Platform](https://img.shields.io/cocoapods/p/NewsAPISwift.svg?style=flat)](http://cocoapods.org/pods/NewsAPISwift)
[![codecov](https://codecov.io/gh/lucaslimapoa/NewsAPISwift/branch/master/graph/badge.svg)](https://codecov.io/gh/lucaslimapoa/NewsAPISwift)
[![codebeat badge](https://codebeat.co/badges/bf6f15c8-5844-4d0b-85ff-0e50d1c51176)](https://codebeat.co/projects/github-com-lucaslimapoa-newsapiswift-master)

NewsAPISwift is a Swift client for [News API V2](http://newsapi.org), a service that provides breaking news headlines, and search for articles from over 30,000 news sources and blogs.

## Usage

NewsAPISwift offers two functions to which sources and top headlines can be requested.

### Sources
The first functions is used for listing all available sources indexed by the service.
Three parameters can be passed in order to filter results.

| Parameter | Description |
| --------- | ----------- |
| **Category**  | The category you would like to get sources for. The possible values are: `business`, `entertainment`, `general`, `health`, `science`, `sports`, `technology`. *Default: all categories.*|
| **Language**  | The language you would like to get sources for. The possible values are: `ar`, `de`, `en`, `es`, `fr`, `he`, `it`, `nl`, `no`, `pt`, `ru`, `se`, `ud`, `zh`. *Default: all languages.*|
| **Country**   | The country you would like to get sources for. To get the full list of supported countries, please head to the official [documentation](https://newsapi.org/docs/endpoints/sources). *Default: all countries.*

#### Example

```swift
import NewsAPISwift

let newsAPI = NewsAPI(apiKey: "YourKeyHere")

newsAPI.getSources(category: .technology, language: .en, country: .us) { result in
    switch result {
    case .success(let sources):
        // Do something with returned sources
    case .failure(let error):
        // Handle error
    }
}
```

### Top Headlines
The second function is used for listing top headlines. It is possible to request headlines for a specific country, a single or multiple sources, as well as keywords.

To get a full list of supported parameters, check the official [documentation](https://newsapi.org/docs/endpoints/sources) for the service.

#### Example

Top Headlines about the weather:
```swift
import NewsAPISwift

let newsAPI = NewsAPI(apiKey: "YourKeyHere")

newsAPI.getTopHeadlines(q: "weather") { result in
    switch result {
    case .success(let headlines):
        // Do something with returned headlines
    case .failure(let error):
        // Handle error
    }
}
```

Top Headlines from BBC News:
```swift
newsAPI.getTopHeadlines(sources: ["bbc-news"]) { result in
    switch result {
    case .success(let headlines):
        // Do something with returned headlines
    case .failure(let error):
        // Handle error
    }
}

```

Top Headlines from the US about technology:
```swift        
newsAPI.getTopHeadlines(category: .technology, country: .us) { result in
    switch result {
    case .success(let headlines):
        // Do something with returned headlines
    case .failure(let error):
        // Handle error
    }
}

```

It is also possible to limit the number of articles returned by passing the *pageSize* parameter. Since there could be more results, pagination is also possible.

```swift
newsAPI.getTopHeadlines(pageSize: 20, page: 1) { result in
    switch result {
    case .success(let headlines):
        // Do something with returned headlines
    case .failure(let error):
        // Handle error
    }
}

```

## Example Application

To run the example project, clone the repo, and run `pod install` from the Example directory first. Then, open **Example.xcworkspace** and run the project.

## Installation

#### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate NewsAPISwift into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'NewsAPISwift'
end
```

Then, run the following command:

```
$ pod install
````

#### Carthage
Carthage is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with Homebrew using the following command:

```
$ brew update
$ brew install carthage
```

To integrate NewsAPISwift into your Xcode project using Carthage, specify it in your Cartfile:

```
github "lucaslimapoa/NewsAPISwift"
```

Run the following command to build the framework:

```
carthage update
```

Then, drag the built NewsAPISwift.framework into your Xcode project.

## License

NewsAPISwift is available under the MIT license. See the LICENSE file for more info.

*NOTE: This library and its author are not endorsed by or affiliated with newsapi.org.*
