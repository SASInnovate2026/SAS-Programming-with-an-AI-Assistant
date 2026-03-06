%MACRO cars_by_origin(origin_filter=);

    %LET c1 = #6B0030;
    %LET c2 = #A8004F;
    %LET c3 = #D4006A;
    %LET c4 = #F05090;
    %LET c5 = #F78DB8;
    %LET c6 = #FCC6DC;

    /* Uppercase the input for consistent comparison */
    %LET origin_upper = %UPCASE(&origin_filter.);

    /* --- Input Validation --- */
    %IF &origin_upper. NE USA AND
        &origin_upper. NE ASIA AND
        &origin_upper. NE EUROPE AND
        &origin_upper. NE %STR() %THEN %DO;
        %PUT NOTE: Invalid value for origin_filter: "&origin_filter.". Valid values are Asia, Europe, or USA (any case).;
        %RETURN;
    %END;

    /* --- Title Logic --- */
    %IF &origin_upper. = %STR() %THEN %DO;
        %PUT NOTE: No value provided for origin_filter. Generating chart for all origins.;
        %LET title_value = All Origins;
        %LET where_clause = %STR();
    %END;
    %ELSE %IF &origin_upper. = USA %THEN %DO;
        %LET title_value = %UPCASE(&origin_filter.);
        %LET where_clause = %STR(WHERE=(UPCASE(Origin) = "&origin_upper."));
    %END;
    %ELSE %DO;
        %LET title_value = %SYSFUNC(PROPCASE(&origin_filter.));
        %LET where_clause = %STR(WHERE=(UPCASE(Origin) = "&origin_upper."));
    %END;

    /* --- Chart --- */
    PROC SGPLOT DATA=sashelp.cars(&where_clause.) NOAUTOLEGEND;
        STYLEATTRS DATACOLORS=("&c1." "&c2." "&c3." "&c4." "&c5." "&c6.")
                   DATACONTRASTCOLORS=("&c1." "&c2." "&c3." "&c4." "&c5." "&c6.");
        VBAR Type / DATALABEL CATEGORYORDER=RESPDESC GROUP=Type OUTLINEATTRS=(COLOR=WHITE THICKNESS=0);
        XAXIS LABEL='Vehicle Type';
        YAXIS LABEL='Number of Cars';
        TITLE "Number of Cars by Vehicle Type — Origin: &title_value.";
    RUN;
    TITLE;

%MEND cars_by_origin;


/* --- Example Calls --- */
%cars_by_origin(origin_filter=usa)      /* Title: USA    */
%cars_by_origin(origin_filter=Asia)     /* Title: Asia   */
%cars_by_origin(origin_filter=EUROPE)   /* Title: Europe */
%cars_by_origin(origin_filter=)         /* All origins, note to log */
%cars_by_origin(origin_filter=Canada)   /* Invalid, note to log     */