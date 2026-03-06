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
                outlineattrs=(thickness=0);

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
                    outlineattrs=(thickness=0);
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