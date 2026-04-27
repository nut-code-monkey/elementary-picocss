import Elementary

public enum Theme: String, Sendable {
    case dark
    case light
}

public extension HTMLElement {
    func theme(_ theme: Theme?) -> Self {
        guard let theme = theme else { return self }
        return attributes(.custom(name: "data-theme", value: theme.rawValue))
    }
}

public extension HTMLTrait.Attributes {
    protocol readonly {}
    protocol ariaInvalid {}
    protocol ariaDescribedby {}
    protocol `open` {}

    protocol secondary {}
    protocol contrast {}
    protocol outline {}
}

// MARK: - readonly attribute
extension HTMLTag.input: HTMLTrait.Attributes.readonly {}
extension HTMLTag.textarea: HTMLTrait.Attributes.readonly {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.readonly {
    static var readonly: Self {
        HTMLAttribute(name: "readonly", value: nil)
    }
}

// MARK: - aria-invalid attribute
extension HTMLTag.input: HTMLTrait.Attributes.ariaInvalid {}
extension HTMLTag.textarea: HTMLTrait.Attributes.ariaInvalid {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.ariaInvalid {
    static func ariaInvalid(_ isValid: Bool) -> Self {
        HTMLAttribute(name: "aria-invalid", value: isValid ? "false" : "true")
    }
}

// MARK: - aria-describedby attribute
extension HTMLTag.input: HTMLTrait.Attributes.ariaDescribedby {}
extension HTMLTag.textarea: HTMLTrait.Attributes.ariaDescribedby {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.ariaDescribedby {
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
        attributes(.ariaInvalid(isValid), when: condition)
    }

    /// https://picocss.com/docs/forms/input#validation-states
    func validation(helper id: String, when condition: Bool = true) -> Self {
        attributes(.ariaDescribedby(id), when: condition)
    }
}

// MARK: - small validation helper
public extension HTMLElement where Tag == HTMLTag.small {
    /// https://picocss.com/docs/forms/input#validation-states
    func validation(helper id: String) -> Self {
        attributes(.id(id))
    }
}

// MARK: - textarea
extension HTMLElement where Tag == HTMLTag.textarea {
    func valid(_ isValid: Bool, when condition: Bool = true) -> Self {
        attributes(.ariaInvalid(isValid), when: condition)
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
    public var group: Self { attributes(.role("group")) }
    public var grid: Self { attributes(.class("grid")) }
}

// MARK: - form search
public extension HTMLElement where Tag == HTMLTag.form {
//    form {
//        input().search()
//        input().submit("Search")
//    }.search
    public var search: Self { attributes(.role("search")) }
}

public extension HTMLVoidElement where Tag == HTMLTag.input {
    @inlinable
    public var required: Self {
        attributes(.required)
    }

    @inlinable
    public func minlength(_ minlength: Int, tip: String? = nil) -> Self {
        let defaultTip = "At least \(minlength) characters required."
        return attributes(
            .custom(name: "minlength", value: "\(minlength)"),
            .title(tip ?? defaultTip)
        )
    }

    @inlinable
    public func alphanumeric(_ tip: String = "Only Latin letters and numbers are allowed") -> Self {
        attributes(
            .custom(name: "pattern", value: "[a-zA-Z0-9]+"),
            .title(tip)
        )
    }

    @inlinable
    public func submit(_ title: String) -> Self {
        attributes(.type(.submit), .value(title))
    }

    @inlinable
    public func ariaLabel(_ value: String) -> Self {
        attributes(.custom(name: "aria-label", value: value))
    }

    @inlinable
    public func firstName(_ name: String = "first_name", placeholder: String = "First name") -> Self {
        attributes(.name(name), .placeholder(placeholder), .autocomplete("given-name"))
    }

    // MARK: - https://picocss.com/docs/forms/input
    @inlinable
    public func text(name: String = "text", placeholder: String) -> Self {
        attributes(.type(.text), .name(name), .placeholder(placeholder)).ariaLabel("Text")
    }

    @inlinable
    public func login(name: String = "login", placeholder: String = "Login") -> Self {
        attributes(.name(name), .placeholder(placeholder), .autocomplete("username")).ariaLabel("Login")
    }

    @inlinable
    public func email(name: String = "email", placeholder: String = "Email") -> Self {
        attributes(.type(.email), .name(name), .placeholder(placeholder), .autocomplete("email")).ariaLabel("Email")
    }

    @inlinable
    public func number(name: String = "number", placeholder: String = "Number") -> Self {
        attributes(.type(.number), .name(name), .placeholder(placeholder)).ariaLabel("Number")
    }

    @inlinable
    public func password(name: String = "password", placeholder: String = "Password") -> Self {
        attributes(.type(.password), .name(name), .placeholder(placeholder)).ariaLabel("Password")
    }

    @inlinable
    public func telephone(name: String = "tel", placeholder: String = "Tel") -> Self {
        attributes(.type(.tel), .name(name), .placeholder(placeholder), .autocomplete("tel")).ariaLabel("Tel")
    }

    @inlinable
    public func url(name: String = "url", placeholder: String = "Url") -> Self {
        attributes(.type(.url), .name(name), .placeholder(placeholder)).ariaLabel("Url")
    }

    // MARK: - https://picocss.com/docs/forms/input#datetime
    @inlinable
    public func date(name: String = "date") -> Self {
        attributes(.type(.date), .name(name)).ariaLabel("Date")
    }

    @inlinable
    public func dateTime(name: String = "datetime-local") -> Self {
        attributes(.type(.datetimeLocal), .name(name)).ariaLabel("Datetime local")
    }

    @inlinable
    public func time(name: String = "time") -> Self {
        attributes(.type(.time), .name(name)).ariaLabel("Time")
    }

    // MARK: - https://picocss.com/docs/forms/input#search
    @inlinable
    public func search(name: String = "search", placaholder: String = "Search") -> Self {
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

