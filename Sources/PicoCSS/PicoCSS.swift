import Foundation
import Elementary

public extension HTMLTrait.Attributes {
    protocol readonly {}
    protocol ariaInvalid {}
    protocol ariaDescribedby {}
    protocol `open` {}
    protocol secondary {}
    protocol contrast {}
    protocol outline {}
    protocol theme {}
}

// MARK: - themes
public enum Theme: String, Sendable {
    case dark
    case light
}

extension HTMLTag.html: HTMLTrait.Attributes.theme {}
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.theme {
    static func theme(_ theme: Theme) -> Self {
        HTMLAttribute(name: "data-theme", value: theme.rawValue)
    }
}

public extension HTMLElement where Tag == HTMLTag.html {
    func theme(_ theme: Theme, when condition: Bool = true) -> Self {
        return attributes(.theme(theme), when: condition)
    }
}

// MARK: - readonly attribute
extension HTMLTag.input: HTMLTrait.Attributes.readonly {}
extension HTMLTag.textarea: HTMLTrait.Attributes.readonly {}
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.readonly {
    static var readonly: Self {
        HTMLAttribute(name: "readonly", value: nil)
    }
}

public extension HTMLVoidElement where Tag == HTMLTag.input {
    func readonly(when condition: Bool = true) -> Self {
        return attributes(.readonly, when: condition)
    }
}

public extension HTMLElement where Tag == HTMLTag.textarea {
    func readonly(when condition: Bool = true) -> Self {
        return attributes(.readonly, when: condition)
    }
}

