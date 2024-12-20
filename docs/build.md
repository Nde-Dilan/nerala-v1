I'll explain the different methods to build your Flutter APK, along with their pros and cons.

1. Basic Debug Build
```bash
flutter build apk
```
Pros:
- Quick to build
- Includes debugging information
- Good for testing

Cons:
- Larger file size
- Slower performance
- Not suitable for release

2. Release Build
```bash
flutter build apk --release
```
Pros:
- Optimized performance
- Smaller than debug build
- Production-ready

Cons:
- Cannot be debugged
- Longer build time

3. Split APKs by ABI (Architecture)
```bash
flutter build apk --split-per-abi --release
```
Pros:
- Creates separate APKs for different CPU architectures (armeabi-v7a, arm64-v8a, x86_64)
- Users download only what they need
- Smallest possible size for each device

Cons:
- Need to manage multiple APK files
- More complex distribution process

4. App Bundle (recommended by Google)
```bash
flutter build appbundle --release
```
Pros:
- Google Play Store optimizes delivery for each device
- Smallest possible download size for users
- Handles architecture and language splits automatically
- Future-proof

Cons:
- Only works with Google Play Store
- Cannot be directly installed on devices

5. Minimal Release Build (for your case)
```bash
flutter build apk --release --target-platform android-arm,android-arm64 --split-per-abi
```
Then add these in android/app/build.gradle:
```gradle
android {
    buildTypes {
        release {
            shrinkResources true
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

Additional optimization tips:
1. Remove unused locales in pubspec.yaml:
```yaml
flutter:
  uses-material-design: true
  generate: true
  fonts:
    - family: YourFont
      fonts:
        - asset: assets/fonts/YourFont.ttf
```

2. Optimize images:
- Use WebP format instead of PNG/JPEG
- Remove unused assets
- Compress images using tools like TinyPNG

3. Code optimization:
```dart
// Add constant constructors where possible
const MyWidget({Key? key}) : super(key: key);

// Use lazy loading for heavy widgets
late final heavyWidget = HeavyWidget();
```

4. Android Manifest optimization:
```xml
<manifest ...>
    <!-- Remove permissions you don't use -->
    <uses-permission android:name="android.permission.INTERNET" />
</manifest>
```

5. Check and remove unused dependencies:
```bash
flutter pub outdated
flutter pub upgrade
```

For your lightest possible APK:
1. Start with the minimal release build command
2. Split by ABI to target specific architectures
3. Enable R8 shrinking
4. Optimize assets and remove unused ones
5. Use code splitting and lazy loading
6. Implement proper asset management

Monitor your APK size:
```bash
# Analyze APK size
flutter build apk --analyze-size

# Get detailed size report
flutter build apk --release --split-per-abi --target-platform android-arm64 --analyze-size > size_report.txt
```

This will give you the smallest possible APK while maintaining functionality. Remember to test thoroughly after optimization to ensure nothing important was removed by the shrinking process.