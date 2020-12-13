//
//  Wrapper.m
//  ObjectDetection
//
//  Created by Benjamin Mathews on 11/13/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//
// This class takes in an NSMutableArray of coordinates for bounding boxes and passes those to our written C++ code
// The C++ code returns a set of bounding boxes with unique identifiers to be tracked for speeding

#import <Foundation/Foundation.h>

#import "Wrapper.h"
#import "Tracker.hpp"
#import "track.hpp"

@implementation Wrapper

- (NSMutableArray *) grabBoxes: (NSMutableArray *) tfBoxes
{
    //Here we will convert the boxes to a valid vector
    vector<vector<double>> tfOutBoxes;
    int coordCount = 0;  //We must organize the coordinates into groups of 4
    vector<double> currObject;
    
    for (NSNumber *num in tfBoxes)
    {
        if (coordCount < 3) //The first 3 coordinates
        {
            currObject.push_back(num.doubleValue);
            coordCount+=1;
        }
        else    //The 4th coordinate in a group
        {
            currObject.push_back(num.doubleValue);
            tfOutBoxes.push_back(currObject);
            coordCount = 0;
        }
    }
    
    
    
    //Call function with array
    Track tracker;
    vector<Tracker> speedNums = tracker.pipline(tfOutBoxes);
    
    //We need to convert our returned vector<Tracker> into an NSMutableArray to pass back to Swift
    NSMutableArray *boxAndID = [NSMutableArray array];
    for(int i=0; i<speedNums.size(); i++)
    {
        vector<double> currBoxes = speedNums[i].getBoxes();
        NSMutableArray *boxList = [NSMutableArray array];
        for(int j=0; j<currBoxes.size(); j++)
        {
            NSNumber *myCoord = [NSNumber numberWithDouble:currBoxes[j]];  //Converts each individual coordinate to NSNumber
            boxList[j] = myCoord;
        }
        
        //Convert our uniqueID to NSString
        string uniqueIDString = speedNums[i].getID();
        NSString * uniqueID = [NSString stringWithCString:uniqueIDString.c_str() encoding:[NSString defaultCStringEncoding]];
       
        [boxAndID addObject:uniqueID];
        [boxAndID addObject:boxList];
    }
    //Our NSMutableArray which alternates object types between UniqueID: String and Coordinates: NSMutableArray
    return boxAndID;
}
@end
