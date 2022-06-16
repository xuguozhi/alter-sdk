<h1 align="center">
  <br>
  <img src="https://user-images.githubusercontent.com/130319/169915404-76e38bfb-193d-47fe-8db3-94e99cb8f596.png" alt="Alter SDK" width="100%"></a>
  <br>
  <a href="https://alter.xyz">Alter</a> SDK
  <br>
</h1>


[Alter](https://alter.xyz) SDK is a cross-platform SDK consisting of a [real-time 3D avatar system](https://github.com/facemoji/alter-core), [facial motion capture](https://github.com/facemoji/mocap4face), and [multi-platform components for creating avatars](https://testflight.apple.com/join/1n5BT44q) (Avatar Designer). 
The SDK is built from scratch for web3 interoperability and the open metaverse. 
Easily pipe avatars into your game, app, or website. It just works. Check out the included code samples to learn how to get started with Alter SDK.

Please star us ⭐⭐⭐ on GitHub—it motivates us a lot!
# 📋 Table of Content

- [Tech and Avatar Specs](#-tech-and-avatar-specs)
- [Motion Capture](#-motion-capture)
- [Installation](#-installation)
- [License](#-license)
- [Use Cases](#-use-cases)
- [Links](#️-links)

# 🤓 Tech and Avatar Specs

### 🚉 Supported Platforms

- iOS 13+
- - [TestFlight demo](https://testflight.apple.com/join/1n5BT44q)
- Android 8+
- WebGL 2 (Soon)

See [alter-core](https://github.com/facemoji/alter-core) for detailed technical specifications about the rendering and motion capture.

### ✨ Avatar Formats

- Head only
- A bust with clothing
- A bust with clothing and background (Soon)
- Accessories only (for e.g. AR filters) (Soon)
- Full body (Soon)

### 🌈 Variability

- Human and non-human
- From toddler to skeleton
- Genders and non-binary
- Full range of diversity

# 🤪 Motion Capture

- `42` tracked facial expressions via blendshapes
- Eye tracking including eye gaze vector
- Tongue tracking
- Light & fast, just `3MB` ML model size
- Simultaneous back and front camera support
- Powered by [mocap4face](https://github.com/facemoji/mocap4face)

# 💿 Installation

## Prerequisites
Register in [Alter Studio](https://studio.alter.xyz) to get a unique key to access avatar data from our servers.

See our example code to see where to put the key. Look for "YOUR-API-KEY-HERE".

## iOS

To run the example, simply open the attached Xcode project and run it on your iPhone or iPad.

Do not forget to get your API key at [studio.alter.xyz](https://studio.alter.xyz) and paste it into the code. Look for "YOUR-API-KEY-HERE".

### SwiftPackage Installation
Add this repository as a dependency to your `Package.swift` or Xcode Project.

### Manual iOS Installation
Download the [`AlterCore.xcframework`](frameworks/AlterCore.xcframework) from this repository and drag&drop it into your Xcode Project.


## Android

To run the example, open the android-example project in Android Studio and run it on your Android phone.

Do not forget to get your API key at [studio.alter.xyz](https://studio.alter.xyz) and paste it into the code. Look for "YOUR-API-KEY-HERE".

### Gradle/Maven Installation for Android
Add this repository to your Gradle repositories in build.gradle:
```
repositories {
    // ...
    maven {
        name = "Alter"
        url = uri("https://facemoji.jfrog.io/artifactory/default-maven-local/")
    }
    // ...
}

// ...
dependencies {
    implementation "alter:alter-sdk:0.1.2"
}
```

# 📄 License

This library is provided under the [Alter SDK License Agreement](LICENSE.md). The sample code in this repository is provided under the [Alter Samples License](ios-example/LICENSE.md).

This library uses open source software, see the list of our [OSS dependencies and license notices](license/README.md).

# 🚀 Use Cases

Any app or game experience that uses an avatar as a profile picture or for character animations. The only limit is your imagination.

- Audio-only chat apps
- Next-gen profile pics
- Live avatar experiences
- Snapchat-like lenses
- AR experiences
- VTubing apps
- Live streaming apps
- Face filters
- Personalized stickers
- AR games with facial triggers
- Role-playing games

# Known Limitations

This is an alpha release software—we are still ironing out bugs, adding new features and changing the data:

- Item names within an Avatar Matrix can change
- The SDK is still not 100 % thread safe and race conditions or memory leaks can occur rarely
- Documentation is very sparse, make sure to join our [Discord](https://discord.gg/alterz) or file an issue if you encounter problems

# ❤️ Links

- [Twitter](https://twitter.com/alter)
- [Discord](https://discord.gg/alterz)
- [LinkedIn](https://www.linkedin.com/company/alterxyz/)
- [Blog](https://medium.com/@alterz/announcing-our-intentions-to-open-source-our-core-tech-62e7a87ce5be)
- [Avatar Designer TestFlight](https://testflight.apple.com/join/1n5BT44q)
- [Learn more...](https://alter.xyz)
