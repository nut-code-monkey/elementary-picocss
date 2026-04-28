@testable import PicoCSS
import Elementary
import Testing

@Suite struct InputTests {
    @Test func inputTests() async throws {
        #expect(input().render() == "<input>")
    }
    
    @Test func disabled() async throws {
        #expect(input().disabled().render() == "<input disabled>")

        #expect(input().disabled(when: true).render() == "<input disabled>")
        #expect(input().disabled(when: false).render() == "<input>")

        #expect(input().disabled().disabled().render() == "<input disabled>")
        #expect(input().disabled().disabled(when: false).render() == "<input disabled>")
    }

    @Test func invalidMessage() async throws {
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
}
