//
//  WMLabsTests.swift
//  AtWMLabs-Sample
//
//  Created by David Sica on 11/28/15.
//  Copyright © 2015 Sufficient Magic Software. All rights reserved.
//

import XCTest

class WMLabsTests: XCTestCase, WMProductListViewControllerDelegate {
    
    var loadedWMDataExpectation : XCTestExpectation?
    var productListVC : WMProductListViewController?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        guard let navigationController = UIApplication.sharedApplication().windows[0].rootViewController as? UINavigationController else {
            XCTFail("couldn't get root view controller")
            return
        }
        
        guard let productListVC = navigationController.topViewController as? WMProductListViewController else {
            XCTFail("couldn't get product list VC")
            return
        }
        
        productListVC.delegate = self;
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
        
    func testLoadProductList() {
        loadedWMDataExpectation = expectationWithDescription("@WMLabs data load test")
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func loadedProducts(products: [AnyObject]!) {
        if products.count > 0 {
            loadedWMDataExpectation?.fulfill()
        }
    }
}
