# MySQL
Relational Database Testing
[Relational_1v2.pdf](https://github.com/wkodnik/MySQL/files/6244086/Relational_1v2.pdf)


Test1

--   Display the employee number, full employee name, job and hire date of all employees hired 
--   in May or November of any year, with the most recently hired employees displayed first.
--   Also, exclude people hired in 1994 and 1995.  
--   Full name should be in the form Lastname,  Firstname  with an alias called Full Name.
--   Hire date should point to the last day in May or November of that year (NOT to the exact day) 
--     and be in the form of [May 31<st,nd,rd,th> of 1996] with the heading Start Date. Do NOT use
--     LIKE operator. 
--   <st,nd,rd,th> means days that end in a 1, should have “st”, days that end in a 2 should have
--     “nd”, days that end in a 3 should have “rd” and all others should have “th”
--   You should display ONE row per output line by limiting the width of the Full Name to 25 
--     characters. The output lines should look like this line:

Test2

--   List the employee number, full name, job and the modified salary for all employees
--   whose monthly earning (without this increase) is outside the range $6,000 – $11,000
--   and who are employed as Vice Presidents or Managers (President is not counted here).  
--   You should use Wild Card characters for this. 
--   VP’s will get 30% and managers 20% salary increase.  
--   Sort the output by the top salaries (before this increase) firstly.
--   Heading will be like Employees with increased Pay
 


Test 4

--   Display the employee last name, salary, job title and manager# of all employees 
--   not earning a commission OR if they work in the SALES department, but only  if 
--   their total monthly salary with $1000 included bonus and  commission (if  earned)
--   is  greater  than  $15,000.  
--   Let’s assume that all employees receive this bonus.
--   If an employee does not have a manager, then display the word NONE 
--   instead. This column should have an alias Manager#.
--   Display the Total annual salary as well in the form of $135,600.00 with the 
--   heading Total Income. Sort the result so that best paid employees are shown first.

Test 5
--   Display last_name, salary and job for all employees who earn more than all lowest paid
--   employees per department outside the US locations.
--   Exclude President and Vice Presidents from this query.
--   Sort the output by job title ascending.


Test 6

--   Who are the employees (show last_name, salary and job) who work either in IT or MARKETING
--   department and earn more than the worst paid person in the ACCOUNTING department. 
--   Sort the output by the last name alphabetically.


Test 7

--   Display alphabetically the full name, job, salary (formatted as a currency amount incl.
--   thousand separator, but no decimals) and department number for each employee who earns
--   less than the best paid unionized employee (i.e. not the president nor any manager nor
--   any VP), and who work in either SALES or MARKETING department.  
--   -Full name should be displayed as Firstname  Lastname and should have the heading Employee.
--   Salary should be left-padded with the = symbol till the width of 12 characters. It should
--   have an alias Salary.
--   -You should display ONE row per output line by limiting the width of the 	Employee to 25
--   characters.
