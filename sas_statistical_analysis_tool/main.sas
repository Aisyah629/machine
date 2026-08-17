/**
 * SAS Statistical Analysis Tool
 * Main execution script
 */

/* Set system options */
options nodate nonumber pagesize=60 linesize=80;

/* Define the main analysis macro */
%macro run_analysis(data_set=, analysis_type=descriptive);
    %put NOTE: Starting analysis on data set &data_set with type &analysis_type.;

    /* Check if data set exists */
    %if %sysfunc(exist(&data_set)) = 0 %then %do;
        %put ERROR: Data set &data_set does not exist.;
        %return;
    %end;

    /* Create a copy to avoid modifying original */
    data temp_data;
        set &data_set;
    run;

    /* Perform analysis based on type */
    %if &analysis_type = descriptive %then %do;
        proc means data=temp_data n mean std min max;
            var _numeric_;
        run;
    %end;
    %else %if &analysis_type = regression %then %do;
        proc reg data=temp_data;
            model _numeric_ = _numeric_ / selection=stepwise;
        run;
    %end;
    %else %if &analysis_type = ttest %then %do;
        proc ttest data=temp_data;
            class _character_;
            var _numeric_;
        run;
    %end;
    %else %do;
        %put ERROR: Unknown analysis type: &analysis_type.;
    %end;

    /* Clean up temp data */
    proc datasets library=work nolist;
        delete temp_data;
    quit;

    %put NOTE: Analysis complete.;
%mend run_analysis;

/* Example usage (uncomment to run)
%run_analysis(data_set=sashelp.cars, analysis_type=descriptive);
*/
