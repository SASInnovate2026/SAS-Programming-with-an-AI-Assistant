/* Display metadata for the CARS table */
proc contents data=sashelp.cars short varnum;
run;

/* Print the first 20 rows of SASHELP.CARS */
proc print data=sashelp.cars(obs=20);
run;

/* Create a new dataset with MPG_Avg and Doors */
data cars_modified;
    set sashelp.cars;

    /* Compute average MPG (handles missing automatically) */
    MPG_Avg = mean(MPG_City, MPG_Highway);

    /* Determine number of doors from Model text */
    if find(Model, '2dr', 'i') then Doors = 2;
    else if find(Model, '4dr', 'i') then Doors = 4;
    else Doors = .;

    /* Keep only requested variables */
    keep Make Model Type Origin MPG_Avg Doors;
run;

/* Create table with computed columns using PROC SQL */
proc sql;
    create table cars_modified as
    select 
        Make,
        Model,
        Type,
        Origin,

        /* Average MPG (mean ignores missing automatically in SQL) */
        mean(MPG_City, MPG_Highway) as MPG_Avg,

        /* Determine Doors from Model text */
        case
            when find(Model, '2dr', 'i') > 0 then 2
            when find(Model, '4dr', 'i') > 0 then 4
            else .
        end as Doors

    from sashelp.cars;
quit;

/* Count number of cars by Type */
proc freq data=sashelp.cars;
    tables Type / nocum nopercent;
run;

/* Count number of cars by Type using PROC SQL */
proc sql;
    select 
        Type,
        count(*) as Num_Cars
    from sashelp.cars
    group by Type
    order by Type;
quit;

/* Add a title */
title "Number of Cars by Type (Ordered by Descending Frequency)";

/* Frequency report ordered by highest count first */
proc freq data=sashelp.cars order=freq;
    tables Type / nocum nopercent;
run;

/* Clear title (good practice) */
title;

title "Number of Cars by Type (Ordered by Descending Frequency)";

proc sql;
    select 
        Type,
        count(*) as Num_Cars
    from sashelp.cars
    group by Type
    order by Num_Cars desc;
quit;

title;

/* User-specified Make */
%let make_filter = Toyota;

/* Add dynamic title */
title "Number of Cars by Type for &make_filter (Ordered by Descending Frequency)";

/* Frequency report filtered by Make */
proc freq data=sashelp.cars(where=(Make="&make_filter")) order=freq;
    tables Type / nocum nopercent;
run;

/* Clear title */
title;

%let make_filter = toyota;

title "Number of Cars by Type for &make_filter (Ordered by Descending Frequency)";

proc freq data=sashelp.cars(
           where=(upcase(Make)=upcase("&make_filter"))
         ) order=freq;
    tables Type / nocum nopercent;
run;

title;

/* In the second option can you ensure the value of make_filter is capitalized in the title as well */
/* Nice output!! */
/* User input (can be any case) */
%let make_filter = toyota;

/* Create properly capitalized version for display */
%let make_display = %sysfunc(propcase(&make_filter));

title "Number of Cars by Type for &make_display (Ordered by Descending Frequency)";

proc freq data=sashelp.cars(
           where=(upcase(Make)=upcase("&make_filter"))
         ) order=freq;
    tables Type / nocum nopercent;
run;

title;

/* Display metadata for the CARS table */
proc contents data=sashelp.cars short varnum;  /* Show variable names, types, order */
run;

/* Print the first 20 rows of SASHELP.CARS */
proc print data=sashelp.cars(obs=20);          /* Limit output to first 20 observations */
run;

/* Create a new dataset with MPG_Avg and Doors using DATA step */
data cars_modified;                           /* Create new output dataset */
    set sashelp.cars;                         /* Read in original data */

    MPG_Avg = mean(MPG_City, MPG_Highway);    /* Compute average MPG (ignores missing) */

    if find(Model, '2dr', 'i') then Doors = 2;      /* Assign 2 if '2dr' found (case-insensitive) */
    else if find(Model, '4dr', 'i') then Doors = 4; /* Assign 4 if '4dr' found */
    else Doors = .;                                 /* Otherwise assign missing */

    keep Make Model Type Origin MPG_Avg Doors;      /* Keep only selected variables */
