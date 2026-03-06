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

/* Prompt 3:
Generate a PROC PRINT step that will print the first 20 rows of SASHELP.CARS.
*/

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

/* Prompt 5:
Could you generate a similar result using PROC SQL?
*/

/* Prompt 6:
Generate a report that counts the number of cars for each value of Type.
*/

/* Prompt 7:
How can I order the report by descending frequency? I would also like to add a title.
*/

/* Prompt 8:
Enhance the PROC FREQ step to create a macro variable that allows a user to filter the report for a specific make of car.
*/

/* Prompt 9:
Here is my final program. 
Insert brief comments inline to explain each statement. 
Additionally, write a simple summary of the entire program that I can use for documentation.
*Copy and paste full program*
*/

