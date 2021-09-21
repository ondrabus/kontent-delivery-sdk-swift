# Kontent Delivery SDK

[![Stack Overflow](https://img.shields.io/badge/Stack%20Overflow-ASK%20NOW-FE7A16.svg?logo=stackoverflow&logoColor=white)](https://stackoverflow.com/tags/kentico-kontent)
[![CocoaPods](https://img.shields.io/cocoapods/v/KenticoKontentDelivery.svg)](https://cocoapods.org/pods/KenticoKontentDelivery)
[![CocoaPods](https://img.shields.io/cocoapods/p/KenticoKontentDelivery.svg)](https://cocoapods.org/pods/KenticoKontentDelivery)

## Summary
The Kontent Delivery SDK is a library used for retrieving content from [Kontent by Kentico](https://kontent.ai). You can use the SDK as a CocoaPod package or add it manually.

### Sample app
The repository contains sample app which demonstrates basic usage of the SDK. It displays content from a Sample Project that demonstrates Kontent features and best practices. This fully featured project contains marketing content for Dancing Goat – an imaginary chain of coffee shops. If you don't have your own Sample Project, any admin of a Kontent subscription [can generate one](https://docs.kontent.ai/tutorials/set-up-projects/manage-projects/managing-projects#a-creating-a-sample-project). 

<img src="https://github.com/Kentico/kontent-delivery-sdk-swift/blob/master/SampleAppScreens/splashScreens.png?raw=true" width="212"> <img src="https://github.com/Kentico/kontent-delivery-sdk-swift/blob/master/SampleAppScreens/ourBeans.png?raw=true" width="212"> <img src="https://github.com/Kentico/kontent-delivery-sdk-swift/blob/master/SampleAppScreens/ourBeans.png?raw=true" width="212"> <img src="https://github.com/Kentico/kontent-delivery-sdk-swift/blob/master/SampleAppScreens/locations.png?raw=true" width="212">

## Quick start

**1. Add a pod**  

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'KenticoKontentDelivery'
end
```

```bash
$ pod install
```

**2. Create a type object** - in this example, the type object is `Article`. It represents a Content type in Kontent that the retrieved content items are based on. This content type has three elements with following codenames: `title` (a text element),`teaser_image` (an asset element) and `post_date` (a DateTime element).
```swift
import ObjectMapper
import KenticoKontentDelivery

class Article: Mappable {
    var title: TextElement?
    var asset: AssetElement?
    var postDate: DateTimeElement?
    
    required init?(map: Map){
        let mapper = MapElement.init(map: map)
        title = mapper.map(elementName: "title", elementType: TextElement.self)
        asset = mapper.map(elementName: "teaser_image", elementType: AssetElement.self)
        postDate = mapper.map(elementName: "post_date", elementType: DateTimeElement.self)
    }
    
    func mapping(map: Map) {
    }
}
 ```
 
**3. Prepare the Delivery client**

```swift
import KenticoKontentDelivery

let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
 ```
 
**4. Prepare a query**

```swift
let articlesQueryParameters = QueryBuilder.params().type(article).language("es-ES")
 ```
 
**5. Get and use content items**

```swift
client.getItems(modelType: Article.self, queryParameters: articleQueryParameters) { (isSuccess, itemsResponse, error) in
    if isSuccess {
        if let articles = itemsResponse?.items {
            // use your articles here
        }
    } else {
        if let error = error {
            print(error)
        }
    }
}
 ```

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Kontent into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'KenticoKontentDelivery'
end
```

Then, run the following command:

```bash
$ pod install
```
 
## Using the DeliveryClient

The `DeliveryClient` class is the main class of the SDK for getting content. Using this class, you can retrieve content from your Kontent projects.

To create an instance of the class, you need to provide a [project ID](https://docs.kontent.ai/tutorials/develop-apps/get-content/getting-content#section-getting-content-items):

```swift
// Initializes an instance of the DeliveryClient client
let client = DeliveryClient.init("975bf280-fd91-488c-994c-2f04416e5ee3")
```

Once you create a `DeliveryClient`, you can start querying your project repository by calling methods on the client instance. See [Basic querying](#basic-items-querying) for details.

### Previewing unpublished content

To retrieve unpublished content, you need to create a `DeliveryClient` with both Project ID and Preview API key. Each Kontent project has its own Preview API key. 

```swift
import KenticoKontentDelivery

let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID", previewApiKey:"PREVIEW_API_KEY")
```

For more details, see [Previewing unpublished content using the Delivery API](https://docs.kontent.ai/tutorials/develop-apps/get-content/configuring-preview-for-content-items#a-set-up-content-preview-in-your-project).

### Getting content from secured project

To retrieve content from secured project, you need to create a `DeliveryClient` with both Project ID and Secure API key. 

```swift
import KenticoKontentDelivery

let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID", secureApiKey:"SECURE_API_KEY")
```

For more details, see [Securing the Delivery API](https://docs.kontent.ai/reference/kentico-kontent-apis-overview#secure-access).

### Configuring retry policy

The client can retry getting items after it encounters errors. By default, the retry policy is enabled, and the maximum retry attempts is 5.
You can configure the maximum retry attempts when creating a `DeliveryClient`.

```swift
import KenticoKontentDelivery

let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID", isRetryEnabled: true, maxRetryAttempts: CUSTOM_MAX_ATTEMPTS_NUMBER)
```

You can also disable the retry policy.

```swift
import KenticoKontentDelivery

let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID", isRetryEnabled: false)
```
 
## Getting items

### Using strongly typed models

In order to receive strongly typed items you need to implement your item model. It's necessary to conform to `Mappable` protocol and implement mapping functionality. You can use your own mapping or our strongly typed element types.

- Element types mapping:
```swift
import ObjectMapper

class Article: Mappable {
    var title: TextElement?
    var asset: AssetElement?
    var postDate: DateTimeElement?
    
    required init?(map: Map){
        let mapper = MapElement.init(map: map)
        title = mapper.map(elementName: "title", elementType: TextElement.self)
        asset = mapper.map(elementName: "teaser_image", elementType: AssetElement.self)
        postDate = mapper.map(elementName: "post_date", elementType: DateTimeElement.self)
    }
    
    func mapping(map: Map) {

    }
 ```
 
 - Custom mapping:
```swift
import ObjectMapper

public class Cafe: Mappable {
    public var city: String?
    public var street: String?
    public var country: String?
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        city <- map["elements.city.value"]
        street <- map["elements.street.value"]
        country <- map["elements.country.value"]
    }
 ```
 
### Basic items querying

Once you have a `DeliveryClient` instance, you can start querying your project repository by calling methods on the instance. You need to pass your item model and query. You can create a query for a listing in two ways:
- creating a custom string query:
```swift
let customQuery = "items?system.type=article&order=elements.post_date[desc]"
client.getItems(modelType: Article.self, customQuery: customQuery) { (isSuccess, itemsResponse, error) in ...
 ```
 - using a query parameters array:
 ```swift
let coffeesQueryParameters = QueryBuilder.params().type(contentType).language("es-ES")
client.getItems(modelType: Coffee.self, queryParameters: coffeesQueryParameters) { (isSuccess, itemsResponse, error) in ...
 ```
 
 Then you can use your obtained items in the completetion handler:
 
 ```swift
 // Retrieves a list of all content items of certain type
let coffeesQueryParameters = QueryBuilder.params().type("coffee")
client.getItems(modelType: Coffee.self, queryParameters: coffeesQueryParameters) { (isSuccess, itemsResponse, error) in
        if isSuccess {
            if let coffees = itemsResponse?.items {
                // Use your items here
            }
        } else {
            if let error = error {
                print(error)
            }
        }
```

You can also retrieve just a single item:

```swift
// Retrieves a single content item
let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
client.getItem(modelType: Cafe.self, itemName: "boston") { (isSuccess, deliveryItem, error) in
    if isSuccess {
        if let cafe = deliveryItem.item {
            // Use your item here
        }
    } else {
        if let error = error {
            print(error)
        }
    }
}
```

### Getting linked items

You can get linked content items from `itemResponse` or `itemsResponse` object:
```swift
let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
client.getItem(modelType: Article.self, itemName: "on_roasts", completionHandler: { (isSuccess, itemResponse, error) in
    if isSuccess {
        for articleCodeName in (itemResponse?.item?.relatedArticles?.value)! {
                    let relatedArticle = itemResponse?.getLinkedItems(codename: articleCodeName, type: Article.self)
            }
    }
}
                            
                         
```

## Getting content types

### Get one content type

```swift
client.getContentType(name: "coffee", completionHandler: { (isSuccess, contentType, error) in
    if !isSuccess {
        fail("Response is not successful. Error: \(String(describing: error))")
    }
    
    if let type = contentType {
    // use content type here
    }
})
```

### Get multiple content types

```swift
client.getContentTypes(skip: 2, limit: 4, completionHandler: { (isSuccess, contentTypesResponse, error) in
    if !isSuccess {
        fail("Response is not successful. Error: \(String(describing: error))")
    }
    
    if let response = contentTypesResponse {
    // use content types here
    }
})
```

## Getting taxonomies

### Get taxonomy group

```swift
let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
client.getTaxonomyGroup(taxonomyGroupName: "personas", completionHandler: { (isSuccess, deliveryItem, error) in
   if isSuccess {
       if let taxonomyGroup = deliveryItems.item {
        // use your taxonomy group here
       }
    } else {
         if let error = error {
             print(error)
         }
    }
})
```

### Get all taxonomies

```swift
let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
client.getTaxonomies(completionHandler: { (isSuccess, deliveryItems, error) in
   if isSuccess {
       if let taxonomies = deliveryItems?.items {
        // use your taxonomies here
       }
    } else {
         if let error = error {
             print(error)
         }
    }
})
```

## Use image transformation

Kontent supports image transformation by using URL parameters. A helper class is provided to create the URL conveniently.

However, see our [documentation on image transformation](https://docs.kontent.ai/reference/image-transformation) to understand the restriction of parameters before using the helper class, as the helper class does not validate the input parameters.

Here is a sample usage:

```swift
let originalUrl = "https://example.com/sample-image.jpg"
let transformedUrl = ImageUrlBuilder(baseUrl: originalUrl)
                        .withWidth(300)
                        .withHeight(500)
                        .withFitMode(.Clip)
                        .withDpr(3)
                        .withBackGroundColor(rgbColor: 0x330FAA)
                        .withFormat(.png)
                        .url
// transformedUrl = https://example.com/sample-image.jpg?w=300&h=500&fit=clip&dpr=3.0&bg=330FAA&fm=png
```

## Local Development

For running SDK with sample app locally follow the next steps.

1. Download the repository.
1. In terminal navigate to */Example*.
1. Run `pod install` ([Cocoapods](https://cocoapods.org/) must be installed).
1. Open `KenticoKontentDelivery.xcworkspace` in XCode.
1. Run.

## Debug

If you want to view debug info from both clients set client's `enableDebugLogging` attribute:
```swift
let deliveryClient = DeliveryClient.init(projectId: "YOUR_PROJECT_ID", enableDebugLogging = true)
```

## Releasing a new version of the Cocoapod package

1. Update tracking header `X-KC-SDKID`.
1. Update `s.version` in `.podspec`.
1. Create a new release with a new tag.
1. GitHub Actions automatically builds and releases a new version of the pod when added new tag.

## Documentation

You can find full API reference documentation [here](https://kentico.github.io/kontent-delivery-sdk-swift/index.html).

## Updating generated documentation

We use Jazzy which is a command-line utility that generates documentation for Swift. For updating documentation perform the next steps:

1. Install Jazzy `[sudo] gem install jazzy`
1. Run `jazzy` from the root of the repository.
1. Commit changes from */Docs* directory.

## Further information

For more developer resources, visit the Kontent tutorials at <https://docs.kontent.ai/tutorials/develop-apps>.

## Feedback & Contributing

Check out the [contributing](https://github.com/Kentico/kontent-delivery-sdk-swift/blob/master/CONTRIBUTING.md) page to see the best places to file issues, start discussions, and begin contributing.

## License

Kontent Delivery SDK is available under the MIT license. See the LICENSE file for more information.