run;

/* Create same result using PROC SQL */
proc sql;
    create table cars_modified as              /* Create table via SQL */
    select 
        Make,
        Model,
        Type,
        Origin,
        mean(MPG_City, MPG_Highway) as MPG_Avg,   /* Compute average MPG */
        case                                       /* Conditional logic for Doors */
            when find(Model, '2dr', 'i') > 0 then 2
            when find(Model, '4dr', 'i') > 0 then 4
            else .
        end as Doors
    from sashelp.cars;
quit;

/* Count number of cars by Type using PROC FREQ */
proc freq data=sashelp.cars;
    tables Type / nocum nopercent;  /* Show counts only */
run;

/* Count number of cars by Type using PROC SQL */
proc sql;
    select 
        Type,
        count(*) as Num_Cars          /* Count rows per Type */
    from sashelp.cars
    group by Type                    /* Group by vehicle Type */
    order by Type;                   /* Alphabetical order */
quit;

/* Add a title and order by descending frequency */
title "Number of Cars by Type (Ordered by Descending Frequency)";

proc freq data=sashelp.cars order=freq;  /* Order by highest frequency */
    tables Type / nocum nopercent;
run;

title;  /* Clear title */

/* Same report using PROC SQL with descending order */
title "Number of Cars by Type (Ordered by Descending Frequency)";

proc sql;
    select 
        Type,
        count(*) as Num_Cars
    from sashelp.cars
    group by Type
    order by Num_Cars desc;   /* Sort by descending count */
quit;

title;

/* User-specified Make filter */
%let make_filter = Toyota;   /* Define macro variable */

title "Number of Cars by Type for &make_filter (Ordered by Descending Frequency)";

proc freq data=sashelp.cars(where=(Make="&make_filter")) order=freq;
    tables Type / nocum nopercent;   /* Filter by Make */
run;

title;

/* Case-insensitive filtering */
%let make_filter = toyota;

title "Number of Cars by Type for &make_filter (Ordered by Descending Frequency)";

proc freq data=sashelp.cars(
           where=(upcase(Make)=upcase("&make_filter"))  /* Case-insensitive comparison */
         ) order=freq;
    tables Type / nocum nopercent;
run;

title;

/* Capitalize make in title while keeping filter case-insensitive */
%let make_filter = toyota;                         /* User input (any case) */
%let make_display = %sysfunc(propcase(&make_filter));  /* Proper-case for display */

title "Number of Cars by Type for &make_display (Ordered by Descending Frequency)";

proc freq data=sashelp.cars(
           where=(upcase(Make)=upcase("&make_filter"))  /* Case-insensitive filter */
         ) order=freq;
    tables Type / nocum nopercent;
run;

title;  /* Clear title */

/* 
This program explores and analyzes the SASHELP.CARS dataset using Base SAS procedures and PROC SQL.

First, it inspects the dataset structure with PROC CONTENTS and prints the first 20 observations using PROC PRINT.

Next, it demonstrates data transformation by creating a new dataset (CARS_MODIFIED) that:

Calculates average miles per gallon (MPG_Avg)

Derives a new Doors variable by searching the Model text

Keeps only selected variables for analysis

The program then generates summary reports counting vehicles by Type using both PROC FREQ and PROC SQL, including versions ordered by descending frequency.

Finally, it enhances reporting flexibility by introducing a macro variable (MAKE_FILTER) that allows users to filter results for a specific car manufacturer. A case-insensitive filtering approach is implemented, and %SYSFUNC(PROPERCASE) is used to ensure professional formatting of the title output.

Overall, the program demonstrates:

Metadata inspection

Data transformation (DATA step and PROC SQL)

Frequency reporting

Sorting and ordering

Macro variable parameterization

Case-insensitive filtering techniques
*/