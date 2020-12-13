//
//  Wrapper.h
//  ObjectDetection
//
//  Created by Benjamin Mathews on 11/13/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wrapper : NSObject

- (NSMutableArray *) grabBoxes:(NSMutableArray *) tfBoxes;

@end
