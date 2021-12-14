//
//  Created by Pierluigi Cifani on 08/06/2017.
//

import XCTest
import BSWFoundation
import Task

class JSONParserTests: XCTestCase {

    struct SampleModel: Codable {
        let identity: String
        let name: String
        let amount: Double

        enum CodingKeys : String, CodingKey {
            case identity = "id", name, amount
        }
    }

    func testParsing() throws {
        let model = SampleModel(identity: "123456", name: "Hola", amount: 5678)
        let jsonData = try JSONEncoder().encode(model)
        let task: Task<SampleModel> = JSONParser.parseData(jsonData)
        let _ = try self.waitAndExtractValue(task)
    }

    func testParsing_forSwiftConcurency() async throws {
        let model = SampleModel(identity: "123456", name: "Hola", amount: 5678)
        let jsonData = try JSONEncoder().encode(model)
        let parsedModel: SampleModel = try JSONParser.parseData(jsonData)
        XCTAssert(model.identity == parsedModel.identity)
    }

    func testArrayParsing() throws {
        let model1 = SampleModel(identity: "123456", name: "Hola", amount: 5678)
        let model2 = SampleModel(identity: "987642", name: "🍻", amount: 0986)
        let array = [model1, model2]
        let jsonData = try JSONEncoder().encode(array)

        let task: Task<[SampleModel]> = JSONParser.parseData(jsonData)
        let _ = try self.waitAndExtractValue(task)
    }

    func testParsePrettyPrinting() throws {
        let model = SampleModel(identity: "123456", name: "Hola", amount: 5678)
        let jsonData = try JSONEncoder().encode(model)
        guard let string = JSONParser.parseDataAsJSONPrettyPrint(jsonData) else {
            throw ParseError()
        }

        let sampleString = """
        {\"id\":\"123456\",\"name\":\"Hola\",\"amount\":5678}
        """
        XCTAssert(string == sampleString)
    }

    func testEmptyResponseParsing() throws {
        let jsonData = """
        """.data(using: .utf8)!
        print(jsonData)
        let task: Task<VoidResponse> = JSONParser.parseData(jsonData)
        let value = try self.waitAndExtractValue(task)
        print(value)
    }
}

struct ParseError: Swift.Error {
}

