-- 1. List: employee number, last name, first name, gender, and salary
-- e.emp_no,e.last_name,e.first_name,e.gender,s.salary
-- s.emp_no >- e.emp_no

SELECT e.emp_no,e.last_name,e.first_name,e.gender,s.salary
FROM employees AS e JOIN salaries AS s ON s.emp_no = e.emp_no;

-- 2. List employees who were hired in 1986

SELECT first_name || ' ' || last_name AS "Employee", hire_date
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31';

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number
-- last name, first name, and start and end employment dates.
-- dm.dept_no >- d.dept_no , dm.emp_no >- e.emp_no

	-- 	SELECT dept_no,from_date
	-- 	FROM (
	-- 		SELECT dept_no ,MAX(from_date) AS "from_date" FROM dept_manager GROUP BY dept_no
	-- 	) as temp1;

	-- SELECT dm.dept_no,dm.emp_no,dm.from_date,dm.to_date
	-- FROM dept_manager dm
	-- JOIN (
	-- 	SELECT dept_no,from_date
	-- 	FROM (
	-- 		SELECT dept_no ,MAX(from_date) AS "from_date" FROM dept_manager GROUP BY dept_no
	-- 	) as temp1
	-- ) as temp2 ON dm.from_date = temp2.from_date;

-- The following code will list only the current manager for each department
SELECT d.dept_no,d.dept_name,dmselected.emp_no,e.last_name,e.first_name,dmselected.from_date,dmselected.to_date
FROM departments AS d 
JOIN 
(
	SELECT dm.dept_no,dm.emp_no,dm.from_date,dm.to_date
	FROM dept_manager dm
	JOIN (
		SELECT dept_no,from_date
		FROM (
			SELECT dept_no ,MAX(from_date) AS "from_date" FROM dept_manager GROUP BY dept_no
		) as temp1
	) as temp2 ON dm.from_date = temp2.from_date
) as dmselected ON (dmselected.dept_no = d.dept_no)
JOIN employees AS e ON (dmselected.emp_no = e.emp_no);

-- The following code list all the managers including previous managers for each department
SELECT d.dept_no,d.dept_name,dm.emp_no,e.last_name,e.first_name,dm.from_date,dm.to_date
FROM departments AS d 
JOIN dept_manager AS dm ON (dm.dept_no = d.dept_no) 
JOIN employees AS e ON (dm.emp_no = e.emp_no);


-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
-- de.emp_no >- e.emp , de.dept_no >- d.dept_no

-- The following code is initial try with multiple entries for each emp_no
-- SELECT e.emp_no,e.last_name,e.first_name,d.dept_name
-- FROM employees AS e 
-- JOIN dept_emp AS de ON (de.emp_no = e.emp_no) 
-- JOIN departments AS d ON (de.dept_no=d.dept_no);

-- 		SELECT emp_no,dept_no,from_date
-- 		FROM (
-- 			SELECT emp_no,dept_no,MAX(from_date) AS "from_date" FROM dept_emp GROUP BY (emp_no,dept_no)
-- 		) as temp1;

-- 	SELECT de.emp_no,de.dept_no
-- 	FROM dept_emp de
-- 	JOIN (
-- 		SELECT emp_no,dept_no,from_date
-- 		FROM (
-- 			SELECT emp_no,dept_no,MAX(from_date) AS "from_date" FROM dept_emp GROUP BY (emp_no,dept_no)
-- 		) as temp1
-- 	) as temp2 ON de.from_date = temp2.from_date;

SELECT e.emp_no,e.last_name,e.first_name,d.dept_name
FROM employees AS e 
JOIN(
	SELECT de.emp_no,de.dept_no
	FROM dept_emp de
	JOIN (
		SELECT emp_no,dept_no,from_date
		FROM (
			SELECT emp_no,dept_no,MAX(from_date) AS "from_date" FROM dept_emp GROUP BY (emp_no,dept_no)
		) as temp1
	) as temp2 ON de.from_date = temp2.from_date
) AS deselected ON (deselected.emp_no = e.emp_no)
JOIN departments AS d ON (deselected.dept_no=d.dept_no);

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name || ' ' || last_name AS "Employee"
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name.
-- de.emp_no >- e.emp_no , de.dept_no >- d.dept_no

-- The following code is initial try with multiple entries for each emp_no
-- SELECT e.emp_no,e.last_name,e.first_name,d.dept_name
-- FROM employees AS e 
-- JOIN dept_emp AS de ON (de.emp_no = e.emp_no) 
-- JOIN departments AS d ON (de.dept_no=d.dept_no)
-- WHERE d.dept_name = 'Sales';

-- 		SELECT emp_no,from_date
-- 		FROM (
-- 			SELECT emp_no,MAX(from_date) AS "from_date" FROM dept_emp GROUP BY emp_no
-- 		) as temp1;

-- 	SELECT de.emp_no,de.dept_no
-- 	FROM dept_emp de
-- 	JOIN (
-- 		SELECT emp_no,from_date
-- 		FROM (
-- 			SELECT emp_no,MAX(from_date) AS "from_date" FROM dept_emp GROUP BY emp_no
-- 		) as temp1
-- 	) as temp2 ON de.from_date = temp2.from_date;

SELECT e.emp_no,e.last_name,e.first_name,d.dept_name
FROM employees AS e 
JOIN(
	SELECT de.emp_no,de.dept_no
	FROM dept_emp de
	JOIN (
		SELECT emp_no,from_date
		FROM (
			SELECT emp_no,MAX(from_date) AS "from_date" FROM dept_emp GROUP BY emp_no
		) as temp1
	) as temp2 ON de.from_date = temp2.from_date
) AS deselected ON (deselected.emp_no = e.emp_no) 
JOIN departments AS d ON (deselected.dept_no=d.dept_no)
WHERE d.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.
-- de.emp_no >- e.emp_no , de.dept_no >- d.dept_no

SELECT e.emp_no,e.last_name,e.first_name,d.dept_name
FROM employees AS e 
JOIN(
	SELECT de.emp_no,de.dept_no
	FROM dept_emp de
	JOIN (
		SELECT emp_no,from_date
		FROM (
			SELECT emp_no,MAX(from_date) AS "from_date" FROM dept_emp GROUP BY emp_no
		) as temp1
	) as temp2 ON de.from_date = temp2.from_date
) AS deselected ON (deselected.emp_no = e.emp_no) 
JOIN departments AS d ON (deselected.dept_no=d.dept_no)
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- 8 In descending order, list the frequency count of employee last names
-- i.e., how many employees share each last name.

SELECT last_name,COUNT(emp_no) AS "Number of employees" FROM employees
GROUP BY last_name
ORDER BY "Number of employees" DESC;