// MARK: - aria-invalid attribute
extension HTMLTag.input: HTMLTrait.Attributes.ariaInvalid {}
extension HTMLTag.textarea: HTMLTrait.Attributes.ariaInvalid {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.ariaInvalid {
    static func ariaInvalid(_ invalid: Bool) -> Self {
        HTMLAttribute(name: "aria-invalid", value: invalid ? "true" : "false")
    }
}

// MARK: - aria-describedby attribute
extension HTMLTag.input: HTMLTrait.Attributes.ariaDescribedby {}
extension HTMLTag.textarea: HTMLTrait.Attributes.ariaDescribedby {}

extension HTMLAttribute where Tag: HTMLTrait.Attributes.ariaDescribedby {
    static func ariaDescribedby(_ id: String) -> Self {
        HTMLAttribute(name: "aria-describedby", value: id)
    }
}

// MARK: - button types
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.secondary {
    static var secondary: Self {
        HTMLAttribute(
            name: "class",
            value: "secondary",
            mergedBy: .appending(separatedBy: " ")
        )
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.contrast {
    static var contrast: Self {
        HTMLAttribute(
            name: "class",
            value: "secondary",
            mergedBy: .appending(separatedBy: " ")
        )
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.outline {
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
    /// https://picocss.com/docs/forms/input#disabled
    func disabled(_ disabled: Bool, when condition: Bool = true) -> Self {
        attributes(.disabled, when: condition && disabled)
    }
    
    /// https://picocss.com/docs/forms/input#readonly
    func readonly(_ readonly: Bool, when condition: Bool = true) -> Self {
        attributes(.readonly, when: condition && readonly)
    }
    
    /// https://picocss.com/docs/forms/input#validation-states
    func valid(_ isValid: Bool, when condition: Bool = true) -> Self {
        attributes(.ariaInvalid(!isValid), when: condition)
    }
}

public extension HTMLTrait {
    protocol InvalidMessage {
        func invalid(ariaDescribedbyId: UUID, when condition: Bool) -> any HTML
    }
}

extension HTMLVoidElement: HTMLTrait.InvalidMessage where Tag == HTMLTag.input {
    /// https://picocss.com/docs/forms/input#validation-states
    ///
    ///    input().invalid(message: "Some error text", when: validationFails)
    ///
    public func invalid(message: String, when condition: Bool = true) ->
    InvalidMessage<HTMLVoidElement<HTMLTag.input>> {
        InvalidMessage(message: message, condition: condition, input: self)
    }
    
    public func invalid(ariaDescribedbyId: UUID, when condition: Bool) -> any HTML {
        self.attributes(.ariaInvalid(true), when: condition)
            .attributes(.ariaDescribedby(ariaDescribedbyId.uuidString), when: condition)
    }
}

extension HTMLElement: HTMLTrait.InvalidMessage where Tag == HTMLTag.textarea {
    ///
    ///    textarea {}.invalid(message: "Some error text", when: validationFails)
    ///
    public func invalid(message: String, when condition: Bool = true) ->
    InvalidMessage<HTMLElement<HTMLTag.textarea, Content>> {
        InvalidMessage(message: message, condition: condition, input: self)
    }
    
    public func invalid(ariaDescribedbyId: UUID, when condition: Bool) -> any HTML {
        self.attributes(.ariaInvalid(true), when: condition)
            .attributes(.ariaDescribedby(ariaDescribedbyId.uuidString), when: condition)
    }
}

/// Usage:
/// input().invalid(message: "Some error text", when: validationFails)
/// textarea {}.invalid(message: "Some error text", when: validationFails)
///
public struct InvalidMessage<Input: HTMLTrait.InvalidMessage>: HTML {
    private let message: String
    private let condition: Bool
    private let input: Input
    
    init(message: String, condition: Bool, input: Input) {
        self.message = message
        self.condition = condition
        self.input = input
    }
    
    public var body: some HTML {
        let id = UUID()
        HTMLRaw( input.invalid(ariaDescribedbyId: id, when: condition).render() )
        if condition {
            small(.id(id.uuidString)) { message }
        }
    }
}


// MARK: - textarea
extension HTMLElement where Tag == HTMLTag.textarea {
    func valid(_ isValid: Bool, when condition: Bool = true) -> Self {
        attributes(.ariaInvalid(!isValid), when: condition)
    }

    func disabled(_ isDisabled: Bool, when condition: Bool = true) -> Self {
        attributes(.disabled, when: condition && isDisabled)
    }

    func readonly(_ readonly: Bool, when condition: Bool = true) -> Self {
        attributes(.readonly, when: condition && readonly)
    }
}

// MARK: - Select
extension HTMLElement where Tag == HTMLTag.select {
    /// https://picocss.com/docs/forms/select#disabled
    func disabled(_ isDisabled: Bool, when condition: Bool = true) -> Self {
        attributes(.disabled, when: condition && isDisabled)
    }
}

// MARK: - Container
public extension HTMLElement where Tag == HTMLTag.main {
    /// https://picocss.com/docs/container#fixed-width
    var centerViewport: Self { attributes(.class("container")) }
    /// https://picocss.com/docs/container#fluid-width
    var fullWidthViewport: Self { attributes(.class("container-fluid")) }
}

public extension HTMLElement where Tag == HTMLTag.header {
    /// https://picocss.com/docs/container#fixed-width
    var centerViewport: Self { attributes(.class("container")) }
    /// https://picocss.com/docs/container#fluid-width
    var fullWidthViewport: Self { attributes(.class("container-fluid")) }
}

public extension HTMLElement where Tag == HTMLTag.footer {
    /// https://picocss.com/docs/container#fixed-width
    var centerViewport: Self { attributes(.class("container")) }
    /// https://picocss.com/docs/container#fluid-width
    var fullWidthViewport: Self { attributes(.class("container-fluid")) }
}


// MARK: - Accordion
extension HTMLTag.details: HTMLTrait.Attributes.open {}

/// https://picocss.com/docs/accordion
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.open {
    static var open: Self {
        HTMLAttribute(name: "open", value: nil)
    }
}

public extension HTMLElement where Tag == HTMLTag.details {
    var open: Self { attributes(.open) }
    /// https://picocss.com/docs/dropdown
    var dropdown: Self { attributes(.class("dropdown")) }
}

/// https://picocss.com/docs/accordion#button-variants
public extension HTMLElement where Tag == HTMLTag.details {
    var button: Self { attributes(.role("button")) }
    func button(style: String) -> Self {
        button.attributes(.secondary)
    }
}

extension HTMLTag.details: HTMLTrait.Attributes.secondary {}
extension HTMLTag.details: HTMLTrait.Attributes.contrast {}
extension HTMLTag.details: HTMLTrait.Attributes.outline {}


// MARK: - table
public extension HTMLElement where Tag == HTMLTag.table {
    /// https://picocss.com/docs/table
    var striped: Self { attributes(.class("striped")) }
}

public struct Table {
    var body: some HTML {
        table {
            thead {
                tr {
                    th(.scope(.col)) { "Planet" }
                    th(.scope(.col)) { "Diam. (km)" }
                    th(.scope(.col)) { "Dist. to Sun (AU)" }
                    th(.scope(.col)) { "Grav. (m/s²)" }
                }
            }

            tbody {
                tr {
                    th(.scope(.row)) { "Mercury" }
                    td { "4.880" }
                    td { "0.39" }
                    td { "88" }
                }

                tr{
                    th(.scope(.row)){ "Venus" }
                    td {"12,104" }
                    td { "0.72" }
                    td { "225" }
                }

                // ....
            }

            tfoot {
                tr {
                    th(.scope(.row)) { "Average" }
                    td { "9,126" }
                    td { "0.91" }
                    td { "341" }
                }
            }
        }
    }
}

// MARK: - FormGrid
///FormGrid {
///    input().login()
///    input().password()
///    input().submit("Log in")
///}
/// https://picocss.com/docs/forms#usage-with-grid
public struct FormGrid<Content: HTML>: BodyRenderer {
    let content: () -> Content
    init (@HTMLBuilder content: @escaping () -> Content) {
        self.content = content
    }
    @HTMLBuilder public var body: some HTML {
        form() {
            fieldset(content: content).grid
        }
    }
}

// MARK: -
///FormGroup {
///    input().email()
///    input().submit("Subscribe")
///}
/// https://picocss.com/docs/forms#usage-with-group
public struct FormGroup<Content: HTML>: BodyRenderer {
    let content: () -> Content
    init (@HTMLBuilder content: @escaping () -> Content) {
        self.content = content
    }
    @HTMLBuilder public var body: some HTML {
        form {
            fieldset(content: content).group
        }
    }
}

public extension HTMLElement {
    var group: Self { attributes(.role("group")) }
    var grid: Self { attributes(.class("grid")) }
}

// MARK: - form search
public extension HTMLElement where Tag == HTMLTag.form {
//    form {
//        input().search()
//        input().submit("Search")
//    }.search
    var search: Self { attributes(.role("search")) }
}

public extension HTMLVoidElement where Tag == HTMLTag.input {
    @inlinable var required: Self { attributes(.required) }

    @inlinable
    func minlength(_ minlength: Int, tip: String? = nil) -> Self {
        let defaultTip = "At least \(minlength) characters required."
        return attributes(
            .custom(name: "minlength", value: "\(minlength)"),
            .title(tip ?? defaultTip)
        )
    }

    @inlinable
    func alphanumeric(_ tip: String = "Only Latin letters and numbers are allowed") -> Self {
        attributes(
            .custom(name: "pattern", value: "[a-zA-Z0-9]+"),
            .title(tip)
        )
    }

    @inlinable
    func submit(_ title: String) -> Self {
        attributes(.type(.submit), .value(title))
    }

    @inlinable
    func ariaLabel(_ value: String) -> Self {
        attributes(.custom(name: "aria-label", value: value))
    }

    @inlinable
    func firstName(_ name: String = "first_name", placeholder: String = "First name") -> Self {
        attributes(.name(name), .placeholder(placeholder), .autocomplete("given-name"))
    }

    // MARK: - https://picocss.com/docs/forms/input
    @inlinable
    func text(name: String = "text", placeholder: String) -> Self {
        attributes(.type(.text), .name(name), .placeholder(placeholder)).ariaLabel("Text")
    }

    @inlinable
    func login(name: String = "login", placeholder: String = "Login") -> Self {
        attributes(.name(name), .placeholder(placeholder), .autocomplete("username")).ariaLabel("Login")
    }

    @inlinable
    func email(name: String = "email", placeholder: String = "Email") -> Self {
        attributes(.type(.email), .name(name), .placeholder(placeholder), .autocomplete("email")).ariaLabel("Email")
    }

    @inlinable
    func number(name: String = "number", placeholder: String = "Number") -> Self {
        attributes(.type(.number), .name(name), .placeholder(placeholder)).ariaLabel("Number")
    }

    @inlinable
    func password(name: String = "password", placeholder: String = "Password") -> Self {
        attributes(.type(.password), .name(name), .placeholder(placeholder)).ariaLabel("Password")
    }

    @inlinable
    func telephone(name: String = "tel", placeholder: String = "Tel") -> Self {
        attributes(.type(.tel), .name(name), .placeholder(placeholder), .autocomplete("tel")).ariaLabel("Tel")
    }

    @inlinable
    func url(name: String = "url", placeholder: String = "Url") -> Self {
        attributes(.type(.url), .name(name), .placeholder(placeholder)).ariaLabel("Url")
    }

    // MARK: - https://picocss.com/docs/forms/input#datetime
    @inlinable
    func date(name: String = "date") -> Self {
        attributes(.type(.date), .name(name)).ariaLabel("Date")
    }

    @inlinable
    func dateTime(name: String = "datetime-local") -> Self {
        attributes(.type(.datetimeLocal), .name(name)).ariaLabel("Datetime local")
    }

    @inlinable
    func time(name: String = "time") -> Self {
        attributes(.type(.time), .name(name)).ariaLabel("Time")
    }

    // MARK: - https://picocss.com/docs/forms/input#search
    @inlinable
    func search(name: String = "search", placaholder: String = "Search") -> Self {
        attributes(.type(.search), .name(name), .placeholder(placaholder)).ariaLabel("Search")
    }
}


// MARK: - https://picocss.com/docs/typography#blockquote
public struct Blockquote {
    let quote: String
    let name: String
    public init(quote: String, name: String) {
        self.quote = quote
        self.name = name
    }

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
extension HTMLTag.button: HTMLTrait.Attributes.secondary {}
extension HTMLTag.button: HTMLTrait.Attributes.contrast {}
extension HTMLTag.button: HTMLTrait.Attributes.outline {}

public extension HTMLElement where Tag == HTMLTag.button {
    var secondary: Self { attributes(.secondary) }
    var contrast: Self { attributes(.contrast) }
    var outline: Self { attributes(.outline) }

    func disabled(when condition: Bool = true) -> Self {
        attributes(.disabled, when: condition)
    }
}

