/******************************************************/
/* SAS Programming with an AI Assistant               */
/* SAS Innovate 2026                                  */
/* Demo 2: Graphing and Navigating LLM Hallucinations */
/******************************************************/

/* Prompt 1:
Create a vertical bar chart that displays the number of cars for each value of Type.
*/

/* Add title */
title "Number of Cars by Type";

/* Vertical bar chart of car counts by Type */
proc sgplot data=sashelp.cars;
    vbar Type / stat=freq;   /* Compute and display frequency counts */
run;

/* Clear title */
title;

/* Prompt 2: 
Can you order the bars by descending frequency?
*Desired response: categoryorder=respdesc on the VBAR statement
*/

title "Number of Cars by Type (Ordered by Descending Frequency)";

proc sgplot data=sashelp.cars;
    vbar Type / stat=freq categoryorder=respdesc;
run;

title;

/* Prompt 3:
Can you add data labels to each bar?
*/

title "Number of Cars by Type";

/* Vertical bar chart with frequency labels */
proc sgplot data=sashelp.cars;
    vbar Type / 
        stat=freq
        datalabel categoryorder=respdesc;   /* Display count on each bar */
run;

/* Clear title */
title;

/* Prompt 4:
How can I make each bar a different color?
*Desired response: group=Type on the VBAR statement and
                   STYLEATTRS datacolors=(hex-color-list) statement
*/

title "Number of Cars by Type (Ordered by Descending Frequency)";

proc sgplot data=sashelp.cars;
    styleattrs datacolors=(cx4E79A7 cxF28E2B cxE15759 cx76B7B2 cx59A14F cxEDC948);

    vbar Type /
        stat=freq
        categoryorder=respdesc
        group=Type
        groupdisplay=cluster
        datalabel;
run;

title;

/* Prompt 5:
Can you make a color scheme for shades of dark to light pink?
*/

/* Add title */
title "Number of Cars by Type (Ordered by Descending Frequency)";

/* Pink gradient color scheme */
proc sgplot data=sashelp.cars;

    /* Dark → Light Pink */
    styleattrs datacolors=(
        cx8B004B   /* Dark magenta-pink */
        cxC2185B   /* Deep pink */
        cxE91E63   /* Medium pink */
        cxF06292   /* Light pink */
        cxF8BBD0   /* Very light pink */
        cxFCE4EC   /* Pale blush */
    );

    vbar Type /
        stat=freq
        categoryorder=respdesc
        group=Type
        groupdisplay=cluster
        datalabel;
run;

/* Prompt 6:
How can I remove the outline around each bar? 
Desired response: nooutline on the VBAR statement
*/

/* Add title */
title "Number of Cars by Type (Ordered by Descending Frequency)";

/* Pink gradient color scheme */
proc sgplot data=sashelp.cars;

    /* Dark → Light Pink */
    styleattrs datacolors=(
        cx8B004B   /* Dark magenta-pink */
        cxC2185B   /* Deep pink */
        cxE91E63   /* Medium pink */
        cxF06292   /* Light pink */
        cxF8BBD0   /* Very light pink */
        cxFCE4EC   /* Pale blush */
    );

    vbar Type /
        stat=freq
        categoryorder=respdesc
        group=Type
        groupdisplay=cluster
        datalabel
        nooutline;
run;

title;

/* Prompt 7: 
Add a macro variable to the step to filter the bar chart for a specified value of Origin.
*/

/* User-specified Origin */
%let origin_filter = Asia;

title "Number of Cars by Type for &origin_filter (Ordered by Descending Frequency)";

proc sgplot data=sashelp.cars(
               where=(Origin="&origin_filter")
            );

    /* Dark  Light Pink gradient */
    styleattrs datacolors=(
        cx8B004B
        cxC2185B
        cxE91E63
        cxF06292
        cxF8BBD0
        cxFCE4EC
    );

    vbar Type /
        stat=freq
        categoryorder=respdesc
        group=Type
        groupdisplay=cluster
        datalabel
        nooutline;
run;

title;   /* Clear title */

/* Prompt 8:
Make the filter case insensitive.
*/

/* User input (can be any case) */
%let origin_filter = usa;

/* Proper-case version for display in title */
%let origin_display = %sysfunc(propcase(&origin_filter));

title "Number of Cars by Type for &origin_display (Ordered by Descending Frequency)";

proc sgplot data=sashelp.cars(
              where=(upcase(Origin)=upcase("&origin_filter"))  /* Case-insensitive filter */
            );

    /* Dark  Light Pink gradient */
    styleattrs datacolors=(
        cx8B004B
        cxC2185B
        cxE91E63
        cxF06292
        cxF8BBD0
        cxFCE4EC
    );

    vbar Type /
        stat=freq
        categoryorder=respdesc
        group=Type
        groupdisplay=cluster
        datalabel
        nooutline;   /* Remove borders */

run;

title;   /* Clear title */

/* Prompt 9:
Define a macro and use macro conditional processing.
If the value of the macro variable is usa, then UPCASE the value in the title. 
Else, PROPCASE the value. 
If the value is not Asia, USA, or Europe, write a note to the log that the valid values are Asia, Europe, or USA in any case.
If no value is provided, create the bar chart for all origins and write a note to the log.
*/

/* Define macro */
%macro origin_chart(origin_filter);

    /* Check if parameter is missing */
    %if %length(&origin_filter) = 0 %then %do;

        %put NOTE: No origin_filter specified. Chart generated for ALL origins.;

        title "Number of Cars by Type for All Origins (Ordered by Descending Frequency)";

        proc sgplot data=sashelp.cars;

            styleattrs datacolors=(
                cx8B004B
                cxC2185B
                cxE91E63
                cxF06292
                cxF8BBD0
                cxFCE4EC
            );

            vbar Type /
                stat=freq
                categoryorder=respdesc
                group=Type
                groupdisplay=cluster
                datalabel
                nooutline;

        run;

        title;

    %end;

    %else %do;

        /* Standardize for validation */
        %let origin_check = %upcase(&origin_filter);

        /* Validate Origin value */
        %if &origin_check = USA or 
            &origin_check = ASIA or 
            &origin_check = EUROPE %then %do;

            /* Title formatting logic */
            %if &origin_check = USA %then %do;
                %let origin_display = %upcase(&origin_filter);
            %end;
            %else %do;
                %let origin_display = %sysfunc(propcase(&origin_filter));
            %end;

            title "Number of Cars by Type for &origin_display (Ordered by Descending Frequency)";

            proc sgplot data=sashelp.cars(
                           where=(upcase(Origin)="&origin_check")
                        );

                styleattrs datacolors=(
                    cx8B004B
                    cxC2185B
                    cxE91E63
                    cxF06292
                    cxF8BBD0
                    cxFCE4EC
                );

                vbar Type /
                    stat=freq
                    categoryorder=respdesc
                    group=Type
                    groupdisplay=cluster
                    datalabel
                    nooutline;
            run;

            title;

        %end;

        %else %do;
            %put NOTE: Valid values for origin_filter are Asia, Europe, or USA (any case).;
            %put NOTE: Chart was not generated.;
        %end;

    %end;

%mend origin_chart;

%origin_chart();
%origin_chart(asia);
%origin_chart(usa);
%origin_chart(Europe);
%origin_chart(africa);