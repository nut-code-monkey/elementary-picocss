<p align="center">
  <a href="https://elementary.codes">
    <img src="https://elementary-swift.github.io/assets/elementary-logo.svg" width="125px" alt="Elementary Logo">
  </a>
</p>
<p align="center">
  <a href="https://picocss.com" target="_blank">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/picocss/pico/HEAD/.github/logo-dark.svg">
      <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/picocss/pico/HEAD/.github/logo-light.svg">
      <img alt="Pico CSS" src="https://raw.githubusercontent.com/picocss/pico/HEAD/.github/logo-light.svg" width="auto" height="60">
    </picture>
  </a>
</p>

# [PicoCSS](https://picocss.com) for Swift [Elementary](https://github.com/elementary-swift/elementary) support

## Minimum example:
```swift
import Elementary
import PicoCSS

PicoHTMLDocument(title: "My awesome page") {
    main {
        h1 { "Elementary page" }
    }
    .centerViewport
}
.render()
```
## Login form:
```swift
import Elementary
import PicoCSS

PicoHTMLDocument(title: "My awesome page", theme: .dark) {
    header {
        nav { ul { li { "Navigation header" } } }
    }.fullWidthViewport

    main {
        form(.method(.post), .action("/login/path")) {
            input().login()
                .minlength(5)
                .alphanumeric()
                .required

            input().password()
                .minlength(10)
                .required
                .invalid(message: "Must be at least 10 symbols")

            input().submit("Login")
        }.group
    }.centerViewport

    footer { "Some footer" }.centerViewport
}
.render()
```

## Installation:
`Package(... dependencies: [`
```swift
    .package(url: "https://github.com/elementary-swift/elementary.git", from: "0.7.1"),
    .package(url: "https://github.com/nut-code-monkey/elementary-picocss.git", branch: "main")
```
`], targets: [.target( ... dependencies: [`
```swift
        .product(name: "Elementary", package: "elementary"),
        .product(name: "PicoCSS", package: "elementary-picocss")
```
`])])`
