import Elementary

public extension HTMLElement where Tag == HTMLTag.main {
    /// Applies a fixed width container class for centered content.
    ///
    /// Usage:
    /// ```swift
    /// main { }.centerViewport()
    /// ```
    /// https://picocss.com/docs/container#fixed-width
    var centerViewport: Self { attributes(.class("container")) }
    /// Applies a fluid container class for full width content.
    ///
    /// Usage:
    /// ```swift
    /// main { }.fullWidthViewport()
    /// ```
    /// https://picocss.com/docs/container#fluid-width
    var fullWidthViewport: Self { attributes(.class("container-fluid")) }
}

public extension HTMLElement where Tag == HTMLTag.header {
    /// Applies a fixed width container class for centered content.
    ///
    /// Usage:
    /// ```swift
    /// header { }.centerViewport()
    /// ```
    /// https://picocss.com/docs/container#fixed-width
    var centerViewport: Self { attributes(.class("container")) }
    /// Applies a fluid container class for full width content.
    ///
    /// Usage:
    /// ```swift
    /// header { }.fullWidthViewport()
    /// ```
    /// https://picocss.com/docs/container#fluid-width
    var fullWidthViewport: Self { attributes(.class("container-fluid")) }
}

public extension HTMLElement where Tag == HTMLTag.footer {
    /// Applies a fixed width container class for centered content.
    ///
    /// Usage:
    /// ```swift
    /// footer { }.centerViewport()
    /// ```
    /// https://picocss.com/docs/container#fixed-width
    var centerViewport: Self { attributes(.class("container")) }
    /// Applies a fluid container class for full width content.
    ///
    /// Usage:
    /// ```swift
    /// footer { }.fullWidthViewport()
    /// ```
    /// https://picocss.com/docs/container#fluid-width
    var fullWidthViewport: Self { attributes(.class("container-fluid")) }
}
