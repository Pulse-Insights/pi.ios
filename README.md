# Pulse Insights iOS SDK

## Installation

To install Pulse Insights in your application, follow these steps:

### Version 2.0 or later

> Please go through the [uninstall flow](#remove_1.0.8_or_earlier) if you have installed 1.0.8 or the earlier version

1. Add the following line in `Podfile` 

```
pod 'PulseInsights'
```

2. Execute the cmd `pod install` to download and set up the SDK 
3. Find the generated `.xcworkspace` and open it in Xcode

### Version 1.0.8 or earlier

1. Open the Project Navigator in XCode, drag the .framework package into your project
2. Open the Project Editor in XCode, and select the target of your app
3. Go to the **General** tab, and find out **Embedded Binaries** section, add the framework item you just added inside the navigator

Note that the earliest supported deployment target for this library is iOS 9.0.

## Upgrading

To upgrade the library, simply overwrite the .framework package with the newer version.

## Usage

### 1. Initialization

First, configure the shared PulseInsights object inside AppDelegate. You’ll do the following:

* Include the necessary headers.
* Setup the PulseInsights object inside didFinishLaunchingWithOptions.
* Replace YOUR_ACCOUNT_ID with your own PulseInsights ID, for example PI-12345678.

First add PulseInsights inside `AppDelegate`:

```swift4.2
import PulseInsights
```

Then, override the `didFinishLaunchingWithOptions` method:

```swift4.2
// Optional: set enableDebugMode to true for debug information.

let pi:PulseInsights = PulseInsights(YOUR_ACCOUNT_ID, enableDebugMode:[Bool value])
```

### 2. View tracking

PulseInsights allows targeting surveys to a given screen name. In order for the SDK to know the current screen name, you can use the following method to notify  it of the current screen name change:

```swift4.2
PulseInsights.getInstance.setViewName(viewName:String,
controller:UIViewController)
```

For example, you can override the viewDidAppear function on the UIViewController subclass:

```swift4.2
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    PulseInsights.getInstance.setViewName("MainView", controller: self)
}
```

### 3. Survey polling

The PulseInsights SDK will automatically regularly fetch surveys that would match various targeting conditions, based on a frequency that you can override as shown below:

```swift4.2
PulseInsights.getInstance.setScanFrequency(setFrequencyInSecond :NSInteger)
```

If you want to manually fetch new surveys, you can also use this method:

```swift4.2
PulseInsights.getInstance.serve()
```

### 4. Render a specific survey

It's also possible to manually trigger a survey by its id:

```swift4.2
PulseInsights.getInstance.present(surveyID:String)
```  

### 5. Inline surveys

Inline surveys are rendered within the content of the application, instead of overlaying the application content.

In order to integrate inline surveys, you can programmatically create the `InlineSurveyView` object by assigning an identifier and inserting it into a view:

```swift4.2
var inlineSurveyView:InlineSurveyView?

inlineSurveyView = InlineSurveyView(identifier: String)

self.view.addSubview(inlineSurveyView)
```

If you integrate `InlineSurveyView` with the nib/xib, you can assign the tracking identifier by using the method `setIdentifier`

```swift4.2
override func viewDidLoad() {
        super.viewDidLoad()
        inlineSurveyView?.setIdentifier(className: String) // assume the inlineSurveyView have been initialized
}
```

Here's another example of assigning the identifier for the inline view from xib

```swift4.2
@IBOutlet weak var inlineXibView: InlineSurveyView! {
        didSet {
            inlineXibView?.setIdentifier("InlineXib")
        }
    }
```

If you prefer, setup the identifier with the nib layout, as the following screenshot shows. You can find the `Identifier` attribute from the Xcode interface

![Xcode interface](Develop/res/pi-inline-nib.png "Identifier")

### 6. Survey rendering

You can pause and resume the survey rendering feature with the following method:

```swift4.2
PulseInsights.getInstance.switchSurveyScan(boolean enable);
```

And check the current configuration with the following method:
- true: survey rendering feature is enabled
- false: survey rendering feature is paused

```swift4.2
var renderingConfig: Bool = PulseInsights.getInstance.isSurveyScanWorking();
```

It's also possible to pause the survey rendering from the initialization of the Pulse Insights library:

```swift4.2
let pi:PulseInsights = PulseInsights(YOUR_ACCOUNT_ID, automaticStart: ${Bool value})
```

### 7. Client Key

Client key can be setup using this method:
```swift4.2
PulseInsights.getInstance.setClientKey(_ clientId: String )
```

The configured client key can be fetched with this method:
```swift4.2
let getKey: String = PulseInsights.getInstance.getClientKey()
```

### 8. Preview mode

Preview mode can be enabled/disabled by:
```
Shaking the device more than 10-times in 3-seconds
```

Preview mode can be programmatically enabled/disabled by this method:
```swift4.2
PulseInsights.getInstance.setPreviewMode(_ enable: Bool)
```

It's also possible to set preview mode from the initialization of the Pulse Insights library:
```swift4.2
let pi:PulseInsights = PulseInsights(_ accountID:String, enableDebugMode:Bool = false, previewMode:Bool = false)
```

In order to check the status of preview mode, use this method:
```swift4.2
let isPreviewModeOn: Bool = PulseInsights.getInstance.isPreviewModeOn()
```

### 9. Callbacks

If you want to know if a survey has been answered by the current device, this method can be used:
```swift4.2
let isSurveyAnswered: Bool = PulseInsights.getInstance.checkSurveyAnswered(_ surveyId: String )
```

It's also possible to configure a callback to be executed when a survey has been answered:

```swift4.2
class ViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()
      PulseInsights.getInstance.setSurveyAnsweredListener(self)
    }

}
extension ViewController: SurveyAnsweredListener {
    func onAnswered(_ answerId: String) {

    }
}
```

### 10. Context data

You can save context data along with the survey results, or for a refined survey targeting, using the `customData` config attribute, for example:

```Swift4.2
let pi:PulseInsights = PulseInsights(YOUR_ACCOUNT_ID, customData: ["gender": "male", "age": "32", "locale": "en-US"])
```

### 11. Device data

If you want to set device data, which will be saved along the survey results, the method `setDeviceData` can be used as follows:

```Swift4.2
PulseInsights.getInstance.setDeviceData(dictData:[String: String]())
```

`setDeviceData` can be called at any time. It will trigger a separate network request to save the data.

### 12. Advanced usage

The default host is "survey.pulseinsights.com". If you want to target the staging environment, or any other environment, it's possible to override the default host:

```swift4.2
PulseInsights.getInstance.setHost(hostName:String)
```

The debug mode can be turned on and off:

```swift4.2
PulseInsights.getInstance.setDebugMode(enable:Bool)
```

PulseInsights creates a unique UDID to track a given device. If you wish to reset this UDID, you can call the following method:

```swift4.2
PulseInsights.getInstance.resetUdid()
```

If you want manually config the view controller, you can call the following method:

```swift4.2
PulseInsights.getInstance.setViewController(ontroller: UIViewController)
```

And get the view controller object that has been configured.

```swift4.2
let viewController: UIViewController = PulseInsights.getInstance.getViewController()
```


## Uninstall

### Remove 2.0 or later

1. Remove the following statement from your `Podfile`

```
pod 'PulseInsights'
```

2. Execute `pod install` , so the SDK will be removed

### Remove 1.0.8 or earlier

In order to remove the library from your project:

1. Open the **Project Editor** in XCode, and select the target of your app
2. Go through **General** and **Build Phases** remove all PulseInsights.framework items you find
3. Back to **Project Navigator** of your app, remove the PulseInsights.framework items
