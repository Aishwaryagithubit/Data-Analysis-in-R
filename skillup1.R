#calculate mean and median age of Titanic Passengers

install.packages("rio")
library(rio)
DataTitanic = import("https://ai.lange-analytics.com/data/Titanic.csv")
VecAge = DataTitanic$Age

# Note that x and data are common names for the data argument in R commands. x=VecAge assigns the data from the R vector object VecAge
#explicitly to the x argument.
cat("Mean: ", mean(x = VecAge))
cat("Median: ", median(VecAge))

#first six observations of data
library (tidyverse)
DataTitanic = import("https://ai.lange-analytics.com/data/Titanic.csv")
DataTitanicNarrow = select(DataTitanic, Survived, PasClass=Pclass, Sex, Age, FareInPounds)
head(DataTitanicNarrow)

#Analyse only female
DataTitanicWomen = filter(DataTitanicNarrow, Sex == "female")
head(DataTitanicWomen)


#Analyse low fare passenger below 7
DataTitaniclow = filter(DataTitanicNarrow, FareInPounds<7)
head(DataTitaniclow)

#avoid 0 becoz its missing values
DataTitaniclow = filter(DataTitanicNarrow, FareInPounds<7 & FareInPounds>0)
print(DataTitaniclow)

#To analyze only passengers with an age of 60 or greater
DataTitanicSenior = filter(DataTitanicNarrow, Age>=60)
head(DataTitanicSenior)

#mutate() allows updating and overwriting a variable with a new formula.
DataTitanicNewFare = mutate(DataTitanicNarrow, FareIn2023Dollars = 108.5*FareInPounds,
                          FareInPounds=NULL)
head(DataTitanicNewFare)

#piping operator |>
#create a new data frame named DataFinalResult that contains: only the variables 𝑆𝑢𝑟𝑣𝑖𝑣𝑒𝑑, 𝑆𝑒𝑥, 𝐴𝑔𝑒, and 𝐹𝑎𝑟𝑒𝐼𝑛𝑃 𝑜𝑢𝑛𝑑𝑠
# only female passengers, and the fare passengers paid should be expressed in 2023 dollars in a new variable
DataFinalResult = DataTitanic |> 
  select(Survived,Sex,Age,FareInPounds) |>
  filter(Sex == "female") |>
  mutate(FareIn2023Dollars=108.5*FareInPounds, FareInPounds=NULL)
head(DataFinalResult)

# first six observations from the DataTitantic data frame
head(DataTitanic)

#Data Analysis where transform the variable Survived to a logic variable with TRUE AND FALSE
DataAnalytics = DataTitanic |> select(Survived,Sex,Pclass)|>
                  mutate(Survived = as.logical(Survived))
head(DataAnalytics)

#divide 
DataMen <- DataAnalytics |>
            filter(Sex == "male")
DataWomen <-  DataAnalytics |>
             filter(Sex == "female")
head(DataMen)
head(DataWomen)

# Calculate number of female survivors
FemSurv = sum(DataWomen$Survived)

# Calculate total number of females
FemTotal = nrow(DataWomen)

#Calculate female survival rate
FemSurvRate = FemSurv/FemTotal
cat("The survival rate of women: ", FemSurvRate)

# Male survival rate (short method)
MaleSurvRate = mean(DataMen$Survived)

cat("The survival rate for men is:", MaleSurvRate)

#rate both
cat("The survival rate for women is:", FemSurvRate, "\n",
    "The survival rate for men is:", MaleSurvRate )

MaleSurv = sum(DataMen$Survived)
MaleTotal = nrow(DataMen)

ModelPropFemaleVsMale=prop.test(c(FemSurv, MaleSurv),
                                c(FemTotal, MaleTotal))

print(ModelPropFemaleVsMale)

#Divide data by Passenger class
DataClass1 = DataAnalytics|>
             filter(Pclass == 1)
DataClass2= DataAnalytics|>
           filter(Pclass == 2)
DataClass3= DataAnalytics|>
  filter(Pclass == 3)

# Calculate survival rates for each class
Class1SurvRate= mean(DataClass1$Survived)
Class2SurvRate= mean(DataClass2$Survived)
Class3SurvRate= mean(DataClass3$Survived)

cat("Survival rate in class 1:", Class1SurvRate)
cat("Survival rate in class 2:", Class2SurvRate)
cat("Survival rate in class 3:", Class3SurvRate)

