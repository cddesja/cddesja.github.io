# Load and install packages into R
install.packages("psych")
library("psych")

# These are comments
# They are not run by R
# You can hit command+Enter or ctrl+Enter and R won't interpret
# them.

# Examine the LSAT data
data(bock)

# Let's get some summary information
head(lsat6)
summary(lsat6)

# Item difficulty
apply(lsat6, 2, mean)

# Calculate test score
test_score <- rowSums(lsat6)

# Calculate point-biserial correlations
cor(lsat6,test_score)

# Coefficient alpha
alpha(lsat6)

# Let's do a factor analysis
factanal(lsat6, factors = 1)
