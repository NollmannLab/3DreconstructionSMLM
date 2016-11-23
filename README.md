# 3DreconstructionSMLM
A suite of routines to reconstruct 3D structures from 2D projections of single-molecule localization microscopy data

The project contains several folders.

1) T4 has the MATLAB m-files and TIFF files necessary to simulate raw images that are then used in SPIDER for single-particle analysis.
SimT4_Main.m contains the main m-file. When executed, this script asks the user for the parameters to be used in the simulation of the datasets. The parameters are well described within the text of the program.
The reminder of m-files in this directory contain functions called by SimT4_Main.m

2) Spiral contains MATLAB m-files to produce raw images of a spiral structure (intrinsically asymmetric).

3) Duckling contains MATLAB m-files to produce raw images of an asymmetric duckling structure.

4) Functions contains several MATLAB m-files with common functions used by the different folders.

5) T4_IMAGIC folder contains an example script used for the 3D reconstruction of the T4 bacteriophage.
Files are numbered according to the sequential order in which IMAGIC functions were executed, and contain the function names and parameters used for each step. Files are in raw text format.
