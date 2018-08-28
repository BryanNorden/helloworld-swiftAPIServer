import Vapor
import FluentSQLite

struct Person {
    var id: Int?
    var firstName: String
    var lastName: String
    var age: Int
}

extension Person: SQLiteModel {}
extension Person: Content {}
extension Person: Migration {}
