# SwiftExec

Cross-platform library that lets you execute a shell command from Swift and capture its output.

## Use

Add to your Package.swift.

```swift
    .Package(url: "https://github.com/ssoper/SwiftExec.git", versions: Version(0,0,1)..<Version(0,1,0))
```

Then use in your app.

```swift
import SwiftExec
let output = swiftExec("/bin/echo", "relax", "i’ll", "need", "some", "information", "first")
```

You can also use it to find where commands are on the system.

```swift
let gitCmd = try which("git")
print(gitCmd) // output "/usr/bin/git"
```