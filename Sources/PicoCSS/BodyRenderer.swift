import Elementary

public protocol BodyRenderer: HTML {
    static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext)
    
#if !os(WASI)
    static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws
#endif
}

public extension BodyRenderer {
    static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        func render<H: HTML>(_ html: H, into renderer: inout some _HTMLRendering, with context: consuming _RenderingContext) {
            H._render(html, into: &renderer, with: context)
        }

        render(html.body, into: &renderer, with: context)
    }
    
#if !os(WASI)
    static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {

        func render<H: HTML>(_ html: H, into renderer: inout some _HTMLRendering, with context: consuming _RenderingContext) async throws {
            try await H._render(html, into: &renderer, with: context)
        }

        try await render(html.body, into: &renderer, with: context)
    }
#endif
}
