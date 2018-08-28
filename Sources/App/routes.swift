import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    

    // http://localhost:8080/hello -> Hello, world!
    
    router.get("hello") { request in
        
        return "Hello, world!"
        
    }
    
    // http://localhost:8080/hello/<someString> -> Hello, <someString>!
    
    router.get("hello", String.parameter) { request -> String in
        
        let someString = try request.parameters.next(String.self)
        
        return "Hello, \(someString)!"
        
    }
}
