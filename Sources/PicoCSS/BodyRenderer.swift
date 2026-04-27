import Elementary

protocol BodyRenderer: HTML {
    static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext)
    @_unavailableInEmbedded
    static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws
}

extension BodyRenderer {
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {

        func render<H: HTML>(_ html: H, into renderer: inout some _HTMLRendering, with context: consuming _RenderingContext) async throws {
            try await H._render(html, into: &renderer, with: context)
        }

        try await render(html.body, into: &renderer, with: context)
    }
}
