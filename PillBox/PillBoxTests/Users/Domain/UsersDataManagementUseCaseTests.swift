import SwiftUI
import XCTest

@testable import PillBox

final class UsersDataManagementUseCaseTests: XCTestCase {
    private var sut: UsersDataManagementUseCase!
    private var repositoryMock: UsersRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repositoryMock = UsersRepositoryMock()
        sut = UsersDataManagementUseCase(repository: repositoryMock)
    }
    
    override func tearDown() {
        sut = nil
        repositoryMock = nil
        super.tearDown()
    }

    func testFetchUsersThenExpectedModel() {
        // Given
        let expectedModel = UserModel(idUser: "Any", name: "Any", avatar: "womenAvatar")
        // When
        let model = sut.fetchUsers()
        // Then
        XCTAssertEqual(repositoryMock.fetchUserCallsCount, 1)
        XCTAssertEqual(model, [expectedModel])
    }
    
    func testUpdateAvatar() throws {
        // When
        try sut.updateAvatar(avatar: "Any", id: "Id")
        // Then
        XCTAssertEqual(repositoryMock.updateUserCallsCount, 1)
    }
    
    func testDeleteData() throws {
        // When
        try sut.deleteData("id")
        // Then
        XCTAssertEqual(repositoryMock.deleteUserCallsCount, 1)
    }
    
    func testSaveData() throws {
        // When
        try sut.saveData(name: "Any", avatar: "Any")
        // Then
        XCTAssertEqual(repositoryMock.saveUserCallsCount, 1)
    }
}

