import Elementary

public extension HTMLTrait.Attributes {
    protocol secondary {}
    protocol contrast {}
    protocol outline {}
}

public extension HTMLTrait {
    protocol ButtonStyle {}
}

extension HTMLTag.button: HTMLTrait.Attributes.secondary {}
extension HTMLTag.details: HTMLTrait.Attributes.secondary {}
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.secondary {
    /// Usage:
    /// ```swift
    /// button(.secondary) { }
    /// details(.secondary) { }.button
    /// ```
    static var secondary: Self {
        HTMLAttribute(
            name: "class",
            value: "secondary",
            mergedBy: .appending(separatedBy: " ")
        )
    }
}

extension HTMLTag.button: HTMLTrait.Attributes.contrast {}
extension HTMLTag.details: HTMLTrait.Attributes.contrast {}
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.contrast {
    /// Usage:
    /// ```swift
    /// button(.contrast) { }
    /// details(.contrast) { }.button
    /// ```
    static var contrast: Self {
        HTMLAttribute(
            name: "class",
            value: "contrast",
            mergedBy: .appending(separatedBy: " ")
        )
    }
}

extension HTMLTag.button: HTMLTrait.Attributes.outline {}
extension HTMLTag.details: HTMLTrait.Attributes.outline {}
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.outline {
    /// Usage:
    /// ```swift
    /// button(.outline) { }
    /// details(.outline) { }.button
    /// ```
    static var outline: Self {
        HTMLAttribute(
            name: "class",
            value: "outline",
            mergedBy: .appending(separatedBy: " ")
        )
    }
}

// MARK: - https://picocss.com/docs/button

public extension HTMLElement where Tag == HTMLTag.button {
    /// Usage:
    /// ```swift
    /// button {}.secondary
    /// ```
    var secondary: Self { attributes(.secondary) }
    
    /// Usage:
    /// ```swift
    /// button {}.contrast
    /// ```
    var contrast: Self { attributes(.contrast) }
    
    /// Usage:
    /// ```swift
    /// button {}.outline
    /// ```
    var outline: Self { attributes(.outline) }

    
    /// Usage:
    /// ```swift
    /// button {}.disabled()
    /// button {}.disabled(when: someCondition)
    /// ```
    ///
    /// - Parameter condition: Whether to disable (default true).
    /// - Returns: Disabled button if condition met.
    func disabled(when condition: Bool = true) -> Self {
        attributes(.disabled, when: condition)
    }
}

/// Provides button-related accessibility and styles for details accordion.
/// https://picocss.com/docs/accordion#button-variants
public extension HTMLElement where Tag == HTMLTag.details {
    /// Adds role="button" for accessibility.
    /// Usage:
    /// ```swift
    /// details { }.button
    /// ```
    var button: Self { attributes(.role("button")) }
    /// Adds secondary button style.
    ///
    var buttonSecondary: Self {
        button.attributes(.secondary)
    }
    var buttonContrast: Self {
        button.attributes(.contrast)
    }
    var buttonOutline: Self {
        button.attributes(.outline)
    }
}
