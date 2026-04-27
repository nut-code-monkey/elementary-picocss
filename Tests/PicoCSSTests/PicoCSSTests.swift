import Testing
@testable import PicoCSS

@Test func emptyPage() async throws {
    let html = PicoHTML(title: "Hello") {} .render()
    #expect(html == template(""))
}

@Test func fooPage() async throws {
    let html = PicoHTML(title: "Hello") { "foo" } .render()
    #expect(html == template("foo"))
}




func template(title: String = "Hello", _ html: String) -> String {
"""
<!DOCTYPE html>
<html>
    <head>
        <title>\(title)</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css">
        <meta name="description" content="Hello">
    </head>
    <body>
        <div>\(html.removeLineLeadingWhitespaces)</div>
    </body>
</html>
""".removeLineLeadingWhitespaces
}

extension String {
    var removeLineLeadingWhitespaces: String {
        replacing( /\n[ \t]*/, with: "")
    }
}
