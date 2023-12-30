# QLGA (Genetic Algorithm based on Q-learning)
A Q-learning-based Genetic Algorithm based on Matlab for solving multi-objective multi-tool hole-making sequence optimization problems

## 1. Main program
Get started through [MO_MTpcHSO_QLGA](https://github.com/Apple2625/QLGA/blob/master/QLGA/MO_MTpcHSO_QLGA.m)

## 2. Import new dataset
The file type of the new dataset should be set as files with a `.mat` extension. 

Concurrently, the content configuration should align with that of the [W12](https://github.com/Apple2625/QLGA/blob/master/QLGA/W12.mat) - [W36](https://github.com/Apple2625/QLGA/blob/master/QLGA/W36.mat) files in this project, specifically including the following variables:


| Variables                 | Descriptions                           | 
| ------------------------- |:--------------------------------------:|
| CityArray                 | An `n*2` array that contains coordinates of holes, where `n` is the number of holes.|
| CityTools                 | An `n*x` array that contains required tools (tool order) for each hole. If the lengths of the tool orders are not uniform, the excess positions should be filled with `0`.| 
| TimeTable                 | A `J*J` matrix contains tool switching time among tool positions, where `J` is the total number of tools.|
