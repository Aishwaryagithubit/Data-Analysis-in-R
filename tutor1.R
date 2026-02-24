100.1 + 234.9 + 12.01

sqrt(256)

log10(100)*cos(pi)

5>10

#Numerical variable
x<-1
x
#categorical variable
y<-"Hello"
y
#logical variable
z<-TRUE
z
#missing variable
notAvai<-NA
notAvai
print(paste("x", mode(x), length(x), sep=" "))
print(paste("y", mode(y), length(y), sep=" "))
print(paste("z", mode(z), length(z), sep=" "))
print(paste("notAvai", mode(notAvai), length(notAvai), sep=" "))

a<-rep(2,10)
a
#Generate a vector which contains a sequence of numbers between 1 and 10
b<-1:10
b
#To concatenate vectors a and b use c() function
c(a,b)
z<-c(a,b)
z
#Generate a vector of following numbers 2,4,5,8,10,37,49
x<-c(2,4,5,8,10,37,49)
x

#To define a vector of characters, type the following command:
 y<-c("John", "Ann", "Kate", "John", "Peter", "Dan")
y
#It is possible to define a vector by providing vector type and size and then initialize it:
y2<-character(3)
y2
y2[1]<-"black"
y2[2]<-"red"
y2[3]<-"blue"
y2
#To define a logical vector you provide TRUE and FALSE as a value of the vector elements:
  z <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE)
z

y<-c("John", "Ann", "Kate", "John", "Peter", "Dan")
z<-1:3
y[z]

x[x>10]

y[y=="John"]

gender<-c(rep("female", 10), rep("male", 20))
gender
class(gender)


gender<-factor(gender)
gender
class(gender)

levels(gender)
table(gender)

matrix(data=5,nr=2,nc=2)
matrix(1:6,2, 3)
M<-matrix(1:6,2, 3, byrow=TRUE)
M

#naming rows and columns
rownames(M)<-c("A","B")
colnames(M)<-c("D","E","F")
M

#print element from 2nd row and 3rd column
M[2,3]
#print column "F"
M[,3]
M[,"F"]
#print columns D and E
M[,1:2]
M[,c("D","E")]

age <- 5:15
age
weight<- c(5.5,7.2, 7.9,8.5,9.1, 9.7,10.2,10.7,11.2, 11.7, 12.2)
weight

child_weight <- data.frame(col_age=age, col_weight=weight)
child_weight

class(age)
class(weight)
class(child_weight)


names(child_weight)
child_weight[5,]

#access the column age
child_weight$col_age
#access the column weight
child_weight$col_weight
#access the first value from the age column
child_weight$col_age[1]

summary(child_weight)

m <- data.frame(gender = c("M", "M", "F"), ht = c(172, 186.5, 165), wt = c(91, 99, 74))
summary(m)
# other example
d <- c(1,2,3,4)
e <- c("red", "white", "red", NA)
f <- c(TRUE,TRUE,TRUE,FALSE)
mydata <- data.frame(d,e,f)
names(mydata) <- c("Ichild_weightD","Color","Passed")
summary(mydata)

# Create a list containing strings, numbers, vectors and a logical values.
list_data <- list("Red", "Green", c(21,32,11), TRUE, 51.23, 119.1)
list_data
# Create a list containing a vector, a matrix and a list.
list_data <- list(c("Jan","Feb","Mar"), matrix(c(3,9,5,1,-2,8), nrow = 2),
                  list("green",12.3))
# Give names to the elements in the list.
names(list_data) <- c("1st Quarter", "A_Matrix", "A Inner list")
# Show the list.
list_data

# Print the first element of the list.
print(list_data[1])
# Print the third element.
print(list_data[3])
# Access the list element using the name of the element.
print(list_data$A_Matrix)

w = 3
if( w < 5 )
{
  d=2
}else{
  d=10
}
9
d

w = 3
d<-ifelse( w < 5, 2, 10 )
d

h <- seq(from=1, to=8)
s <- c()
for(i in 2:10)
{
  s[i] = h[i] * 10
}
s





