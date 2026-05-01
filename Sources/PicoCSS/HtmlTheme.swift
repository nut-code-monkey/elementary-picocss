import Elementary


public extension HTMLTrait.Attributes {
    protocol theme {}
}


/// Represents available themes for PicoCSS styling.
///
/// Use this enum to set the page theme, typically dark or light modes.
public enum Theme: String, Sendable {
    /// Dark theme mode.
    case dark
    /// Light theme mode.
    case light
}

extension HTMLTag.html: HTMLTrait.Attributes.theme {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.theme {
    /// Generates a data-theme attribute for PicoCSS theme switching.
    ///
    /// Usage:
    /// ```swift
    /// html(.theme(.dark)) { }
    /// ```
    ///
    /// - Parameter theme: The selected theme mode.
    /// - Returns: An HTML attribute setting the data-theme value.
    static func theme(_ theme: Theme) -> Self {
        HTMLAttribute(name: "data-theme", value: theme.rawValue)
    }
}

public extension HTMLElement where Tag == HTMLTag.html {
    /// Applies a PicoCSS theme (dark or light) to the html element.
    ///
    /// Usage:
    /// ```swift
    /// html { }.theme(.dark)
    /// ```
    ///
    /// Usage:
    /// ```swift
    ///  PicoHTMLDocument(title: "Title", theme: .light) { }
    /// ```
    ///
    /// - Parameters:
    ///   - theme: The desired theme.
    ///   - condition: Whether to apply the theme (default true).
    /// - Returns: Updated html element with data-theme attribute.
    func theme(_ theme: Theme, when condition: Bool = true) -> Self {
        return attributes(.theme(theme), when: condition)
    }
}
