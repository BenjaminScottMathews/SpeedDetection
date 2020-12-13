# SpeedDetection
Classes to detect speed of a car based on change in area of its bounding box

--Speed Detection--
These classes we're developed alongside another developer's C++ code which confirms that each set of coordinates of bounding boxes stay attached to the same cars as they stay in our frame of vision. These classes we're built on top of the TensorFlow object detection iOS code, which gave us our trained car model for detection.
My Swift classes use the average distance a new car becomes visible, and as that car's bounding box area changes over intervals of 7 frames (in a 30 fps capture, that equates to .2333 seconds), we can estimate the distance traveled by that car over a specific time interval (aka: speed).

--Wrapper--
There are a few different points of interaction between the Swift app and our C++ code. In order to perform this communication, I wrote a Wrapper class in Objective C++ which transforms our Swift data (bounding box coordinates) into language specific types to be analyzed in C++ and passed back to our Swift code. As the C++ code was not written by me, I chose not to include the code in this project.
