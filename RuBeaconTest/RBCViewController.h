//
//  RBCViewController.h
//  RuBeaconTest
//
//  Created by Sergey Korolev on 26.07.14.
//  Copyright (c) 2014 RuBeacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreLocation;
@import CoreBluetooth;

//@interface RBCViewController : UIViewController
@interface RBCViewController: UIViewController <CLLocationManagerDelegate, CBPeripheralManagerDelegate>

@end
