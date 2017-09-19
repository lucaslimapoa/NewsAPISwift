# NewsAPISwift

[![CI Status](http://img.shields.io/travis/lucaslimapoa/NewsAPISwift.svg?style=flat)](https://travis-ci.org/lucaslimapoa/NewsAPISwift)
[![Version](https://img.shields.io/cocoapods/v/NewsAPISwift.svg?style=flat)](http://cocoapods.org/pods/NewsAPISwift)
[![License](https://img.shields.io/cocoapods/l/NewsAPISwift.svg?style=flat)](http://cocoapods.org/pods/NewsAPISwift)
[![Platform](https://img.shields.io/cocoapods/p/NewsAPISwift.svg?style=flat)](http://cocoapods.org/pods/NewsAPISwift)
[![codebeat badge](https://codebeat.co/badges/bf6f15c8-5844-4d0b-85ff-0e50d1c51176)](https://codebeat.co/projects/github-com-lucaslimapoa-newsapiswift-master)

NewsAPISwift is a Swift wrapper around [NewsAPI.org](http://newsapi.org), a service that provides articles and headlines from more than 70 sources.

*NOTE: This library and its author are not endorsed by or affiliated with NewsApi.org.*

## Usage

NewsAPI offers two endpoints to which sources and articles can be requested. 

### Sources
The first endpoint is used for listing all available sources and three parameters can be used to sort the results.

| Parameter | Description |
| --------- | ----------- |
| **Category**  | The category you would like to get sources for. The possible values are: `business`, `entertainment`, `gaming`, `general`, `music`, `politics`, `scienceAndNature`, `sport` and `technology`. |
| **Language**  | The language you would like to get sources for. The possible values are: `english`, `deutsch` and `french`. |
| **Country**   | The country you would like to get sources for. The possible values are: `australia`, `germany`, `unitedKingdom`, `india`, `italy` and `unitedStates`.


#### Example

```swift
import NewsAPISwift

let newsAPI = NewsAPI(key: "YourKeyHere")

newsAPI.getSources(category: Category.gaming, language: Language.english, country: Country.unitedStates) { result in
    switch result {
    case .success(let sources):
        // Handle success case
    case .error(let error):
        // Handle error case
    }
}
```

### Articles
The second endpoint is used for listing articles and headlines from a given Source. One parameter can be used for sorting the results.

| Parameter | Description |
| --------- | ----------- |
| **SourceId** | This is the id of the source you want to get articles from. This data is found in `NewsAPISource.id`. |
| **SortBy**  | The sort type you would like to get the articles. The possible values are: `top`, `latest` and `popular`. |

#### Example

```swift
import NewsAPISwift

let newsAPI = NewsAPI(key: "YourKeyHere")

newsAPI.getArticles(sourceId: "SourceId", sortBy: SortBy.popular) { result in
switch result {
    case .success(let articles):
        // Handle success case
    case .error(let error):
        // Handle error case
    }
}
```

## Example Application

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

NewsAPISwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NewsAPISwift"
```

## License

NewsAPISwift is available under the MIT license. See the LICENSE file for more info.
