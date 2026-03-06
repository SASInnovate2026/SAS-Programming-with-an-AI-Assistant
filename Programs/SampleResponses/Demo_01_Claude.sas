PROC CONTENTS DATA=sashelp.cars;
RUN;

PROC PRINT DATA=sashelp.cars(OBS=20) NOOBS;
RUN;

DATA cars_new;
    SET sashelp.cars;

    /* Average of city and highway MPG */
    MPG_Avg = MEAN(MPG_City, MPG_Highway);

    /* Search Model for door count string; assign numeric value or missing */
    IF      INDEX(LOWCASE(Model), '2dr') > 0 THEN Doors = 2;
    ELSE IF INDEX(LOWCASE(Model), '4dr') > 0 THEN Doors = 4;
    ELSE Doors = .;

    KEEP Make Model Type Origin MPG_Avg Doors;
RUN;

PROC SQL;
    CREATE TABLE cars_new_sql AS
    SELECT
        Make,
        Model,
        Type,
        Origin,
        MEAN(MPG_City, MPG_Highway)            AS MPG_Avg,
        CASE
            WHEN INDEX(LOWCASE(Model), '2dr') > 0 THEN 2
            WHEN INDEX(LOWCASE(Model), '4dr') > 0 THEN 4
            ELSE .
        END                                    AS Doors
    FROM sashelp.cars;
QUIT;

PROC FREQ DATA=sashelp.cars;
    TABLES Type / NOCUM;
RUN;

/* PROC SQL approach */
PROC SQL;
    SELECT Type, COUNT(*) AS Count
    FROM sashelp.cars
    GROUP BY Type
    ORDER BY Type;
QUIT;

TITLE 'Car Count by Type';

PROC FREQ DATA=sashelp.cars ORDER=FREQ;
    TABLES Type / NOCUM;
RUN;

TITLE;

%LET make_filter = Honda;

TITLE "Car Count by Type for &make_filter.";

PROC FREQ DATA=sashelp.cars(WHERE=(Make = "&make_filter.")) ORDER=FREQ;
    TABLES Type / NOCUM;
RUN;

TITLE;

/*=========================================================
  PROGRAM:    SASHELP.CARS Analysis
  PURPOSE:    Explore and summarize the SASHELP.CARS dataset
              including data profiling, variable derivation,
              and frequency reporting by car type and make.
  INPUT:      SASHELP.CARS (428 obs, 15 variables)
  OUTPUT:     WORK.CARS_NEW, WORK.CARS_NEW_SQL, Freq Reports
=========================================================*/


/* Display metadata: variable names, types, lengths, and labels */
PROC CONTENTS DATA=sashelp.cars;
RUN;

/* Preview the first 20 rows; NOOBS suppresses the row counter column */
PROC PRINT DATA=sashelp.cars(OBS=20) NOOBS;
RUN;


/*---------------------------------------------------------
  DATA STEP: Derive new columns and subset variables
---------------------------------------------------------*/
DATA cars_new;
    SET sashelp.cars;

    /* Compute average MPG across city and highway driving */
    MPG_Avg = MEAN(MPG_City, MPG_Highway);

    /* Assign door count by searching Model for '2dr' or '4dr';
       LOWCASE ensures case-insensitive matching; missing (.) if neither found */
    IF      INDEX(LOWCASE(Model), '2dr') > 0 THEN Doors = 2;
    ELSE IF INDEX(LOWCASE(Model), '4dr') > 0 THEN Doors = 4;
    ELSE Doors = .;

    /* Retain only the columns needed for downstream analysis */
    KEEP Make Model Type Origin MPG_Avg Doors;
RUN;


/*---------------------------------------------------------
  PROC SQL: Reproduce CARS_NEW using SQL syntax
---------------------------------------------------------*/
PROC SQL;
    CREATE TABLE cars_new_sql AS
    SELECT
        Make,
        Model,
        Type,
        Origin,
        MEAN(MPG_City, MPG_Highway)   AS MPG_Avg,  /* Average MPG */
        CASE                                        /* Door count via string search */
            WHEN INDEX(LOWCASE(Model), '2dr') > 0 THEN 2
            WHEN INDEX(LOWCASE(Model), '4dr') > 0 THEN 4
            ELSE .
        END                           AS Doors
    FROM sashelp.cars;
QUIT;


/*---------------------------------------------------------
  FREQUENCY REPORTS: Summarize car counts by Type
---------------------------------------------------------*/

/* Basic frequency count by Type; NOCUM suppresses cumulative columns */
PROC FREQ DATA=sashelp.cars;
    TABLES Type / NOCUM;
RUN;

/* PROC SQL alternative: count by Type, sorted alphabetically */
PROC SQL;
    SELECT Type, COUNT(*) AS Count
    FROM sashelp.cars
    GROUP BY Type
    ORDER BY Type;
QUIT;

/* Frequency report sorted by descending count with a title */
TITLE 'Car Count by Type';
PROC FREQ DATA=sashelp.cars ORDER=FREQ;
    TABLES Type / NOCUM;
RUN;
TITLE; /* Clear title so it does not persist to subsequent output */


/*---------------------------------------------------------
  FILTERED REPORT: Frequency by Type for a specific Make
---------------------------------------------------------*/

/* Set make_filter to any valid Make value to subset the report */
%LET make_filter = Honda;

TITLE "Car Count by Type for &make_filter.";

/* WHERE dataset option filters rows before processing */
PROC FREQ DATA=sashelp.cars(WHERE=(Make = "&make_filter.")) ORDER=FREQ;
    TABLES Type / NOCUM;
RUN;
TITLE; /* Clear title */

/* 
This program explores and summarizes the SASHELP.CARS dataset, 
which contains 428 observations and 15 variables covering automobile 
make, model, pricing, performance, and physical dimensions.
The program begins with a metadata review using PROC CONTENTS and a 
data preview using PROC PRINT. 
Two new variables are then derived 
— MPG_Avg (average of city and highway fuel efficiency) and 
Doors (inferred from the model name string) 
— implemented in parallel using both a DATA step and an equivalent PROC SQL query, 
each producing an output table restricted to six key columns.
The remainder of the program produces frequency reports summarizing car counts 
by vehicle type. Reports are generated using both PROC FREQ and PROC SQL, 
with a final parameterized report that filters results to a specific make of car 
controlled by the %LET make_filter macro variable.
*/