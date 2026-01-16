# COMPVis - Computer Vision Object Detection Project

## Overview
This MATLAB-based computer vision project demonstrates object detection using template matching techniques. The project includes two main detection tasks: identifying apples in tree images and locating cars in parking lot scenes.

## Project Contents

### MATLAB Scripts
- **FindApples.m** - Apple detection algorithm for tree images
- **FindCars.m** - Car detection algorithm for parking lot scenes

### Input Images
- **Apple_Tree_A.jpg** - Source image containing apples to be detected
- **Cars.png** - Source image containing multiple cars
- **Template_Car.png** - Template image used for car matching

### Output Images
- **FoundApples.PNG** - Result showing detected apples with bounding boxes/markers
- **FoundBestCar.PNG** - Result highlighting the best matching car
- **FoundCars.PNG** - Result showing the top 5 most similar cars detected

## Features

### Apple Detection
The apple detection script processes tree images to identify and locate individual apples, likely using color segmentation and shape analysis techniques optimized for red/green apple identification in natural outdoor scenes.

### Car Detection
The car detection implementation uses template matching to:
- Identify multiple car instances in a parking lot scene
- Rank matches by similarity score
- Highlight the top 5 most similar matches
- Isolate the single best matching car

## Requirements

- **MATLAB** (R2018b or later recommended)
- **Image Processing Toolbox**
- All project files must be in the same directory

## Installation & Setup

1. Clone or download this repository to your local machine
2. Ensure all `.m` files and images are in the same folder
3. Open MATLAB and navigate to the project directory

## Usage

### Running Apple Detection
```matlab
% In MATLAB command window
FindApples
```
This will process `Apple_Tree_A.jpg` and display detected apples.

### Running Car Detection
```matlab
% In MATLAB command window
FindCars
```
This will process `Cars.png` using `Template_Car.png` and display:
- The 5 most similar car matches
- The single best matching car

## Expected Output

### Apple Detection
- Processed image with detected apples highlighted
- Visual markers or bounding boxes around identified apples
- Count of total apples detected

### Car Detection
- **Multiple Matches**: Top 5 cars ranked by similarity to template
- **Best Match**: Single car with highest correlation score
- Visual indicators showing detection confidence

## Implementation Notes

### Template Matching Approach
The car detection likely uses normalized cross-correlation or similar matching algorithms to compare the template car against different regions of the target image.

### Detection Techniques
- **Color-based segmentation** for apple detection in natural scenes
- **Template matching** for structured object detection (cars)
- **Morphological operations** for noise reduction and shape refinement
- **Similarity scoring** for ranking multiple detections

## Troubleshooting

### Common Issues
- **Path Errors**: Ensure all files are in MATLAB's current working directory
- **Image Format**: Verify image files are not corrupted and are standard formats (JPG, PNG)
- **Missing Toolbox**: Confirm Image Processing Toolbox is installed

### Verification Steps
```matlab
% Check if Image Processing Toolbox is available
ver ImageProcessingToolbox

% Verify files exist in current directory
dir *.jpg
dir *.png
dir *.m
```

## Project Applications

This computer vision project demonstrates practical applications in:
- **Agricultural monitoring** - Automated fruit counting for harvest estimation
- **Vehicle management** - Parking lot monitoring and vehicle tracking
- **Template matching** - Generic object detection in controlled environments
- **Image analysis** - Feature detection and similarity scoring

## Future Enhancements

Potential improvements for this project:
- Multi-scale template matching for variable-sized objects
- Machine learning integration for improved accuracy
- Real-time video processing capabilities
- Detection confidence scoring and threshold adjustment
- Support for additional object types and scenarios

## License

Please refer to repository settings for license information.

## Acknowledgments

Developed as part of a computer vision course project demonstrating fundamental object detection techniques using MATLAB.

---

## Quick Start

1. **Download** all repository files to a single folder
2. **Open MATLAB** and set the folder as your working directory
3. **Run** `FindApples` to see apple detection results
4. **Run** `FindCars` to see car detection results
5. **Examine** output images to verify detection accuracy

For questions or issues, please use the repository's issue tracker.
