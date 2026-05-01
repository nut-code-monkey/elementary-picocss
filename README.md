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

# A lightweight Swift bridge for [Pico.css](https://picocss.com) and the [Elementary](https://github.com/elementary-swift/elementary)/[ElementaryUI](https://elementary.codes). 

Build elegant, responsive, and theme-aware web interfaces in pure Swift without writing a single line of CSS.

## [Documentation](https://nut-code-monkey.github.io/elementary-picocss/documentation/picocss/)

## 📖 Why Pico + Elementary?

**Elementary** is a high-performance HTML DSL for Swift. **Pico.css** is a "Classless" CSS framework that makes standard HTML look beautiful. 

By combining them, you get:
1. **Speed**: No heavy CSS frameworks to parse.
2. **Readability**: Your Swift code describes exactly what the UI does.
3. **Consistency**: Perfect for internal tools, prototypes, or minimalist blogs.


## ✨ Features

- **Type-Safe Styling**: Use Swift modifiers instead of error-prone string class names.
- **Zero Config**: Pico.css is automatically linked; no build tools or PostCSS required.
- **Semantic HTML**: Leverages Pico’s philosophy of styling standard HTML elements.
- **Dark Mode Ready**: Built-in support for light/dark color schemes.
- **Layout Helpers**: Custom modifiers for centering viewports and grouping form elements.
- **WebAssembly ready**: Write your WebASM app with [ElementaryUI](https://elementary.codes) and PicoCSS.

## 🛠 Installation:
Add `elementary-picocss` to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/elementary-swift/elementary.git", from: "0.7.1"),
    .package(url: "https://github.com/nut-code-monkey/elementary-picocss.git", branch: "main")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "Elementary", package: "elementary"),
            .product(name: "PicoCSS", package: "elementary-picocss")
        ]
    )
]
```

## 💻 Usage Examples
### 1. Simple Page:
```swift
import Elementary
import PicoCSS

PicoHTMLDocument(title: "My awesome page") {
    main {
        h1 { "Hello, Elementary!" }
        p { "This page is styled automatically with PicoCSS." }
    }
    .centerViewport
}
.render()
```
### 2. Advanced Form with Validation:
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
