# Run this command only once!
install.packages("irtoys")

# Load the IRToys package
library("irtoys")

# -- Estimate an item response model -- #
rasch <- est(Scored, model="1PL", engine="ltm", rasch = TRUE)  # Rasch model

head(rasch$est)  # Item difficulties
head(rasch$se)  # Standard Errors

# 1, 2, and 3-PL models
p.1pl <- est(Scored, model="1PL", engine="ltm")  # 1PL
p.2pl <- est(Scored, model="2PL", engine="ltm")  # 2PL
p.3pl <- est(Scored, model="3PL", engine="ltm")  # 3PL


# -- Item Response Function -- #
# All of them 
plot(irf(rasch$est), co = NA)

# Items 2, 5, and 7
plot(irf(rasch$est[c(2, 5, 7),]), co = NA)

# -- Item Information Function -- #

# All of them
plot(iif(rasch$est), co = NA)

# Items 2, 5, and 7
plot(iif(rasch$est[c(2, 5, 7),]), co = NA)

# Compare it to a 2-PL
plot(iif(p.2pl$est[c(2, 5, 7),]), co = NA)

# Test Information Function
plot(tif(rasch$est))

# Extract scores
person_scores <- mlebme(resp = Scored, ip = rasch$est)
head(person_scores)
