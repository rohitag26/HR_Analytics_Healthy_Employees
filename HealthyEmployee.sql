SELECT *
FROM dbo.Employees_HealthData EH
LEFT JOIN dbo.compensation C
ON EH.ID = C.ID
LEFT JOIN dbo.Reasons R
ON EH.Reason_for_absence=R.Number

-- Find the Healthiest 
SELECT *
FROM dbo.Employees_HealthData
Where Social_drinker= 0 And Social_smoker= 0 And Body_mass_index <25
And Absenteeism_time_in_hours < (Select Avg(Absenteeism_time_in_hours) From dbo.Employees_HealthData)

--compensation rate increase for non-smokers/budget $983221, 0.68 increase per hour/$1414.4 per year
SELECT count(*) as nonsmokers
FROM dbo.Employees_HealthData
Where Social_smoker=0

--optimize this query
SELECT EH.ID, R.reason, Month_of_absence, Body_mass_index,
CASE when Body_mass_index <18.5 Then 'Underweight'
     when Body_mass_index between 18.5 and 25 Then 'Healthy'
	 when Body_mass_index between 25 and 30 Then 'Overweight'
	 when Body_mass_index > 18.5 Then 'Obese'
	 Else 'Unknown' End as BMI_Category,
CASE when Month_of_absence IN (12, 1, 2) Then 'Winter'
      when Month_of_absence IN (3, 4, 5) Then 'Spring'
	   when Month_of_absence IN (6, 7, 8) Then 'Summer'
	    when Month_of_absence IN (9, 10, 11) Then 'Fall'
		Else 'Unknown' End as Seasons_Name,
Month_of_absence, Day_of_the_week, Transportation_expense, Education, Son, Social_drinker, Social_smoker, Pet, Disciplinary_failure, Age, Work_load_Average_day, Absenteeism_time_in_hours
FROM dbo.Employees_HealthData EH
LEFT JOIN dbo.compensation C
ON EH.ID = C.ID
LEFT JOIN dbo.Reasons R
ON EH.Reason_for_absence=R.Number
