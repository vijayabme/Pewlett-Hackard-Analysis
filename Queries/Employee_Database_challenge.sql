-- Create a retirement tiles table
DROP table retirement_titles
SELECT e.emp_no,
    e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
    ti.to_date
	INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

select * from retirement_titles
select * from employees
select * from titles



-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

Select * FROM  unique_titles

-- Get the count of employees by title about to retire
DROP TABLE retiring_titles
SELECT COUNT(ut.title) AS title_count, ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY title_count DESC
;
Select * FROM  retiring_titles

-- Mentorship eligibility
drop table mentorship_details
SELECT DISTINCT on (e.emp_no) e.emp_no,
       e.first_name,
       e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   ti.title

INTO mentorship_eligibility
FROM employees as e
     LEFT JOIN dept_emp as de 
	 ON e.emp_no = de.emp_no
	 INNER JOIN titles as ti
	 ON e.emp_no = ti.emp_no
	   WHERE (de.to_date = '9999-01-01') 
	   AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	   ORDER BY e.emp_no;
	   
SELECT * FROM mentorship_eligibility

-- Get the count of employees by title eligible for mentorship

SELECT COUNT(me.title) AS title_count, me.title
INTO mentorship_titles
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY title_count DESC
;

SELECT * FROM mentorship_titles