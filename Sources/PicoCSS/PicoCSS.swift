/// PicoCSS: PicoCSS components and helpers for HTML rendering with accessibility and semantic enhancements.
///
/// This module provides Swift types and extensions that wrap PicoCSS patterns,
/// including forms, containers, buttons, grid, and accessibility helpers.
/// Compatible with Elementary HTML DSL.
///
import Elementary

/// Attribute marker protocols for PicoCSS-related HTML attributes.
public extension HTMLTrait.Attributes {
    /// Marker for the readonly attribute on form elements.
    protocol readonly {}
    /// Marker for the aria-invalid attribute for validation states.
    protocol ariaInvalid {}
    /// Marker for the aria-describedby attribute for accessibility linking.
    protocol ariaDescribedby {}
    /// Marker for the open attribute on details elements.
    protocol `open` {}
    /// Marker for secondary button style.
    protocol secondary {}
    /// Marker for contrast button style.
    protocol contrast {}
    /// Marker for outline button style.
    protocol outline {}
    /// Marker for theme attribute on html tag.
    protocol theme {}
}

// MARK: - themes

/// Represents available themes for PicoCSS styling.
///
/// Use this enum to set the page theme, typically dark or light modes.
public enum Theme: String, Sendable {
    /// Dark theme mode.
    case dark
    /// Light theme mode.
    case light
}

