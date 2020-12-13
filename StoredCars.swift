//
//  StoredCars.swift
//  ObjectDetection
//
//  Created by Benjamin Mathews on 10/22/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

/*
 This class is designed to calculate if a car is speeding in real time
 We track a cars movement through bounding boxes frame x frame
 */
public class StoredCars
{
    //Instance Variables
    private var storedCars: [String:Car]
    private var averageSpeed: CLLocationSpeed //Our current speed to be compared with the calculated speed
    private let timeBetweenCalls: Double = 0.23333  //We check every 7 frames @30fps (1/30*7 = .23333)
    private let avgFirstSightCarDist: Double = 19.5 //Avg distance we first pick up a car (in ft)
    
    init()
    {
        storedCars = [:]
        averageSpeed = CLLocationSpeed()
    }
   
    //Translates our current meters/sec speed to mph and sets our speed variable to that number
    public func setCurrSpeed(currSpeed: CLLocationSpeed) {averageSpeed = currSpeed * 2.23694} //2.23694 is for meters/sec -> mph
    
    //Returns our current speed
    public func getCurrSpeed()->Int {return Int(averageSpeed)}
    
    //Adds a car to our dictionary
    public func addCar(car: Car)
    {
        let uniqueID = car.getUniqueID()
        storedCars[uniqueID] = car
    }
    
    //Returns a car based on it's unique ID
    public func getCar(ID: String) -> Car
    {
        return storedCars[ID]! //Safe to force unwrap as we've already checked that it exists
    }
    
    //Returns if a specific car ID is in our dictionary
    public func contains(ID: String) -> Bool
    {
        if (storedCars[ID] != nil){return true}
        return false;
    }
    
    /*
     * Calculates the area of the bounding box given as coordinate parameter
     */
    func calculateArea(coordinate : [Double]) -> Double
    {
        //To calculate area of the bounding box
        let y1: Double = coordinate[0]
        let x1: Double = coordinate[1]
        
        let y2: Double = coordinate[2]
        let x2: Double = coordinate[3]
        
        let area: Double = abs(x2-x1) * abs(y2-y1)
        return area
    }
    
    /*
     * Detects speeding of car parameter by comparing change in area of bounding box coordinates
     * Uses that change to approximate the distance traveled in the amount of time given
     */
    public func detectSpeeding(car: Car, newCoordinate: [Double])
    {
        //Calculate the area of each bouding box (old and new)
        let oldCoordinate: [Double] = car.getLastCoordinate()
        let a = calculateArea(coordinate: oldCoordinate)
        let b = calculateArea(coordinate: newCoordinate)

        //Use the average first sight of car to approximate start distance
        let distance1 = avgFirstSightCarDist //ft
        let distance2 = (a/b) //The distance car 2 is from us based on ratio of BB area change
        
        let speed: Double = averageSpeed //Our speed
        let mph: Double = (((distance2-distance1)/timeBetweenCalls)*360)/5280   //numbers are for ft/sec -> mph calculation

        if (mph > 10) {car.setRGB(newRGB: UIColor.red)} //If they're going more than 10 mph faster than us, make their box red
        else {car.setRGB(newRGB: UIColor.green)} //Otherwise, their box should be green
        car.setSpeed(score: Int(mph+speed)) //We get their relative speed, which we add to our speed
    }
}
