/* Vertical bar chart: count of cars by Type */
PROC SGPLOT DATA=sashelp.cars;
    VBAR Type / DATALABEL;
    XAXIS LABEL='Vehicle Type';
    YAXIS LABEL='Number of Cars';
    TITLE 'Number of Cars by Vehicle Type';
RUN;
TITLE;

/* Vertical bar chart: count of cars by Type, ordered by descending frequency */
PROC SGPLOT DATA=sashelp.cars;
    VBAR Type / DATALABEL CATEGORYORDER=RESPDESC;
    XAXIS LABEL='Vehicle Type';
    YAXIS LABEL='Number of Cars';
    TITLE 'Number of Cars by Vehicle Type';
RUN;
TITLE;

/* Vertical bar chart: count of cars by Type, ordered by descending frequency, colored by Type */
PROC SGPLOT DATA=sashelp.cars;
    VBAR Type / DATALABEL CATEGORYORDER=RESPDESC GROUP=Type;
    XAXIS LABEL='Vehicle Type';
    YAXIS LABEL='Number of Cars';
    TITLE 'Number of Cars by Vehicle Type';
RUN;
TITLE;

/* Hallucinates with the color scheme */

/* Define a custom style with a pink color palette */
PROC TEMPLATE;
    DEFINE STYLE pinkstyle;
        PARENT = styles.htmlblue;
        STYLE GRAPHDATA1  / COLOR='#6B0030'; /* Darkest pink/burgundy  */
        STYLE GRAPHDATA2  / COLOR='#A8004F'; /* Dark pink              */
        STYLE GRAPHDATA3  / COLOR='#D4006A'; /* Medium dark pink       */
        STYLE GRAPHDATA4  / COLOR='#F05090'; /* Medium pink            */
        STYLE GRAPHDATA5  / COLOR='#F78DB8'; /* Light pink             */
        STYLE GRAPHDATA6  / COLOR='#FCC6DC'; /* Lightest pink          */
    END;
RUN;

/* Apply the custom style and render the chart */
ODS STYLE=pinkstyle;

PROC SGPLOT DATA=sashelp.cars NOAUTOLEGEND;
    VBAR Type / DATALABEL CATEGORYORDER=RESPDESC GROUP=Type;
    XAXIS LABEL='Vehicle Type';
    YAXIS LABEL='Number of Cars';
    TITLE 'Number of Cars by Vehicle Type';
RUN;
TITLE;

/* Reset to default style */
ODS STYLE=htmlblue;

/* How can I do this without PROC TEMPLATE? */

/* Define pink shades as macro variables for readability */
%LET c1 = #6B0030; /* Darkest pink/burgundy */
%LET c2 = #A8004F; /* Dark pink             */
%LET c3 = #D4006A; /* Medium dark pink      */
%LET c4 = #F05090; /* Medium pink           */
%LET c5 = #F78DB8; /* Light pink            */
%LET c6 = #FCC6DC; /* Lightest pink         */

/* Apply colors directly using STYLEATTRS */
PROC SGPLOT DATA=sashelp.cars NOAUTOLEGEND;
    STYLEATTRS DATACOLORS=("&c1." "&c2." "&c3." "&c4." "&c5." "&c6.");
    VBAR Type / DATALABEL CATEGORYORDER=RESPDESC GROUP=Type;
    XAXIS LABEL='Vehicle Type';
    YAXIS LABEL='Number of Cars';
    TITLE 'Number of Cars by Vehicle Type';
RUN;
TITLE;

/* removes outlines but a workaround */
%LET c1 = #6B0030;
%LET c2 = #A8004F;
%LET c3 = #D4006A;
%LET c4 = #F05090;
%LET c5 = #F78DB8;
%LET c6 = #FCC6DC;

PROC SGPLOT DATA=sashelp.cars NOAUTOLEGEND;
    STYLEATTRS DATACOLORS=("&c1." "&c2." "&c3." "&c4." "&c5." "&c6.")
               DATACONTRASTCOLORS=("&c1." "&c2." "&c3." "&c4." "&c5." "&c6.");
    VBAR Type / DATALABEL CATEGORYORDER=RESPDESC GROUP=Type OUTLINEATTRS=(COLOR=WHITE THICKNESS=0);
    XAXIS LABEL='Vehicle Type';
    YAXIS LABEL='Number of Cars';
    TITLE 'Number of Cars by Vehicle Type';
RUN;
TITLE;

%LET origin_filter = USA;

%LET c1 = #6B0030;
%LET c2 = #A8004F;
%LET c3 = #D4006A;
%LET c4 = #F05090;
%LET c5 = #F78DB8;
%LET c6 = #FCC6DC;

PROC SGPLOT DATA=sashelp.cars(WHERE=(Origin = "&origin_filter.")) NOAUTOLEGEND;
    STYLEATTRS DATACOLORS=("&c1." "&c2." "&c3." "&c4." "&c5." "&c6.")
               DATACONTRASTCOLORS=("&c1." "&c2." "&c3." "&c4." "&c5." "&c6.");
    VBAR Type / DATALABEL CATEGORYORDER=RESPDESC GROUP=Type OUTLINEATTRS=(COLOR=WHITE THICKNESS=0);
    XAXIS LABEL='Vehicle Type';
    YAXIS LABEL='Number of Cars';
    TITLE "Number of Cars by Vehicle Type — Origin: &origin_filter.";
RUN;
TITLE;

%LET origin_filter = usa;

%LET c1 = #6B0030;
%LET c2 = #A8004F;
%LET c3 = #D4006A;
%LET c4 = #F05090;
%LET c5 = #F78DB8;
%LET c6 = #FCC6DC;

PROC SGPLOT DATA=sashelp.cars(WHERE=(UPCASE(Origin) = UPCASE("&origin_filter."))) NOAUTOLEGEND;
    STYLEATTRS DATACOLORS=("&c1." "&c2." "&c3." "&c4." "&c5." "&c6.")
               DATACONTRASTCOLORS=("&c1." "&c2." "&c3." "&c4." "&c5." "&c6.");
    VBAR Type / DATALABEL CATEGORYORDER=RESPDESC GROUP=Type OUTLINEATTRS=(COLOR=WHITE THICKNESS=0);
    XAXIS LABEL='Vehicle Type';
    YAXIS LABEL='Number of Cars';
    TITLE "Number of Cars by Vehicle Type — Origin: &origin_filter.";
RUN;
TITLE;