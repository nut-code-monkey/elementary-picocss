/// PicoCSS: PicoCSS components and helpers for HTML rendering with accessibility and semantic enhancements.
///
/// This module provides Swift types and extensions that wrap PicoCSS patterns,
/// including forms, containers, buttons, grid, and accessibility helpers.
/// Compatible with Elementary HTML DSL.
///
import Elementary

// MARK: - Select

extension HTMLElement where Tag == HTMLTag.select {
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


