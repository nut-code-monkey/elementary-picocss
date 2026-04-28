@testable import PicoCSS
import Elementary
import Testing

@Suite struct ThemeTests {
    static var themes: [Theme] { [.light, .dark] }
    
    @Test(arguments: themes)
    func test(theme: Theme) async throws {
        let attribueExist = """
        <html data-theme="\(theme.rawValue)"></html>
        """
        
        #expect( html() {} .theme(theme).render() ==  attribueExist)
        #expect( html(.theme(theme)) {} .render() == attribueExist)
        
        #expect( html() {} .theme(theme, when: true).render() == attribueExist)
        #expect( html() {} .theme(theme, when: false).render() == "<html></html>")
    }
}
