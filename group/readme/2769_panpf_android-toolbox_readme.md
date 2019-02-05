# ![logo_image] Android Toolbox

![Platform][platform_image]
[![API][min_api_image]][min_api_link]
[![Release Version][release_version_image]][release_version-link]

### 【Deprecated】已弃用，请使用 [androidx](https://github.com/panpf/androidx)

这是一个 Android 工具类库，含大量在 Android 开发中经常用到的工具类或方法，旨在让 Android 开发变得更简单！

## 工具列表

### Android
* app
    * [DialogUtils.java](tool4a/src/main/java/me/panpf/tool4a/app/DialogUtils.java)
    * [DownloadManagerUtils.java](tool4a/src/main/java/me/panpf/tool4a/app/DownloadManagerUtils.java)
    * [FragmentBuilder.java](tool4a/src/main/java/me/panpf/tool4a/app/FragmentBuilder.java)
    * [FragmentListPagerAdapter.java](tool4a/src/main/java/me/panpf/tool4a/app/FragmentListPagerAdapter.java)
    * [FragmentUtils.java](tool4a/src/main/java/me/panpf/tool4a/app/FragmentUtils.java)
    * [MessageDialogFragment.java](tool4a/src/main/java/me/panpf/tool4a/app/MessageDialogFragment.java)
    * [ProgressDialogFragment.java](tool4a/src/main/java/me/panpf/tool4a/app/ProgressDialogFragment.java)
    * [SimpleFragmentPagerAdapter.java](tool4a/src/main/java/me/panpf/tool4a/app/SimpleFragmentPagerAdapter.java)
    * [SimpleFragmentStatePagerAdapter.java](tool4a/src/main/java/me/panpf/tool4a/app/SimpleFragmentStatePagerAdapter.java)

* content
    * [BroadcastUtils.java](tool4a/src/main/java/me/panpf/tool4a/content/BroadcastUtils.java)
    * [ContentUtils.java](tool4a/src/main/java/me/panpf/tool4a/content/ContentUtils.java)
    * [FileUtils.java](tool4a/src/main/java/me/panpf/tool4a/content/FileUtils.java)
    * [IntentUtils.java](tool4a/src/main/java/me/panpf/tool4a/content/IntentUtils.java)
    * [LaunchAppReceiver.java](tool4a/src/main/java/me/panpf/tool4a/content/LaunchAppReceiver.java)
    * [UriUtils.java](tool4a/src/main/java/me/panpf/tool4a/content/UriUtils.java)

* content.pm
    * [VersionManager.java](tool4a/src/main/java/me/panpf/tool4a/content/pm/VersionManager.java)

* content.res
    * [AssetUtils.java](tool4a/src/main/java/me/panpf/tool4a/content/res/AssetUtils.java)
    * [DimenUtils.java](tool4a/src/main/java/me/panpf/tool4a/content/res/DimenUtils.java)

* graphics
    * [BitmapDecoder.java](tool4a/src/main/java/me/panpf/tool4a/graphics/BitmapDecoder.java)
    * [BitmapUtils.java](tool4a/src/main/java/me/panpf/tool4a/graphics/BitmapUtils.java)
    * [Colors.java](tool4a/src/main/java/me/panpf/tool4a/graphics/Colors.java)
    * [ImageProcessor.java](tool4a/src/main/java/me/panpf/tool4a/graphics/ImageProcessor.java)
    * [RectUtils.java](tool4a/src/main/java/me/panpf/tool4a/graphics/RectUtils.java)
    * [TextUtils.java](tool4a/src/main/java/me/panpf/tool4a/graphics/TextUtils.java)

* graphics.drawable
    * [DrawableLevelController.java](tool4a/src/main/java/me/panpf/tool4a/graphics/drawable/DrawableLevelController.java)

* hardware
    * [DeviceUtils.java](tool4a/src/main/java/me/panpf/tool4a/hardware/DeviceUtils.java)

* hardware.camera
    * [BasePreviewAndPictureSizeCalculator.java](tool4a/src/main/java/me/panpf/tool4a/hardware/camera/BasePreviewAndPictureSizeCalculator.java)
    * [BestPreviewSizeCalculator.java](tool4a/src/main/java/me/panpf/tool4a/hardware/camera/BestPreviewSizeCalculator.java)
    * [CameraManager.java](tool4a/src/main/java/me/panpf/tool4a/hardware/camera/CameraManager.java)
    * [CameraUtils.java](tool4a/src/main/java/me/panpf/tool4a/hardware/camera/CameraUtils.java)
    * [LoopFocusManager.java](tool4a/src/main/java/me/panpf/tool4a/hardware/camera/LoopFocusManager.java)

* net
    * [NetworkUtils.java](tool4a/src/main/java/me/panpf/tool4a/net/NetworkUtils.java)

* os
    * [OSUtils.java](tool4a/src/main/java/me/panpf/tool4a/os/OSUtils.java)
    * [SDCardUtils.java](tool4a/src/main/java/me/panpf/tool4a/os/SDCardUtils.java)
    * [StatFsCompat.java](tool4a/src/main/java/me/panpf/tool4a/os/StatFsCompat.java)

