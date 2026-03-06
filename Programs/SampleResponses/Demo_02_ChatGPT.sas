/* Add title */
title "Number of Cars by Type";

/* Vertical bar chart of car counts by Type */
proc sgplot data=sashelp.cars;
    vbar Type / stat=freq;   /* Compute and display frequency counts */
run;

/* Clear title */
title;

title "Number of Cars by Type (Ordered by Descending Frequency)";

proc sgplot data=sashelp.cars;
    vbar Type / stat=freq categoryorder=respdesc;
run;

title;

/* Add title */
title "Number of Cars by Type";

/* Vertical bar chart with frequency labels */
proc sgplot data=sashelp.cars;
    vbar Type / 
        stat=freq
        datalabel categoryorder=respdesc;   /* Display count on each bar */
run;

/* Clear title */
title;

/* Add title */
title "Number of Cars by Type (Ordered by Descending Frequency)";

/* Vertical bar chart with different colors per bar */
proc sgplot data=sashelp.cars;
    vbar Type /
        stat=freq
        categoryorder=respdesc
        group=Type              /* Assign different color per Type */
        groupdisplay=cluster    /* Ensures proper grouping behavior */
        datalabel;              /* Display frequency on bars */
run;

/* Clear title */
title;

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

title "Number of Cars by Type (Ordered by Descending Frequency)";

proc sgplot data=sashelp.cars;

    /* Pink gradient */
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
        /* not preferred because outline is still in legend */
        outlineattrs=(thickness=0);   /* Remove bar borders */
/* hallucinated this is not valid */
    /* keylegend / display=none;         Optional: remove legend */
run;

title;

/* Clear title */
title;

/* User-specified Origin (can be any case) */
%let origin_filter = asia;

/* Proper-case version for title display */
%let origin_display = %sysfunc(propcase(&origin_filter));

title "Number of Cars by Type for &origin_display (Ordered by Descending Frequency)";

proc sgplot data=sashelp.cars(
               where=(upcase(Origin)=upcase("&origin_filter"))
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
        outlineattrs=(thickness=0);


run;

title;   /* Clear title */

/* User input (can be any case) */
%let origin_filter = asia;

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
        outlineattrs=(thickness=0);   /* Remove borders */

run;

title;   /* Clear title */

/* User input (can be any case) */
%let origin_filter = usa;

/* Standardize for comparison */
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
            outlineattrs=(thickness=0);

        keylegend / display=none;

    run;

    title;

%end;

%else %do;

    %put NOTE: Valid values for origin_filter are Asia, Europe, or USA (any case).;
    %put NOTE: Chart was not generated.;

%end;

/* Define macro */
%macro origin_chart(origin_filter);

    /* Standardize for comparison */
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
                outlineattrs=(thickness=0);

        run;

        title;

    %end;

    %else %do;
        %put NOTE: Valid values for origin_filter are Asia, Europe, or USA (any case).;
        %put NOTE: Chart was not generated.;
    %end;

%mend origin_chart;

/* Call the macro */
%origin_chart(africa);

