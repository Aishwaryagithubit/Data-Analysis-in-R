?mean

x <- 4
y <- 6

x+y
#function
sum(x,y)

#c() combines values into a vector
ages <- c(5, 4)
ages
sum(ages)

names <- c("Radhika","Mohan")

#create dataframe and View is case sensitive
friends <- data.frame(names, ages)
View(friends)
str(friends)

#access age
friends$ages
sum(friends$ages)
mean(friends$ages)

#subsets
friends[1,1]
friends[1,]   #all columns
friends[,1]   #all rows 

#all datasets in R
data()
install.packages("dplyr") #install package
library(dplyr) #load package
View(starwars)  #View dataset

starwars %>% 
  filter(height > 150 & mass < 200) %>% 
  mutate(height_in_meters = height/100) %>% 
  select(height_in_meters, mass) %>% 
  arrange(mass) %>% 
  { plot(.$height_in_meters, .$mass) }
  #View()

