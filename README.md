# Fooder

*NOTE:* michellexu1 is the account of an individual whose mac computer HARRISON LU borrowed to complete this project in using xcode. 

This was a semester long project in which we created an app that makes restaurant recommendations to users who may often be undecided as to what they wish to eat. The purpose of the class was to experience what it is like developing a project in an agile with sprints environment, as well as having a functional version of an app (with ideas for improvements). 

The app uses pearson correlation to determine what types of cuisines users may or may not enjoy. We also were in the process of improving our application by implementing more advanced machine learning algorithms when the class ended. There were a small list of bugs and improvements that we were also in the process of correcting/making, but did not have time to do so before the semester was over.

Current Bugs: 
 - very occasionally, loading to the choose restaurant view page crashes the app
 - in choose restaurant view, when one image is undergoing slide show and another image is tapped, the first image jumps back to image 1 in array.
- some images are not proportioned correctly, seem to be either squeezed or stretched into the UIView
- after long press, the map loads twice

TODO: 	
- implement accurate current location
- implement the detection of user preferences based on prior selections
- make app look better:
  - rounded corners?
  - opening loading screen?
  - have image appear under the current image being swiped?
  - image “bounces” after swiping previous image away
- implement reviews and rating
- make previous and next button disappear 
