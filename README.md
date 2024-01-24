# Machine-Learning---Diabetes-Risk-Classification

I was handed data on 768 patients and was tasked with developing a logistic regression model which can be used to evaluate whether a person is diabetic.

My main tools during this project were RStudio and Microsoft Excel.
1. I first randomized the data and divided them into training and testing using a ratio of 2:1
2. I trained in a logistic regression model using glm command.
3. The first model didn’t yield satisfactory results, so I ran step wise regression to derive only significant variables. The variables went from 8 to 5.
4. I then used the predict command on both training and testing data and migrated the output to Microsoft Excel for further analysis.
5. I calculated precision, recall, and F-1 Score against each threshold and chose the threshold which maximized the F-1 score.

Please find the attached Excel file to see the analysis and R file to see the code.
