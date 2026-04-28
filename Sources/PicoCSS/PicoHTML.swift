import Elementary

public struct PicoHTMLDocument<Head: HTML, Body: HTML>: BodyRenderer {
    public let _title: String
    public let lang: String?
    public let direction: HTMLAttributeValue.Direction?
    public let _theme: Theme?
    public let _head: () -> Head
    public let _body: () -> Body

    public init(
        title: String,
        theme: Theme? = nil,
        lang: String? = nil,
        direction: HTMLAttributeValue.Direction? = nil,
        @HTMLBuilder head: @escaping () -> Head = { EmptyHTML() },
        @HTMLBuilder body: @escaping () -> Body
    ) {
        self._title = title
        self._theme = theme
        self.lang = lang
        self.direction = direction
        self._body = body
        self._head = head
    }
    
    var theme: Theme {
        _theme ?? .light
    }
    
    @HTMLBuilder
    public var body: some HTML {
        HTMLRaw("<!DOCTYPE html>")
        html {
            head {
                title { _title }
                meta(.name(.viewport), .content("width=device-width, initial-scale=1"))
                meta(.charset(.utf8))
                link(.rel(.stylesheet)).attributes(.href("https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css"))
                meta(.name(.description), .content(_title))
                _head()
            }
            Elementary.body(content: _body)
        }
        .theme(theme, when: _theme != nil)
        .direction(direction)
        .lang(lang)
    }
}

public extension HTMLElement where Tag == HTMLTag.html {
    @inlinable
    func direction(_ direction: HTMLAttributeValue.Direction?) -> Self {
        guard let direction = direction else { return self }
        return attributes(.dir(direction))
    }

    @inlinable
    func lang(_ lang: String?) -> Self {
        guard let lang = lang else { return self }
        return attributes(.lang(lang))
    }
}
