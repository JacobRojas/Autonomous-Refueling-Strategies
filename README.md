# SGAS
This project was part of an REU undergraduate research summer program funded by NSF at Texas State University.

Disclaimer:
This material is based upon work supported by the National Science Foundation under REU grant \#1757893. Any opinions, findings, and conclusions or recommendations expressed in this material are those of the authors and do not necessarily reflect the views of the National Science Foundation.

# File Usage
## Graph5.m
This file is used to graph our results. You can set the simulation function to either SGAS5 of ML for either the Constant Density Approximation solution or the Machine LEarning solution respectively. To graph the Perfect Prediction, go to the SGAS5 file and un comment the `temp = ` line and `k = ` line to set k equal to the ground truth value.

## realScipt.m
This file is used to create the labeled data to feed into the machine learning model for training. However we did the standardization of the inputs in Excel so that is not part of the script.

## Octave: A Side Note
Most of the Matlab code can be ran in octave except for the `reallife` script which I made an Octave counter part script `reallife_octave` to be used if running the scripts in an Octave environment. The purpose of `reallife` is to take a CSV file of gas station data and convert it into a `highway` for the MatLab simulations to be run on.

## scrape.py
This file converts html files pulled from GasBuddy.com Trip Planner into CSV files that our other scripts can read.
eg. `python scrape.py Trip*.html` to scape all pages. However it will skip any files that already have a cooresponding CSV.

## append.py
Adds an html comment at the head of a GasBuddy file to specify the location for easy access. eg. `python append.py Trip*.py` Will skip html files with comment as first line.

## analyze.py
Prints out statistics for Trips. eg. `python analyze.py Trip*.csv`
Must be run before label.py

## label.py
First run analyze.py to get lengths.csv. Then simply run `python label.py` to label how many gas stations are in certain sections of the highway for all the analyzed trips.

## plot.py
Plots one (1) trip with the x-axis as the position along the highway and the y-axis being the price of gas. This helps me visualize what a Trip looks like. Usage: `python plot Trip32.csv`

## his.py
Plots a histogram of gas prices for a Trip. This helps me see of the resulting gas price of a simulation run is a good price or not. Usage `python hist.py Trip20.csv`

## machinelearning.py
Trains a machine learning model. Usage: `python machinelearning.py inputs.csv`
`inputs.csv` is a CSV where each line is a data set. A data set consists of n inputs (prefereably standardized) and the last comma separated value being the label for the data. The machine learning script will then output a vector `A` (1xn) and a scalar value `b`. Now any input vector x (1xn) can be calculated into an output with the formula `A * x' + b` where `x'` is the transverse of x.

# Printing out figures
The current general procedure for printing out the figures in the paper are as follows
1. Set style ':rs'
2. Run Graph5 with SGAS5 with temp and k commentd out
3. Set style ':gx'
4. Run Graph5 with SGAS5 with temp and k not commented out
5. Set style ':bo'
6. Run Graph5 with ML
7. run `subplot(2, 3, 1)`
8. run `x = legend("Perfect Prediction", "Const. Density Approx.", "Machine Learning")`
9. run `set(x, "color", "none")` for transparency purposes
10. run `export_fig fig.png -transparent`
11. You may then need to crop the figure because the bottom graphs are for changing the start of the critically low section

Note: Step 10 requires a package `altmany-export_fig` which you can simply download then place the folder in your MatLab directory then run the command `addpath('altmany-export_fig-b1a7288')` so that MatLab can find the required files.
