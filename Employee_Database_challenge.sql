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