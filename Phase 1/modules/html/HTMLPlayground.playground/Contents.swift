import Foundation

// MARK: - HTML Element Protocol
protocol HTMLElement {
    func render(indent: Int) -> String
}

extension HTMLElement {
    func render() -> String {
        render(indent: 0)
    }
}

// MARK: - Basic HTML Tag
struct HTMLTag: HTMLElement {
    let tagName: String
    let attributes: [String: String]
    let content: HTMLElement?

    init(_ tagName: String, attributes: [String: String] = [:], content: HTMLElement? = nil) {
        self.tagName = tagName
        self.attributes = attributes
        self.content = content
    }

    func render(indent: Int) -> String {
        let spaces = String(repeating: "  ", count: indent)
        let attributeString = renderAttributes()

        if let content = content {
            if let textContent = content as? HTMLText {
                return "\(spaces)<\(tagName)\(attributeString)>\(textContent.text)</\(tagName)>"
            }

            return """
            \(spaces)<\(tagName)\(attributeString)>
            \(content.render(indent: indent + 1))
            \(spaces)</\(tagName)>
            """
        } else {
            return "\(spaces)<\(tagName)\(attributeString)></\(tagName)>"
        }
    }

    private func renderAttributes() -> String {
        guard !attributes.isEmpty else { return "" }

        let sortedAttributes = attributes.sorted { $0.key < $1.key }
        let attributePairs = sortedAttributes.map { key, value in
            "\(key)=\"\(value)\""
        }

        return " " + attributePairs.joined(separator: " ")
    }
}

// MARK: - Text Content
struct HTMLText: HTMLElement {
    let text: String
    
    func render(indent: Int) -> String {
        let spaces = String(repeating: "  ", count: indent)
        return "\(spaces)\(text)"
    }
}

// MARK: - Multiple Children
struct HTMLGroup: HTMLElement {
    let children: [HTMLElement]
    
    func render(indent: Int) -> String {
        children.map { $0.render(indent: indent) }.joined(separator: "\n")
    }
}

// MARK: - Result Builder
@resultBuilder
struct HTMLBuilder {
    // TODO: Implement buildBlock for 1-5 components
    static func buildBlock(_ components: HTMLElement...) -> HTMLElement {
        HTMLGroup(children: components)
    }
    
    // TODO: Implement buildOptional (for if without else)
    static func buildOptional(_ component: HTMLElement?) -> HTMLElement {
        return component ?? HTMLGroup(children: [])
    }
    
    
    // TODO: Implement buildEither (for if-else)
    static func buildEither(first component: any HTMLElement) -> any HTMLElement {
        return component
    }
    
    static func buildEither(second component: any HTMLElement) -> any HTMLElement {
        return component
    }
    
    // TODO: Implement buildArray (for loops)
    static func buildArray(_ components: [HTMLElement]) -> HTMLElement {
        return HTMLGroup(children: components)
    }
}

// MARK: - Convenience Functions
func html(_ attributes: [String: String] = [:], @HTMLBuilder content: () -> HTMLElement) -> HTMLElement {
    HTMLTag("html", attributes: attributes, content: content())
}

func head(_ attributes: [String: String] = [:], @HTMLBuilder content: () -> HTMLElement) -> HTMLElement {
    HTMLTag("head", attributes: attributes, content: content())
}

func body(_ attributes: [String: String] = [:], @HTMLBuilder content: () -> HTMLElement) -> HTMLElement {
    HTMLTag("body", attributes: attributes, content: content())
}

// Overloaded div functions for different syntaxes
func div(_ attributes: [String: String] = [:], @HTMLBuilder content: () -> HTMLElement) -> HTMLElement {
    HTMLTag("div", attributes: attributes, content: content())
}

func div(class className: String? = nil, id: String? = nil, @HTMLBuilder content: () -> HTMLElement) -> HTMLElement {
    var attributes: [String: String] = [:]
    if let className = className {
        attributes["class"] = className
    }
    if let id = id {
        attributes["id"] = id
    }
    return HTMLTag("div", attributes: attributes, content: content())
}

func h1(_ text: String, attributes: [String: String] = [:]) -> HTMLElement {
    HTMLTag("h1", attributes: attributes, content: HTMLText(text: text))
}

func h2(_ text: String, attributes: [String: String] = [:]) -> HTMLElement {
    HTMLTag("h2", attributes: attributes, content: HTMLText(text: text))
}

func h3(_ text: String, attributes: [String: String] = [:]) -> HTMLElement {
    HTMLTag("h3", attributes: attributes, content: HTMLText(text: text))
}

func p(_ text: String, attributes: [String: String] = [:]) -> HTMLElement {
    HTMLTag("p", attributes: attributes, content: HTMLText(text: text))
}

func li(_ text: String, attributes: [String: String] = [:]) -> HTMLElement {
    HTMLTag("li", attributes: attributes, content: HTMLText(text: text))
}

func ul(_ attributes: [String: String] = [:], _ text: String) -> HTMLElement {
    HTMLTag("ul", attributes: attributes, content: HTMLText(text: text))
}

func title(_ text: String, attributes: [String: String] = [:]) -> HTMLElement {
    HTMLTag("title", attributes: attributes, content: HTMLText(text: text))
}

// MARK: - Test Cases
func runTests() {
    // Test 1: Basic structure
    let test1 = html {
        body {
            h1("Hello")
        }
    }
    print("Test 1:")
    print(test1.render())
    print()
    
    // Test 2: Conditionals
    let isLoggedIn = true
    let test2 = html {
        body {
            if isLoggedIn {
                p("Welcome back!")
            }
        }
    }
    print("Test 2:")
    print(test2.render())
    print()
    
    // Test 3: If-else
    let test3 = html {
        body {
            if isLoggedIn {
                p("Hello, user")
            } else {
                p("Please log in")
            }
        }
    }
    print("Test 3:")
    print(test3.render())
    print()
    
    // Test 4: Loops
    let items = ["Swift", "SwiftUI", "Result Builders"]
    let test4 = html {
        body {
            div {
                for item in items {
                    li(item)
                }
            }
        }
    }
    print("Test 4:")
    print(test4.render())
    print()
    
    // Test 5: Complex page
    let test5 = html {
        head {
            title("My Website")
        }
        body {
            h1("Welcome")
            
            if isLoggedIn {
                p("You are logged in!")
            }
            
            div {
                for i in 1...3 {
                    p("Paragraph \(i)")
                }
            }
        }
    }
    print("Test 5 (Full Page):")
    print(test5.render())
    print()

    // Test 6: Attributes with named parameters
    let test6 = html {
        body {
            div(class: "container", id: "main") {
                h1("Welcome", attributes: ["class": "title"])
                p("Content with attributes", attributes: ["id": "intro", "class": "text"])
            }
        }
    }
    print("Test 6 (Attributes with Named Parameters):")
    print(test6.render())
    print()

    // Test 7: Attributes with dictionary syntax
    let test7 = html {
        body(["class": "body-class"]) {
            div(["class": "wrapper", "data-id": "123"]) {
                p("Paragraph with data attributes", attributes: ["data-name": "test"])
            }
        }
    }
    print("Test 7 (Attributes with Dictionary Syntax):")
    print(test7.render())
}

// Run tests
runTests()