* os.storage
    * [StorageUtils.java](tool4a/src/main/java/me/panpf/tool4a/os/storage/StorageUtils.java)

* preference
    * [PreferencesUtils.java](tool4a/src/main/java/me/panpf/tool4a/preference/PreferencesUtils.java)

* provider
    * [PhoneUtils.java](tool4a/src/main/java/me/panpf/tool4a/provider/PhoneUtils.java)
    * [SettingsUtils.java](tool4a/src/main/java/me/panpf/tool4a/provider/SettingsUtils.java)

* util
    * [ALog.java](tool4a/src/main/java/me/panpf/tool4a/util/ALog.java)
    * [BuildConfigUtils.java](tool4a/src/main/java/me/panpf/tool4a/util/BuildConfigUtils.java)
    * [Countdown.java](tool4a/src/main/java/me/panpf/tool4a/util/Countdown.java)
    * [DoubleClickDetector.java](tool4a/src/main/java/me/panpf/tool4a/util/DoubleClickDetector.java)
    * [DoubleClickExitDetector.java](tool4a/src/main/java/me/panpf/tool4a/util/DoubleClickExitDetector.java)
    * [InputMethodUtils.java](tool4a/src/main/java/me/panpf/tool4a/util/InputMethodUtils.java)
    * [InputVerifyUtils.java](tool4a/src/main/java/me/panpf/tool4a/util/InputVerifyUtils.java)
    * [LoopTimer.java](tool4a/src/main/java/me/panpf/tool4a/util/LoopTimer.java)
    * [MessageDigestUtils.java](tool4a/src/main/java/me/panpf/tool4a/util/MessageDigestUtils.java)
    * [OtherUtils.java](tool4a/src/main/java/me/panpf/tool4a/util/OtherUtils.java)
    * [RebootThreadExceptionHandler.java](tool4a/src/main/java/me/panpf/tool4a/util/RebootThreadExceptionHandler.java)

* view
    * [ViewListPagerAdapter.java](tool4a/src/main/java/me/panpf/tool4a/view/ViewListPagerAdapter.java)
    * [ViewRefreshHandler.java](tool4a/src/main/java/me/panpf/tool4a/view/ViewRefreshHandler.java)
    * [ViewUtils.java](tool4a/src/main/java/me/panpf/tool4a/view/ViewUtils.java)
    * [WindowUtils.java](tool4a/src/main/java/me/panpf/tool4a/view/WindowUtils.java)

* view.animation
    * [AnimationUtils.java](tool4a/src/main/java/me/panpf/tool4a/view/animation/AnimationUtils.java)
    * [ViewAnimationUtils.java](tool4a/src/main/java/me/panpf/tool4a/view/animation/ViewAnimationUtils.java)

* webkit
    * [WebViewManager.java](tool4a/src/main/java/me/panpf/tool4a/webkit/WebViewManager.java)

* widget
    * [CheckAdapter.java](tool4a/src/main/java/me/panpf/tool4a/widget/CheckAdapter.java)
    * [DepthPageTransformer.java](tool4a/src/main/java/me/panpf/tool4a/widget/DepthPageTransformer.java)
    * [NestedGridView.java](tool4a/src/main/java/me/panpf/tool4a/widget/NestedGridView.java)
    * [NestedListView.java](tool4a/src/main/java/me/panpf/tool4a/widget/NestedListView.java)
    * [ToastUtils.java](tool4a/src/main/java/me/panpf/tool4a/widget/ToastUtils.java)
    * [ViewAdapter.java](tool4a/src/main/java/me/panpf/tool4a/widget/ViewAdapter.java)
    * [ZoomOutPageTransformer.java](tool4a/src/main/java/me/panpf/tool4a/widget/ZoomOutPageTransformer.java)

## 依赖
* `com.android.support:support-fragment:25.0.3`：Fragment 兼容
    1. FragmentListPagerAdapter.java
    2. SimpleFragmentPagerAdapter.java
    3. SimpleFragmentStatePagerAdapter.java
    4. ViewListPagerAdapter.java
    5. MessageDialogFragment.java
    6. ProgressDialogFragment.java
    7. DepthPageTransformer.java
    8. ZoomOutPageTransformer.java
* `com.google.code.gson:gson:2.2.4`：用于对象与 json 互转
    1. PreferenceUtils.putObject()
    2. PreferenceUtils.getObject()
* `com.belerweb:pinyin4j:2.5.1`：用于中文转拼音或者比较两个中文的大小
    1. CharUtils.getPinyin()
    2. StringUtils.compare()

## License
    Copyright (C) 2017 Peng fei Pan <sky@panpf.me>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

[logo_image]: sample/src/main/res/mipmap-mdpi/ic_launcher.png
[platform_image]: https://img.shields.io/badge/Platform-Android-brightgreen.svg
[min_api_image]: https://img.shields.io/badge/API-10%2B-orange.svg
[min_api_link]: https://android-arsenal.com/api?level=10
[release_version_image]: https://img.shields.io/github/release/panpf/android-toolbox.svg
[release_version-link]: https://github.com/panpf/android-toolbox/releases
