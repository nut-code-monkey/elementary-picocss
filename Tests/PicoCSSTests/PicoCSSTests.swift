@testable import PicoCSS
import Testing
import Elementary

extension String {
    var removeLineLeadingWhitespaces: String {
        replacing( /\n[ \t]*/, with: "")
    }
}

@Suite struct Inputs {
    @Test func readonly() {
        #expect(input(.readonly).render() == "<input readonly>")
        #expect(textarea(.readonly){ }.render() == "<textarea readonly></textarea>")
        #expect(input().readonly.render() == "<input readonly>")
        #expect(textarea{ }.readonly.render() == "<textarea readonly></textarea>")
        #expect(input().readonly().render() == "<input readonly>")
        #expect(textarea{ }.readonly().render() == "<textarea readonly></textarea>")
    }
    
    @Test func readonlyWhen() {
        #expect(input().readonly(when: false).render() == "<input>")
        #expect(textarea{ }.readonly(when: false).render() == "<textarea></textarea>")
        #expect(input().readonly(when: true).render() == "<input readonly>")
        #expect(textarea{ }.readonly(when: true).render() == "<textarea readonly></textarea>")
    }
    
    @Test func readonlyTwo() {
        #expect(input().readonly.readonly.render() == "<input readonly>")
        #expect(textarea{ }.readonly.readonly.render() == "<textarea readonly></textarea>")
        #expect(input().readonly().readonly().render() == "<input readonly>")
        #expect(textarea{ }.readonly().readonly.render() == "<textarea readonly></textarea>")
    }

    @Test func disabledInput() async throws {
        #expect(input().disabled().render() == "<input disabled>")

        #expect(input().disabled(when: true).render() == "<input disabled>")
        #expect(input().disabled(when: false).render() == "<input>")

        #expect(input().disabled().disabled().render() == "<input disabled>")
        #expect(input().disabled().disabled(when: false).render() == "<input disabled>")
    }
    
    @Test func disabledText() async throws {
        #expect(textarea{}.disabled().render() == "<textarea disabled></textarea>")

        #expect(textarea{}.disabled(when: true).render() == "<textarea disabled></textarea>")
        #expect(textarea{}.disabled(when: false).render() == "<textarea></textarea>")

        #expect(textarea{}.disabled().disabled().render() == "<textarea disabled></textarea>")
        #expect(textarea{}.disabled().disabled(when: false).render() == "<textarea disabled></textarea>")
    }

    @Test func validInput() async throws {
        #expect(input().valid.render() == "<input aria-invalid=\"false\">")
        #expect(input().valid().render() == "<input aria-invalid=\"false\">")
        #expect(input().valid(when: true).render() == "<input aria-invalid=\"false\">")
        #expect(input().valid(when: false).render() == "<input>")
    }
    
    @Test func validText() async throws {
        #expect(textarea{}.valid.render() == "<textarea aria-invalid=\"false\"></textarea>")
        #expect(textarea{}.valid().render() == "<textarea aria-invalid=\"false\"></textarea>")
        #expect(textarea{}.valid(when: true).render() == "<textarea aria-invalid=\"false\"></textarea>")
        #expect(textarea{}.valid(when: false).render() == "<textarea></textarea>")
    }
    
    @Test func invalidInput() async throws {
        #expect(input().invalid.render() == "<input aria-invalid=\"true\">")
        #expect(input().invalid().render() == "<input aria-invalid=\"true\">")
        #expect(input().invalid(when: true).render() == "<input aria-invalid=\"true\">")
        #expect(input().invalid(when: false).render() == "<input>")
    }
    
    @Test func invalidText() async throws {
        #expect(textarea{}.invalid.render() == "<textarea aria-invalid=\"true\"></textarea>")
        #expect(textarea{}.invalid().render() == "<textarea aria-invalid=\"true\"></textarea>")
        #expect(textarea{}.invalid(when: true).render() == "<textarea aria-invalid=\"true\"></textarea>")
        #expect(textarea{}.invalid(when: false).render() == "<textarea></textarea>")
    }
    
    @Test func invalidInputMessage() async throws {
        let id = "foo"
        #expect(input().invalid(message: "Message", id: id).render() == """
            <input aria-invalid="true" aria-describedby="\(id)">
            <small id="\(id)">Message</small>
            """.removeLineLeadingWhitespaces)
        
        #expect(input().invalid(message: "Message", id: id, when: true).render() == """
            <input aria-invalid="true" aria-describedby="\(id)">
            <small id="\(id)">Message</small>
            """.removeLineLeadingWhitespaces)
        
        #expect(input().invalid(message: "Message", id: id, when: false).render() == "<input>")
    }
    
    @Test func invalidTextMessage() async throws {
        let id = "foo"
        #expect(textarea { }.invalid(message: "Message", id: id).render() == """
            <textarea aria-invalid="true" aria-describedby="\(id)"></textarea>
            <small id="\(id)">Message</small>
            """.removeLineLeadingWhitespaces)
        
        #expect(textarea { }.invalid(message: "Message", id: id, when: true).render() == """
            <textarea aria-invalid="true" aria-describedby="\(id)"></textarea>
            <small id="\(id)">Message</small>
            """.removeLineLeadingWhitespaces)
        
        #expect(textarea { }.invalid(message: "Message", id: id, when: false).render() == "<textarea></textarea>")
    }
}


@Suite struct ButtonTests {

    @Test func detailsAsButton() async throws {
        #expect(details{ }.button.render() == "<details role=\"button\"></details>")
        
        #expect(details{ }.buttonSecondary.render() == "<details role=\"button\" class=\"secondary\"></details>")
        #expect(details{ }.buttonContrast.render() == "<details role=\"button\" class=\"contrast\"></details>")
        #expect(details{ }.buttonOutline.render() == "<details role=\"button\" class=\"outline\"></details>")
    }
}

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
        
        #expect( html(.theme(theme)){}.render() == attribueExist )
    }
}

