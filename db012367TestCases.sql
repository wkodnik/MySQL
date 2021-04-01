

--Test 1
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
SELECT TO_CHAR(employee_id) as "Employee Number",
       RPAD(last_name ||', '|| first_name, 25) as "Full Name",
       job_id as "Job Title",
       TO_CHAR(LAST_DAY(hire_date), '"["fmMonth ddth "of" YYYY"]"') as "Hire Date"
FROM employees
WHERE (INSTR(TO_CHAR(hire_date, 'fmMonth ddth "of" YYYY'), 'May') > 0
      OR
      INSTR(TO_CHAR(hire_date, 'fmMonth ddth "of" YYYY'), 'November') > 0)
      AND hire_date NOT BETWEEN TO_DATE('01-01-1994', 'DD-MM-YYYY') AND
                                TO_DATE('01-12-1995', 'DD-MM-YYYY')
ORDER BY hire_date DESC;
    
--Test 2
--   List the employee number, full name, job and the modified salary for all employees
--   whose monthly earning (without this increase) is outside the range $6,000 – $11,000
--   and who are employed as Vice Presidents or Managers (President is not counted here).  
--   You should use Wild Card characters for this. 
--   VP’s will get 30% and managers 20% salary increase.  
--   Sort the output by the top salaries (before this increase) firstly.
--   Heading will be like Employees with increased Pay
--     
SELECT 'Emp# '||emp.employee_id||' named '||emp.first_name||
       ' '||emp.last_name||' who is '||emp.job_id||
       ' will have a new salary of $'|| 
       (CASE
            WHEN emp.job_id LIKE '%VP' THEN emp.salary*1.3
            WHEN emp.job_id LIKE '%MAN' THEN emp.salary*1.2
            ELSE emp.salary 
        END)
       AS "Employees with increased Pay"
FROM employees emp
WHERE emp.employee_id IN 
                         (SELECT mng.manager_id
                          FROM employees mng)
AND emp.salary NOT BETWEEN 6000 AND 11000
ORDER BY emp.salary DESC;

--Test 3
--   Display the employee last name, salary, job title and manager# of all employees 
--   not earning a commission OR if they work in the SALES department, but only  if 
--   their total monthly salary with $1000 included bonus and  commission (if  earned)
--   is  greater  than  $15,000.  
--   Let’s assume that all employees receive this bonus.
--   If an employee does not have a manager, then display the word NONE 
--   instead. This column should have an alias Manager#.
--   Display the Total annual salary as well in the form of $135,600.00 with the 
--   heading Total Income. Sort the result so that best paid employees are shown first.
--
SELECT last_name AS "Last Name",
       TO_CHAR(salary, '$999,999.99') AS "Salary",
       job_id AS "Job#",
       NVL(TO_CHAR(manager_id), 'NONE') AS "Manager#",
       TO_CHAR((salary+1000)*12, '$999,999.99') AS "Total Income"
FROM employees
WHERE (COMMISSION_PCT IS NULL
      OR department_id = (SELECT department_id
                          FROM departments
                          WHERE UPPER(department_name) LIKE 'SALES'))
      AND (salary + 1000)*NVL(COMMISSION_PCT,1) > 15000
ORDER BY "Total Income" DESC;

--Test 4
--   Display Department_id, Job_id and the Lowest salary for this combination under
--   the alias Lowest Dept/Job Pay, but only if that Lowest Pay falls in the range 
--   $6000 - $18000. Exclude people who work as some kind of Representative job from
--   this query and departments IT and SALES as well.
--   Sort the output according to the Department_id and then by Job_id.
--   You MUST NOT use the Subquery method.
--
SELECT department_id,
       job_id,
       TO_CHAR(MIN(salary), '$999,999.99') AS "Lowest Dep/Job Pay"
FROM employees
JOIN departments
USING (department_id)
WHERE job_id NOT LIKE '%REP%' AND
      UPPER(department_name) NOT IN ('IT', 'SALES')
GROUP BY department_id, job_id
HAVING min(salary) BETWEEN 6000 AND 18000
ORDER BY department_id, job_id;

--Test 5
--   Display last_name, salary and job for all employees who earn more than all lowest paid
--   employees per department outside the US locations.
--   Exclude President and Vice Presidents from this query.
--   Sort the output by job title ascending.
--   You need to use a Subquery and Joining with the NEW (Oracle9i) method.
--
SELECT 
    last_name AS "Last Name", 
    TO_CHAR(salary, '$999,999.99') AS "Salary", 
    job_id AS "Job ID"
FROM employees
WHERE salary > ALL 
                   (SELECT MIN(salary)
                    FROM employees
                    JOIN departments
                         USING(department_id)
                    JOIN locations
                         USING(location_id)
                    WHERE UPPER(country_id) NOT IN ('US')
                    GROUP BY department_id)

AND NOT REGEXP_LIKE(job_id, '.*(VP|PRES)$')
ORDER BY job_id;

--Test 6
--   Who are the employees (show last_name, salary and job) who work either in IT or MARKETING
--   department and earn more than the worst paid person in the ACCOUNTING department. 
--   Sort the output by the last name alphabetically.
--   You need to use ONLY the Subquery method (NO joins allowed).
--
SELECT 
    last_name, 
    TO_CHAR(salary, '$999,999.99') AS "SALARY", 
    job_id
FROM employees
WHERE department_id IN (SELECT department_id 
                        FROM departments
                        WHERE UPPER(department_name) IN ('IT', 'MARKETING'))
      AND salary > 
                   (SELECT MIN(salary)
                    FROM employees
                    WHERE department_id =  (SELECT department_id
                                            FROM departments
                                            WHERE UPPER(department_name) LIKE ('ACCOUNTING')))
ORDER BY last_name;

    
--Test 7
--   Display alphabetically the full name, job, salary (formatted as a currency amount incl.
--   thousand separator, but no decimals) and department number for each employee who earns
--   less than the best paid unionized employee (i.e. not the president nor any manager nor
--   any VP), and who work in either SALES or MARKETING department.  
--   -Full name should be displayed as Firstname  Lastname and should have the heading Employee.
--   Salary should be left-padded with the = symbol till the width of 12 characters. It should
--   have an alias Salary.
--   -You should display ONE row per output line by limiting the width of the 	Employee to 25
--   characters.
SELECT
    RPAD(first_name || '  ' || last_name, 25) AS "Employee",
    job_id AS "Job",
    LPAD(TO_CHAR(ROUND(salary), '$999,999'), 12, '=') AS "Salary",
    department_id AS "Department ID"
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM departments 
                        WHERE UPPER(department_name) IN ('SALES', 'MARKETING'))
AND employee_id NOT IN (SELECT employee_id
                        FROM employees
                        WHERE employee_id IN (SELECT manager_id
                                              FROM employees));

