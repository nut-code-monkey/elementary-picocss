import Elementary

public extension HTMLTrait.Attributes {
    protocol readonly {}
}

extension HTMLTag.input: HTMLTrait.Attributes.readonly {}
extension HTMLTag.textarea: HTMLTrait.Attributes.readonly {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.readonly {
    /// /// Usage:
    /// ```swift
    /// textarea(.readonly) { }
    /// ```
    static var readonly: Self {
        HTMLAttribute(name: "readonly", value: nil)
    }
}

public extension HTMLVoidElement where Tag == HTMLTag.input {
    /// Usage:
    /// ```swift
    /// input().readonly()
    /// input().readonly(when: someCondition)
    /// ```
    ///
    /// - Parameter condition: Whether to apply readonly (default true).
    /// - Returns: Input element marked readonly if condition is true.
    func readonly(when condition: Bool = true) -> Self {
        attributes(.readonly, when: condition)
    }
    /// /// Usage:
    /// ```swift
    /// input().readonly
    /// ```
    var readonly: Self { attributes(.readonly) }
}

public extension HTMLElement where Tag == HTMLTag.textarea {
    /// Usage:
    /// ```swift
    /// textarea { /* some content */ }.readonly()
    /// textarea { /* some content */ }.readonly(when: someCondition)
    /// ```
    ///
    /// - Parameter condition: Whether to apply readonly (default true).
    /// - Returns: Textarea element marked readonly if condition is true.
    func readonly(when condition: Bool = true) -> Self {
        return attributes(.readonly, when: condition)
    }
    /// /// Usage:
    /// ```swift
    /// textarea{}.readonly
    /// ```
    var readonly: Self { attributes(.readonly) }
}
