par(ask = TRUE)
for(i in 1:5)
  plot(rnorm(10), main=paste("Plot",i))
}

par(mfrow = c(2,2))
for(i in 1:5)
  plot(rnorm(10), main=paste("Plot",i))
}


par(mfrow = c(2,2))  #arrange 4 plots in 2*2 grid



model <- glm(am ~ wt, data = mtcars, family = binomial)

par(mfrow = c(2,2))

#raw data
plot(mtcars$wt, mtcars$am, family = binomial)
par(mfrow = c(2,2))

