/********************************************************/
/* SAS Programming with an AI Assistant                 */
/* SAS Innovate 2026                                    */
/* Demo 1: Building, Refining, and Documenting SAS Code */
/********************************************************/

/* Prompt 1:
I am coding in SAS using SAS Viya version 2025.12.
Please treat SAS as the default programming language for this conversation.
When I ask for code:
 - Use Base SAS (DATA step, PROC SQL, PROCs)
 - Include brief explanations of what the code is doing
 - Minimize steps and use the most efficient methods when possible
 - Follow best practices for readability and teaching 
*/

/* Prompt 2:
Provide a description of the CARS table in the SASHELP library. 
What are the columns and basic attributes?
*/

proc contents data=sashelp.cars short varnum;
run;

/* Prompt 3:
Generate a PROC PRINT step that will print the first 20 rows of SASHELP.CARS.
*/

proc print data=sashelp.cars(obs=20);
run;

/* Prompt 4:
Write a DATA step that computes the following new columns: 
 - MPG_Avg: average of MPG_City and MPG_Highway
 - Doors: Search the Model column for the string '2dr'. 
          If it is found, then assign the number 2 to Doors. 
          Also search Model for the string 4dr. 
          If it is found, then assign the number 4 to doors. 
          Otherwise assign a missing value. 
Keep the following columns: Make, Model, Type, Origin, MPG_Avg, Doors
*/

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

/* Prompt 5:
Could you generate a similar result using PROC SQL?
*/

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

/* Prompt 6:
Generate a report that counts the number of cars for each value of Type.
*/

proc freq data=sashelp.cars;
    tables Type / nocum nopercent;
run;

/* Prompt 7:
How can I order the report by descending frequency? I would also like to add a title.
*/

title "Number of Cars by Type (Ordered by Descending Frequency)";

/* Frequency report ordered by highest count first */
proc freq data=sashelp.cars order=freq;
    tables Type / nocum nopercent;
run;

/* Clear title (good practice) */
title;

/* Prompt 8:
Enhance the PROC FREQ step to create a macro variable that allows a user to filter the report for a specific make of car.
*/

%let make_filter = Toyota;

/* Add dynamic title */
title "Number of Cars by Type for &make_filter (Ordered by Descending Frequency)";

/* Frequency report filtered by Make */
proc freq data=sashelp.cars(where=(Make="&make_filter")) order=freq;
    tables Type / nocum nopercent;
run;

/* Clear title */
title;

/* Prompt 9:
Here is my final program. 
Insert brief comments inline to explain each statement. 
Additionally, write a simple summary of the entire program that I can use for documentation.
*Copy and paste full program*
*/
/* Answers will vary */
