# PaymentSDK

## Usage

### Use payload from notification

```swift
  let payload: [AnyHashable: Any] = ...

  do {
      try PaymentService.shared.openPayment(with: payload)
  } catch {
      debugPrint(error.localizedDescription)
  }
```

### Use url from notification payload

```swift
  guard let url = URL(string: "any payment url") else { return }

  do {
      try PaymentService.shared.openPayment(with: url)
  } catch {
      debugPrint(error.localizedDescription)
  }
```
### Use custom webview or SFSafariViewController

```swift
  PaymentService.shared.defaultBrowser = true // for SFSafariViewController
```
default value ```false```

### Error

```swift
enum PaymentServiceError: Error {
    case invalidateURL
    case invalidateUserInfo
}
```

## Installation

### Using [CocoaPods](https://cocoapods.org):

Simply add the following line to your Podfile:

```ruby
pod "PaymentSDK", :git => "https://github.com/llo8/PaymentSDK.git"
```

### Using [Swift Package Manager (SPM)](https://github.com/apple/swift-package-manager):

```Select File ▸ Swift Packages ▸ Add Package Dependency… and paste the Git repository```
