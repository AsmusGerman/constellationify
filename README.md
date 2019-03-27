# Constellationify
Constellationify is a project code based on Matlab/Octave using OOP paradigm to obtain a descriptive set of characteristics for each one of the 88 constellations and facilitate comparison with other graphic representations of them or similar.

# Motivation
Constellationify is an academic project that was born with solid foundations in the OOP paradigm and modern programming concepts, using the power of Matlab / Octave for image processing and [ALR3](https://www.researchgate.net/publication/328049660_Zernike_Moments_vs_ALR3_Applied_to_Similarity_Searching_of_Cattle_Brands) algorithm to obtain the characteristics that represent each image.

# Example
## Octave

```bash

octave --no-gui

octave:1> andromeda = dir('…\assets\images\andromeda.png'); %use full path
octave:2> Constellationify(andromeda);

```
