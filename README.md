# Ethiopia_EMM

This study incorporates seasonality and subseasonal forecasts into an economy-wide multimarket model (EMM) of Ethiopia. Users here may recreate the analysis using the included files, available online at https://github.com/wss-wisc/Ethiopia_EMM. The following files and components include:

(1) GAMS script files: calibrationBASE_Lala.gms (calibration of the baseline 2015 data), simulation_Lala.gms (runs simulations over entire 1981-2020 historical period), and sim_exportxls.gms (optional additional instructions for exporting outputs to .xls files)

(2) INC files: additional text files to assist with runnign GAMS scripts, mapping simulation parameters to outputs

(3) Input files: Input data for the simulations, including:

    (3.1) inputdatafile_updated2020.xls: General economic and agricultural data based on Agricultural Sample Surveys and Household Income, Consumption, and Expenditure surveys from the Ethiopian Central Statistical Agency
    (3.2) inputusefile_updated2020.xls: Contains technology inputs--e.g. fertilizer or irrigation--for all major crops and zones
    (3.3)  newcyf_updated2020.xls: climate yield factors (CYFs) for 1981-2020 historical period for each season
    (3.4) kcmean.xls: average CYFs over all years
    (3.5) yieldgains_onsetfcst.xls: forecast-informed yield gains from Lala et al. (2020; doi:10.1088/1748-9326/abf9c9)
    (3.6) "shifted" versions of 3.3-3.5 to account for how the model incorporates interseasonal storage
   
Once researchers have all the necessary data components from the GitHub repository, the analyses should be able to be reproduced. For further details on the model setup, procedure, etc. please refer to the manuscript text and appendix.
