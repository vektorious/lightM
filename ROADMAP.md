## Roadmap 🗺

**Deep analyse your motility assays and get more information out of them!**

lightM comprises software tools and an optional low-cost hardware setup for bacterial motility determination. The analysis is picture based and for now can either be used for end point determination or for monitoring bacteria swarming or fungal growth on agar plates. The software can determine various parameters like shape migration speed, migration direction or shape formation which usually are hard to determine in common assays. An optional lighting chamber can be 3D printed and equipped with single-board computer and a camera to perform on-line motility measurements and analysis.  

### What has to be done?

Here you see the project roadmap with open and completed milestones.


#### Milestone: Build first version of a lighting chamber with camera
Having a proper lighting chamber is very important for picture quality.

- Designed a lid with slot for camera ✅
- Designed a main body for dark field lighting a plate. Inspired by "A bucket of light" from John S. Parkinson [(2007)](http://chemotaxis.biology.utah.edu/Parkinson_Lab/publications/PDFs/Parkinson,%202007b.pdf) ✅
- Test the setup, create a time-lapse video and put it on YouTube [issue #3](https://github.com/vektorious/lightM/issues/2)

#### Milestone: Release of first software version
This should be a simple first version of the software without GUI or anything like that. It should be able to analyse at least two parameters from the pictures: migration area and migration speed over time.
- Detection of agar plate
- Image segmentation to identify migration area
- Migration area and speed over time from picture series

#### Future Goals
There are many thing which can added to the build/software. Here are just some ideas:
- image server
- shape scoring
- deep learning
