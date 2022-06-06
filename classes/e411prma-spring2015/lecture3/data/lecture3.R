#
# Spearman-Brown
#

# Read in data
data <- read.csv("http://cddesja.github.io/classes/e411prma2015-1/lecture3/data/dummy_data.csv")

# Select even items
even <- data[, seq(2, 20, by = 2)]

# Select odd items
odd <- data[, seq(1, 20, by = 2)]

# Calculate scores on these tests
even_scores <- rowSums(even)
odd_scores <- rowSums(odd)

# Find the correlation
r <- cor(even_scores,odd_scores)

# Ratio of "revised" test to the "origin al" test 
N <- 2

# Spearman-Brown
r_sb <- N*r/(1 + (N -1)*r)
r_sb

#
# KR - 20
#

# Read in the data
lsat <- read.csv("http://cddesja.github.io/classes/e411prma2015-1/lecture3/data/lsat.csv")
lsat$total_score <- rowSums(lsat)

# Proportion of students who got the items correct
p <- apply(lsat[,-6], 2, mean)

# Proportion that got the items incorrect
q <- 1 - p

# There product
pq <- p*q

# Taking the sum
sum_pq <- sum(pq)

# Variance of the total test scores
sigma2 <- var(lsat$total_score)

# Number of items
k <- 5

# Putting it all together, equation on p 155
kr <- (k/(k - 1))*(1 - sum_pq/sigma2)

# Printing it
kr

#
# Coefficient/Cronbach's alpha
#

# Read in data 
lsat <- read.csv("http://cddesja.github.io/classes/e411prma2015-1/lecture3/data/lsat.csv")

# Calculate item variances
sigma_i <- apply(lsat, 2, var)

# Sum of item variances
sum_item <- sum(sigma_i)

# Coefficient alpha
a <- k / (k - 1) * (1 - sum_item / sigma2)
a

# Or the easy way 
install.packages("cocron")
library("cocron")
alpha <- cronbach.alpha(lsat)
alpha
cronbach.alpha.CI(alpha, n = nrow(lsat), items = 5)  ## Always a good idea!!! 
