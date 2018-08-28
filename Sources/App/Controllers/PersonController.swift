import Vapor
import FluentSQLite

struct PersonController: RouteCollection {
    
    func boot(router: Router) throws {
        
        // localhost:8080/person
        router.get("person", use: getHandler)
        
        // localhost:8080/person
        router.post("person", use: createHandler)
        
        // localhost:8080/person/1
        router.put("person", Person.parameter, use: updateHandler)
        
        // localhost:8080/person/1
        router.delete("person", Person.parameter, use: deleteHandler)
        
    }
    
    func getHandler(request: Request) throws -> Future<[Person]> {
        
        return Person.query(on: request).all()
        
    }
    
    func createHandler(request: Request) throws -> Future<Person> {
        
        return try request.content.decode(Person.self).flatMap(to: Person.self) { person in
            
            return person.save(on: request)
            
        }
        
    }
    
    func updateHandler(request: Request) throws -> Future<Person> {
        
        return try flatMap(to: Person.self, request.parameters.next(Person.self), request.content.decode(Person.self)) { person, updatedPerson in
            
            var personToUpdate = person
            personToUpdate.firstName = updatedPerson.firstName
            personToUpdate.lastName = updatedPerson.lastName
            personToUpdate.age = updatedPerson.age
            
            return personToUpdate.save(on: request)
            
        }
        
    }
    
    func deleteHandler(req: Request) throws -> Future<HTTPStatus> {
        
        return try req.parameters.next(Person.self).flatMap(to: HTTPStatus.self) { person in
            return person.delete(on: req).transform(to: .noContent)
        }
        
    }
    
}

extension Person: Parameter {}
