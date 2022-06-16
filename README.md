# Ethiopia_EMM

This study incorporates seasonality and subseasonal forecasts into an economy-wide multimarket model (EMM) of Ethiopia. Users here may recreate the analysis using the included files, available online at https://github.com/wss-wisc/Ethiopia_EMM. The following files and components include:

(1) GAMS script files: calibrationBASE_Lala.gms (calibration of the baseline 2015 data), simulation_Lala.gms (runs simulations over entire 1981-2020 historical period), and sim_exportxls.gms (optional additional instructions for exporting outputs to .xls files)

(2) INC files: additional text files to assist with runnign GAMS scripts, mapping simulation parameters to outputs

(3) Input files: Input data for the simulations, including...
    (3.1) inputdatafile_updated2020.xls: General economic and agricultural data based on Agricultural Sample Surveys and Household Income, Consumption, and Expenditure surveys from the Ethiopian Central Statistical Agency
    (3.2) inputusefile_updated2020.xls: Contains technology inputs--e.g. fertilizer or irrigation--for all major crops and zones
    (3.3) kcmean.xls:
    (3.4) newcyf_updated2020.xls: 
    (3.5) yieldgains_onsetfcst.xls: 
    (3.6) "shifted" versions of 3.3-3.5 to account for how the model incorporates interseasonal storage
    
    
    The agent-based model, which was written by researchers at the University of Wisconsin – Madison (the authors of this text) using the NetLogo software. The name of this file is “AlexanderBlock_ABM_2021.nlogo”. Four different simulations were performed, as described in the manuscript. To run each respective simulation, follow the instructions in the code comments to include/omit sections of the code as relevant. To run simulations across bootstrapped forecasts and different random seeds, the BehaviorSpace feature was used. The resulting outputs were then imported to Matlab to generate figures and analyze results.

    The Matlab code to analyze output and generate figures. The code needed to import the NetLogo output in .csv format, perform analysis, and generate figures is included under the file name “AlexanderBlock_FigureCode.” The code sections are separated by figure in the manuscript, with comments to guide the reader.

Once researchers have all the necessary data components from the GitHub repository, the analyses should be able to be reproduced. For further details on the model setup, procedure, etc. please refer to the manuscript text ODD protocol.
