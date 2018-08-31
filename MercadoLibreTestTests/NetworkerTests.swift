//
//  NetworkerTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class NetworkerTests: XCTestCase {

    var networker: Networker!

    override func setUp() {
        super.setUp()
        networker = Networker()
    }

    override func tearDown() {
        networker = nil
        super.tearDown()
    }

    func testDownloadImage() {
        networker.downloadImage(urlString: "test") { (_) in
        }
    }
}
