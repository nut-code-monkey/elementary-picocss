import Elementary

public extension HTMLVoidElement where Tag == HTMLTag.input {
    /// Usage:
    /// ```swift
    /// input().disabled()
    /// input().disabled(when: someCondition)
    /// ```
    ///
    /// - Parameter condition: Whether to disable (default true).
    /// - Returns: Input element disabled if condition is met.
    func disabled(when condition: Bool = true) -> Self {
        attributes(.disabled, when: condition)
    }
    
    /// Usage:
    /// ```swift
    /// input().disabled
    /// ```
    var disabled: Self { attributes(.disabled) }
}

// MARK: - textarea

extension HTMLElement where Tag == HTMLTag.textarea {
    /// Disables the textarea element.
    ///
    /// Usage:
    /// ```swift
    /// textarea { }.disabled()
    /// textarea { }.disabled(when: someCondition)
    /// ```
    ///
    /// - Parameters:
    ///   - condition: Whether to apply (default true).
    /// - Returns: Disabled textarea if conditions met.
    func disabled(when condition: Bool = true) -> Self {
        attributes(.disabled, when: condition)
    }
    
    /// Usage:
    /// ```swift
    /// textarea { }.disabled
    /// ```
    var disabled: Self { attributes(.disabled) }
}