/// Enables setting data-theme attribute on html element.
extension HTMLTag.html: HTMLTrait.Attributes.theme {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.theme {
    /// Generates a data-theme attribute for PicoCSS theme switching.
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

// MARK: - readonly attribute

/// Enables readonly attribute support on inputs and textareas.
extension HTMLTag.input: HTMLTrait.Attributes.readonly {}
extension HTMLTag.textarea: HTMLTrait.Attributes.readonly {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.readonly {
    /// Marks an input or textarea as readonly.
    static var readonly: Self {
        HTMLAttribute(name: "readonly", value: nil)
    }
}

public extension HTMLVoidElement where Tag == HTMLTag.input {
    /// Sets readonly attribute on input elements.
    ///
    /// Usage:
    /// ```swift
    /// input().readonly()
    /// input().readonly(when: someCondition)
    /// ```
    ///
    /// - Parameter condition: Whether to apply readonly (default true).
    /// - Returns: Input element marked readonly if condition is true.
    func readonly(when condition: Bool = true) -> Self {
        return attributes(.readonly, when: condition)
    }
}

public extension HTMLElement where Tag == HTMLTag.textarea {
    /// Sets readonly attribute on textarea elements.
    ///
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
}

// MARK: - aria-invalid attribute

/// Enables aria-invalid attribute support for form validation states.
extension HTMLTag.input: HTMLTrait.Attributes.ariaInvalid {}
extension HTMLTag.textarea: HTMLTrait.Attributes.ariaInvalid {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.ariaInvalid {
    /// Sets the aria-invalid attribute to indicate validation state.
    ///
    /// Usage:
    /// ```swift
    /// input(.ariaInvalid(true))
    /// textarea(.ariaInvalid(false)) { /* some content */ }
    /// ```
    ///
    /// - Parameter invalid: True if the input is invalid.
    /// - Returns: An aria-invalid attribute with "true" or "false".
    static func ariaInvalid(_ invalid: Bool) -> Self {
        HTMLAttribute(name: "aria-invalid", value: invalid ? "true" : "false")
    }
}

// MARK: - aria-describedby attribute

/// Enables aria-describedby attribute to link error messages/accessibility hints.
extension HTMLTag.input: HTMLTrait.Attributes.ariaDescribedby {}
extension HTMLTag.textarea: HTMLTrait.Attributes.ariaDescribedby {}

extension HTMLAttribute where Tag: HTMLTrait.Attributes.ariaDescribedby {
    /// Sets the aria-describedby attribute linking to an element ID.
    ///
    /// - Parameter id: The ID of the descriptive element.
    /// - Returns: An aria-describedby attribute referencing the ID.
    static func ariaDescribedby(_ id: String) -> Self {
        HTMLAttribute(name: "aria-describedby", value: id)
    }
}

// MARK: - button types


public extension HTMLAttribute where Tag: HTMLTrait.Attributes.secondary {
    /// Applies the "secondary" button style class.
    ///
    /// Usage:
    /// ```swift
    /// button(.secondary) { "Secondary button" }
    /// ```
    static var secondary: Self {
        HTMLAttribute(
            name: "class",
            value: "secondary",
            mergedBy: .appending(separatedBy: " ")
        )
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.contrast {
    /// Applies the "contrast" button style class.
    ///
    /// Usage:
    /// ```swift
    /// button(.contrast) { "Contrast button" }
    /// ```
    static var contrast: Self {
        HTMLAttribute(
            name: "class",
            value: "contrast",
            mergedBy: .appending(separatedBy: " ")
        )
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.outline {
    /// Applies the "outline" button style class.
    ///
    /// Usage:
    /// ```swift
    /// button(.outline) { "Contrast button" }
    /// ```
    static var outline: Self {
        HTMLAttribute(
            name: "class",
            value: "outline",
            mergedBy: .appending(separatedBy: " ")
        )
    }
}

// MARK: - input

public extension HTMLVoidElement where Tag == HTMLTag.input {
    /// Applies the disabled attribute to inputs.
    ///
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
    
    /// Sets aria-invalid based on validity.
    ///
    /// Usage:
    /// ```swift
    /// input().valid()
    /// input().valid(when: someCondition)
    /// ```
    ///
    /// - Parameters:
    ///   - condition: Whether to apply (default true).
    /// - Returns: Input element with aria-invalid if invalid.
    func valid(when condition: Bool = true) -> Self {
        attributes(.ariaInvalid(false), when: condition)
    }
}

/// Defines traits and behaviors for inputs with validation messages.
public extension HTMLTrait {
    /// Trait for HTML inputs supporting invalid message display.
    protocol InvalidMessageTrait: HTML {
        associatedtype Input: HTML
        /// Applies aria-describedby linking for validation messages.
        /// Implements by input and textarea
        ///
        /// - Parameters:
        ///   - ariaDescribedbyId: ID of the error message element.
        ///   - condition: Whether to apply the invalid state.
        /// - Returns: Input with aria attributes for invalid state.
        func invalid(ariaDescribedbyId: String, when condition: Bool) -> Input
    }
}

extension HTMLVoidElement: HTMLTrait.InvalidMessageTrait where Tag == HTMLTag.input {
    public typealias Input =  HTMLVoidElement<Tag>
    
    /// Generates an invalid message helper linking the input and message.
    ///
    /// Usage:
    /// ```swift
    /// input().invalid(message: "Invalid message")
    /// input().invalid(message: "Invalid message", when: someCondition)
    /// ```
    ///
    /// - Parameters:
    ///   - message: Validation error text.
    ///   - id: Optional ID for the error element; autogenerated if nil.
    ///   - condition: Whether to display the message (default true).
    /// - Returns: An InvalidMessage wrapper injecting accessibility attributes.
    public func invalid(message: String, id: String? = nil, when condition: Bool = true) -> InvalidMessage<Input> {
        let id = id ?? String(UInt64.random(in: 0...UInt64.max), radix: 16)
        return InvalidMessage(message: message, id: id, condition: condition, input: self)
    }
    
    /// Applies aria-invalid and aria-describedby attributes.
    ///
    /// - Parameters:
    ///   - ariaDescribedbyId: ID referencing the invalid message.
    ///   - condition: Whether to apply the invalid state.
    /// - Returns: Input element with aria attributes set.
    public func invalid(ariaDescribedbyId: String, when condition: Bool) -> Input
    {
        self.attributes(.ariaInvalid(true), when: condition)
            .attributes(.ariaDescribedby(ariaDescribedbyId), when: condition)
    }
}

extension HTMLElement: HTMLTrait.InvalidMessageTrait where Tag == HTMLTag.textarea {
    public typealias Input = HTMLElement<HTMLTag.textarea, Content>
    
    /// Generates an invalid message helper linking the textarea and message.
    ///
    /// Usage:
    /// ```swift
    /// textarea { }.invalid(message: "Invalid message")
    /// textarea { }.invalid(message: "Invalid message", when: someCondition)
    /// ```
    ///
    /// - Parameters:
    ///   - message: Validation error text.
    ///   - id: Optional ID for the error element; autogenerated if nil.
    ///   - condition: Whether to display the message (default true).
    /// - Returns: An InvalidMessage wrapper injecting accessibility attributes.
    public func invalid(message: String, id: String? = nil, when condition: Bool = true) -> InvalidMessage<Input> {
        let id = id ?? String(UInt64.random(in: 0...UInt64.max), radix: 16)
        return InvalidMessage(message: message, id: id, condition: condition, input: self)
    }
    
    /// Applies aria-invalid and aria-describedby attributes.
    ///
    /// - Parameters:
    ///   - ariaDescribedbyId: ID referencing the invalid message.
    ///   - condition: Whether to apply the invalid state.
    /// - Returns: Textarea element with aria attributes set.
    public func invalid(ariaDescribedbyId: String, when condition: Bool) -> Input {
        self.attributes(.ariaInvalid(true), when: condition)
            .attributes(.ariaDescribedby(ariaDescribedbyId), when: condition)
    }
}

/// A component that wraps an input and its validation message.
///
/// Usage:
/// ```swift
/// input().invalid(message: "Error text", when: validationFails)
/// textarea {}.invalid(message: "Error text", when: validationFails)
/// ```
public struct InvalidMessage<Input>: HTML where Input: HTMLTrait.InvalidMessageTrait {
    let message: String
    let id: String
    let condition: Bool
    let input: Input

    @HTMLBuilder public var body: some HTML {
        input.invalid(ariaDescribedbyId: id, when: condition)

        if condition {
            small(.id(id)) { message }
        }
    }
}

// MARK: - textarea

extension HTMLElement where Tag == HTMLTag.textarea {
    /// Marks the textarea valid or invalid with aria-invalid.
    ///
    /// Usage:
    /// ```swift
    /// textarea { }.valid()
    /// textarea { }.valid(when: someCondition)
    /// ```
    ///
    /// - Parameters:
    ///   - condition: Whether to apply the attribute (default true).
    /// - Returns: Textarea with updated aria-invalid attribute.
    func valid(when condition: Bool = true) -> Self {
        attributes(.ariaInvalid(false), when: condition)
    }

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
}

// MARK: - Select

extension HTMLElement where Tag == HTMLTag.select {
    /// Disables the select element.
    ///
    /// Usage:
    /// ```swift
    /// select { }.disabled()
    /// select { }.disabled(when: someCondition)
    /// ```
    ///
    /// - Parameters:
    ///   - condition: Whether to apply (default true).
    /// - Returns: Disabled select element if conditions met.
    func disabled(when condition: Bool = true) -> Self {
        attributes(.disabled, when: condition)
    }
}

// MARK: - Container

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

// MARK: - Accordion

/// Enables use of the open attribute on details elements.
extension HTMLTag.details: HTMLTrait.Attributes.open {}

/// Provides attribute for open state of details for accordion usage.
///
/// https://picocss.com/docs/accordion
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.open {
    /// The open attribute for details to toggle accordion sections.
    static var open: Self {
        HTMLAttribute(name: "open", value: nil)
    }
}

public extension HTMLElement where Tag == HTMLTag.details {
    /// Marks details element as open.
    var open: Self { attributes(.open) }
    /// Adds dropdown class for dropdown-style details.
    ///
    /// https://picocss.com/docs/dropdown
    var dropdown: Self { attributes(.class("dropdown")) }
}

/// Provides button-related accessibility and styles for details accordion.
///
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
    ///
    /// - Parameter style: Style string (unused, defaults to secondary).
    /// - Returns: Details element styled as secondary button.
    func button(style: String) -> Self {
        button.attributes(.secondary)
    }
}

extension HTMLTag.details: HTMLTrait.Attributes.secondary {}
extension HTMLTag.details: HTMLTrait.Attributes.contrast {}
extension HTMLTag.details: HTMLTrait.Attributes.outline {}

// MARK: - table

public extension HTMLElement where Tag == HTMLTag.table {
    /// Adds striped rows styling to a table.
    ///
    /// Usage:
    /// ```swift
    /// table { }.striped
    /// ```
    /// https://picocss.com/docs/table
    var striped: Self { attributes(.class("striped")) }
}

// MARK: - FormGrid

/// A form layout component using PicoCSS grid styles.
///
/// Usage:
/// ```swift
/// FormGrid {
///    input().login()
///    input().password()
///    input().submit("Log in")
/// }
/// ```
///
/// See: https://picocss.com/docs/forms#usage-with-grid
public struct FormGrid<Content: HTML>: BodyRenderer {
    let content: () -> Content
    /// Initialize with HTML content builder.
    ///
    /// - Parameter content: Closure returning the form content.
    init (@HTMLBuilder content: @escaping () -> Content) {
        self.content = content
    }
    /// Renders the form with a fieldset using grid layout.
    @HTMLBuilder public var body: some HTML {
        form() {
            fieldset(content: content).grid
        }
    }
}

// MARK: - FormGroup

/// A form layout component using PicoCSS group styles.
///
/// Usage:
/// ```swift
/// FormGroup {
///    input().email()
///    input().submit("Subscribe")
/// }
/// ```
///
/// See: https://picocss.com/docs/forms#usage-with-group
public struct FormGroup<Content: HTML>: BodyRenderer {
    let content: () -> Content
    /// Initialize with HTML content builder.
    ///
    /// - Parameter content: Closure returning the form content.
    init (@HTMLBuilder content: @escaping () -> Content) {
        self.content = content
    }
    /// Renders the form with a fieldset using grouped layout.
    @HTMLBuilder public var body: some HTML {
        form {
            fieldset(content: content).group
        }
    }
}

public extension HTMLElement {
    /// Adds role="group" attribute for grouping form elements.
    var group: Self { attributes(.role("group")) }
    /// Adds class="grid" attribute for grid layout.
    var grid: Self { attributes(.class("grid")) }
}

// MARK: - form search

public extension HTMLElement where Tag == HTMLTag.form {
    /// Adds role="search" attribute for landmark search region.
    ///
    /// Usage:
    /// ```swift
    /// form {
    ///     input().search()
    ///     input().submit("Search")
    /// }.search
    /// ```
    var search: Self { attributes(.role("search")) }
}

// MARK: - input helpers

public extension HTMLVoidElement where Tag == HTMLTag.input {
    /// Marks the input as required.
    /// Usage:
    /// ```swift
    /// input().required
    /// ```
    @inlinable var required: Self { attributes(.required) }

    /// Sets minlength with optional tooltip for guidance.
    ///
    ///  Usage:
    /// ```swift
    /// input().minlength(10)
    /// input().minlength(10, tip: "This field must be at least 10 symbols")
    /// ```
    ///
    /// - Parameters:
    ///   - minlength: Minimum length required.
    ///   - tip: Optional tooltip shown on hover.
    /// - Returns: Input with minlength and title attributes.
    @inlinable
    func minlength(_ minlength: Int, tip: String? = nil) -> Self {
        let defaultTip = "At least \(minlength) characters required."
        return attributes(
            .custom(name: "minlength", value: "\(minlength)"),
            .title(tip ?? defaultTip)
        )
    }

    /// Restricts input to alphanumeric characters with tooltip.
    ///
    /// Usage:
    /// ```swift
    /// input().alphanumeric()
    /// ```
    ///
    /// - Parameter tip: Tooltip message (default provided).
    /// - Returns: Input with pattern and title attributes.
    @inlinable
    func alphanumeric(_ tip: String = "Only Latin letters and numbers are allowed") -> Self {
        attributes(
            .custom(name: "pattern", value: "[a-zA-Z0-9]+"),
            .title(tip)
        )
    }

    /// Sets input as submit button with given title.
    /// Usage:
    /// ```swift
    /// input().submit("Login")
    /// ```
    ///
    /// - Parameter title: Button text.
    /// - Returns: Input of type submit.
    @inlinable
    func submit(_ title: String) -> Self {
        attributes(.type(.submit), .value(title))
    }

    /// Adds aria-label attribute for accessibility.
    ///
    /// - Parameter value: The accessible label.
    /// - Returns: Input with aria-label attribute.
    @inlinable
    func ariaLabel(_ value: String) -> Self {
        attributes(.custom(name: "aria-label", value: value))
    }

    /// Defines first name input field with name, placeholder, and autocomplete.
    ///
    /// - Parameters:
    ///   - name: The input name attribute.
    ///   - placeholder: Placeholder text.
    /// - Returns: Input configured for first name.
    @inlinable
    func firstName(_ name: String = "first_name", placeholder: String = "First name") -> Self {
        attributes(.name(name), .placeholder(placeholder), .autocomplete("given-name"))
    }

    // MARK: - https://picocss.com/docs/forms/input

    /// Defines a generic text input with label.
    ///
    /// - Parameters:
    ///   - name: Name attribute.
    ///   - placeholder: Placeholder text.
    /// - Returns: Text input element.
    @inlinable
    func text(name: String = "text", placeholder: String) -> Self {
        attributes(.type(.text), .name(name), .placeholder(placeholder)).ariaLabel("Text")
    }

    /// Defines a login input with autocomplete and aria label.
    ///
    /// - Parameters:
    ///   - name: Name attribute.
    ///   - placeholder: Placeholder text.
    /// - Returns: Login input field.
    @inlinable
    func login(name: String = "login", placeholder: String = "Login") -> Self {
        attributes(.name(name), .placeholder(placeholder), .autocomplete("username")).ariaLabel("Login")
    }

    /// Defines an email input field.
    ///
    /// - Parameters:
    ///   - name: Name attribute.
    ///   - placeholder: Placeholder text.
    /// - Returns: Email input element.
    @inlinable
    func email(name: String = "email", placeholder: String = "Email") -> Self {
        attributes(.type(.email), .name(name), .placeholder(placeholder), .autocomplete("email")).ariaLabel("Email")
    }

    /// Defines a numeric input field.
    ///
    /// - Parameters:
    ///   - name: Name attribute.
    ///   - placeholder: Placeholder text.
    /// - Returns: Number input element.
    @inlinable
    func number(name: String = "number", placeholder: String = "Number") -> Self {
        attributes(.type(.number), .name(name), .placeholder(placeholder)).ariaLabel("Number")
    }

    /// Defines a password input field.
    ///
    /// - Parameters:
    ///   - name: Name attribute.
    ///   - placeholder: Placeholder text.
    /// - Returns: Password input element.
    @inlinable
    func password(name: String = "password", placeholder: String = "Password") -> Self {
        attributes(.type(.password), .name(name), .placeholder(placeholder)).ariaLabel("Password")
    }

    /// Defines a telephone input field.
    ///
    /// - Parameters:
    ///   - name: Name attribute.
    ///   - placeholder: Placeholder text.
    /// - Returns: Telephone input element.
    @inlinable
    func telephone(name: String = "tel", placeholder: String = "Tel") -> Self {
        attributes(.type(.tel), .name(name), .placeholder(placeholder), .autocomplete("tel")).ariaLabel("Tel")
    }

    /// Defines a URL input field.
    ///
    /// - Parameters:
    ///   - name: Name attribute.
    ///   - placeholder: Placeholder text.
    /// - Returns: URL input element.
    @inlinable
    func url(name: String = "url", placeholder: String = "Url") -> Self {
        attributes(.type(.url), .name(name), .placeholder(placeholder)).ariaLabel("Url")
    }

    // MARK: - https://picocss.com/docs/forms/input#datetime

    /// Defines a date input field.
    ///
    /// - Parameter name: Name attribute.
    /// - Returns: Date input element.
    @inlinable
    func date(name: String = "date") -> Self {
        attributes(.type(.date), .name(name)).ariaLabel("Date")
    }

    /// Defines a datetime-local input field.
    ///
    /// - Parameter name: Name attribute.
    /// - Returns: DateTime-local input element.
    @inlinable
    func dateTime(name: String = "datetime-local") -> Self {
        attributes(.type(.datetimeLocal), .name(name)).ariaLabel("Datetime local")
    }

    /// Defines a time input field.
    ///
    /// - Parameter name: Name attribute.
    /// - Returns: Time input element.
    @inlinable
    func time(name: String = "time") -> Self {
        attributes(.type(.time), .name(name)).ariaLabel("Time")
    }

    // MARK: - https://picocss.com/docs/forms/input#search

    /// Defines a search input field.
    ///
    /// - Parameters:
    ///   - name: Name attribute.
    ///   - placaholder: Placeholder text (note: typo preserved).
    /// - Returns: Search input element.
    @inlinable
    func search(name: String = "search", placaholder: String = "Search") -> Self {
        attributes(.type(.search), .name(name), .placeholder(placaholder)).ariaLabel("Search")
    }
}

// MARK: - https://picocss.com/docs/typography#blockquote

/// A blockquote component styled according to PicoCSS.
///
/// Displays a quote with a footer citing the source.
///
/// Usage:
/// ```swift
/// Blockquote(quote: "To be or not to be", name: "Shakespeare")
/// ```
public struct Blockquote {
    /// The quote text.
    let quote: String
    /// The name of the quoted person/source.
    let name: String
    /// Initializes a blockquote with quote text and source name.
    ///
    /// - Parameters:
    ///   - quote: The quote string.
    ///   - name: The source or author name.
    public init(quote: String, name: String) {
        self.quote = quote
        self.name = name
    }

    /// Renders the blockquote HTML element.
    var body: some HTML {
        blockquote {
            "“\(quote)“"
            footer {
                cite {
                    "— \(name)"
                }
            }
        }
    }
}

// MARK: - https://picocss.com/docs/button

/// Enables secondary, contrast, and outline styles on button elements.
extension HTMLTag.button: HTMLTrait.Attributes.secondary {}
extension HTMLTag.button: HTMLTrait.Attributes.contrast {}
extension HTMLTag.button: HTMLTrait.Attributes.outline {}

public extension HTMLElement where Tag == HTMLTag.button {
    /// Applies the secondary button style.
    ///
    /// Usage:
    /// ```swift
    /// button {}.secondary
    /// ```
    var secondary: Self { attributes(.secondary) }
    
    /// Applies the contrast button style.
    ///
    /// Usage:
    /// ```swift
    /// button {}.contrast
    /// ```
    var contrast: Self { attributes(.contrast) }
    /// Applies the outline button style.
    ///
    /// Usage:
    /// ```swift
    /// button {}.outline
    /// ```
    var outline: Self { attributes(.outline) }

    /// Disables the button element.
    ///
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
