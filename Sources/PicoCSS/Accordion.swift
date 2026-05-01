import Elementary

public extension HTMLTrait.Attributes {
    protocol `open` {}
}

/// Enables use of the open attribute on details elements.
extension HTMLTag.details: HTMLTrait.Attributes.open {}

/// Provides attribute for open state of details for accordion usage.
///
/// https://picocss.com/docs/accordion
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.open {
    /// Usage:
    /// ```swift
    /// details(.open) {
    ///    summary{ Accordion }
    ///    p { ... }
    /// }
    /// ```
    /// The open attribute for details to toggle accordion sections.
    static var open: Self {
        HTMLAttribute(name: "open", value: nil, mergedBy: .replacing)
    }
}

public extension HTMLElement where Tag == HTMLTag.details {
    /// Usage:
    /// ```swift
    /// details {
    ///    summary{ Accordion }
    ///    p { ... }
    /// }.open(when: someCondition)
    /// ```
    func open(when condition: Bool = true) -> Self {
        attributes(.open, when: condition)
    }
    /// Marks details element as open.
    var open: Self { attributes(.open) }
    
    
    ///
    /// https://picocss.com/docs/dropdown
    var dropdown: Self { attributes(.class("dropdown")) }
}
