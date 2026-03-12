# run 

# Syntax: model <- glm(dependent_variable ~ independent_variable, data = dataset, family = "binomial")

study <- data.frame(studyHours = c(1,2,3,4,5,6), Result = c(0,0,0,1,1,1))

model <- glm(Result ~ studyHours,data = study, family = "binomial")

summary(model)

predict(model, type = "response")

plot(study$studyHours, study$Result)
curve(predict(model, data.frame(studyHours=x),type = "response"), add = TRUE)