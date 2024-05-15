//
//  TravelTaipei_HWTests.swift
//  TravelTaipei-HWTests
//
//  Created by Ting on 2024/5/9.
//

import XCTest
@testable import TravelTaipei_HW

final class TravelTaipei_HWTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

//class CategoryAPIServiceTests: XCTestCase {
//    
//    var apiServiceMock: APIServicesMock!
//    //var categoryAPIService: MiscellaneousAPIServiceProtocol!
//    var apiService: MiscellaneousAPIService!
//    
//    override func setUp() {
//        super.setUp()
//        apiServiceMock = APIServicesMock()
//        apiService = MiscellaneousAPIService(apiServices: apiServiceMock)
//    }
//    
//    override func tearDown() {
//        apiServiceMock = nil
//        apiService = nil
//        super.tearDown()
//    }
//    
//    // 測試 fetchActivity 方法
//    func testFetchActivity() {
//          // Given
//          let categoryType = "活動"
//          let expectedModel = MiscellaneousResponseModel<ActivityModel>(total: 10, data: ActivityModel(activity: [IdNameModel(id: 1, name: "Activity 1")]))
//          apiServiceMock.mockResponseModel = expectedModel
//          
//          // When
//          let expectation = self.expectation(description: "Fetch activity")
//          apiService.fetchActivity(type: categoryType) { result in
//              // Then
//              switch result {
//              case .success(let model):
//                  XCTAssertEqual(model.total, expectedModel.total)
//                  XCTAssertEqual(model.data.activity?.first?.id, expectedModel.data.activity?.first?.id)
//                  XCTAssertEqual(model.data.activity?.first?.name, expectedModel.data.activity?.first?.name)
//              case .failure(let error):
//                  XCTFail("Unexpected error: \(error)")
//              }
//              expectation.fulfill()
//          }
//          
//          waitForExpectations(timeout: 1.0, handler: nil)
//      }
//}
//
