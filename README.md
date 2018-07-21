# SwingDev iOS Recruitment Assignment
Lipiec 2018  
<br> 


The goal of this test assignment is to create a native iOS application which will display the current location of the International Space Station (ISS) on a map. You can obtain the location of the ISS from a public API: *http://api.open-notify.org/iss-now.json*

Along with the space station's location we'll also want to know who's currently in space. We can get a list of the astronauts' names using another endpoint from this API: *http://api.open-notify.org/astros.json*

For displaying the actual map on the device we would like you to use the **Mapbox SDK**.

## Requirements
1.	Once the application is started it should move the map camera to the last known position of the ISS, if possible.
2.	Clicking on the map marker representing the ISS should display a map bubble annotation with a list of people currently in space (this list can be a simple string).
3.	The last status of the ISS (position and time) should be stored locally on the device (in a database or in User Defaults) and updated every time we get data from the API.
4.	Along with the map view, the app should display the time of last API sync somewhere in the UI.
5.	The application should query the API for data periodically with some fixed time interval (e.g. 5 seconds) and reflect the new state in the UI.

## Description
**Project consists of two branches:**

* MVC
* MVVM - in implementation
