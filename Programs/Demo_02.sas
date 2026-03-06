/******************************************************/
/* SAS Programming with an AI Assistant               */
/* SAS Innovate 2026                                  */
/* Demo 2: Graphing and Navigating LLM Hallucinations */
/******************************************************/

/* Prompt 1:
Create a vertical bar chart that displays the number of cars for each value of Type.
*/

/* Prompt 2: 
Can you order the bars by descending frequency?
*Desired response: categoryorder=respdesc on the VBAR statement
*/

/* Prompt 3:
Can you add data labels to each bar?
*/

/* Prompt 4:
How can I make each bar a different color?
*Desired response: group=Type on the VBAR statement and
                   STYLEATTRS datacolors=(hex-color-list) statement
*/

/* Prompt 5:
Can you make a color scheme for shades of dark to light pink?
*/

/* Prompt 6:
How can I remove the outline around each bar? 
Desired response: nooutline on the VBAR statement
*/

/* Prompt 7: 
Add a macro variable to the step to filter the bar chart for a specified value of Origin.
*/

/* Prompt 8:
Make the filter case insensitive.
*/

/* Prompt 9:
Define a macro and use macro conditional processing.
If the value of the macro variable is usa, then UPCASE the value in the title. 
Else, PROPCASE the value. 
If the value is not Asia, USA, or Europe, write a note to the log that the valid values are Asia, Europe, or USA in any case.
If no value is provided, create the bar chart for all origins and write a note to the log.
*/