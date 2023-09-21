
_**Attention**: This instruction note is written for the **developers** of this framework project reference. If you want to know the further information about how to **use** the generated framework build, please reference the **readme.md** instruction file._


## Support Related
Build by XCode Version 12.1 (12A7403)

Written by swift4

Coding style check by [SwiftLint](https://github.com/realm/SwiftLint)

## About preparation before develop with the code
Please meke sure the **SwiftLint** have been installed in your machine, if not, please install this coding style check plug-in with the cmd line below:

```
brew install swiftlint
```

## About Generate Framework
Start from the version `2.0` , we have upgraded the build script and applied it in the `Post-action` of the `Archive` step in the framework scheme, the developer easily can get the framework applicable to Cocoapods distribution platform witht he following steps:

1. Developer should make sure the project can successfully build/run the code
2. Make the target "PulseInsights" conduct **Archive** with the build obj **Any iOS Device (armv7, arm64)**
3. After completed **Archive** step, the folder will be popup in few seconds, and you can find the framework folder **PulseInsights.framework** been created in the folder `${project path}/Develop/` 

## After Generated the Framework
Please check the `Steps of the whole flow` section in the wiki document for the detail, the developer should finish the following steps before claim the new version has been released
- Upload the zippped framework folder to AWS bucket
- Verify if the upload file can be access/download via browser with the format url
- Update the `Develop/PulseInsights.podspec` with the `s.version` and `s.source`
- Push the podspec with pod cmd to cocoapods master
- Verify if the test project `Podtest` can download and config the updated framework with the pod script