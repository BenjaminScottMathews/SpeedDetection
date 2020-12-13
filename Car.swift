//
//  Car.swift
//  RealTimeSpeeding
//
//  Created by Benjamin Mathews on 10/15/20.
//

/*
 This class holds the information of our Car. It is stored in a Dictionary to be checked to figure out if a car is speeding in real time.
 */
import Foundation
import UIKit

/*
 Car is the object which holds all significant info about each car tracked by our tracking class.
 uniqueID: the ID to label and maintain individual cars
 lastCoordinate: the coordinates of the last tracked bounding box
 rgb: The color of the BB, set to either green (not speeding) or red (speeding)
 speed: The speed at which we calculated this car to be traveling
 */
public class Car
{
    private var uniqueID: String
    private var lastCoordinate: [Double]
    private var rgb: UIColor
    private var speed: Int
    
    init (uniqueID: String, lastCoordinate:[Double])
    {
        self.uniqueID = uniqueID
        self.lastCoordinate = lastCoordinate
        rgb = UIColor.green
        speed = 0
    }
    
    //Retruns our unique identifier for this car
    public func getUniqueID() -> String
    {
        return uniqueID
    }
    
    //Get's currently sotred coordinates
    public func getLastCoordinate() -> [Double]
    {
        return lastCoordinate
    }
    
    //Gets RGB value of future bounding box
    public func getRGB() -> UIColor
    {
        return rgb
    }
    
    //Sets RGB value of future bounding box
    public func setRGB(newRGB: UIColor)
    {
        rgb = newRGB
    }
    
    //Set's current speed of this car
    public func setSpeed(score: Int)
    {
        speed = score
    }
    
    //Returns this car's current speed
    public func getSpeedScore() -> Int
    {
        return speed
    }
    
}
