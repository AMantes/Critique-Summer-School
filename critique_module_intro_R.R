# Εισαγωγή στον προγραμματισμό με R για οικονομολόγους, Critique, Heteredox economics summer school July 2024


# libraries
library(Matrix)
library(scatterplot3d)
library(readr)
library(eurostat)
library(dplyr)
library(ggplot2)

################## Section 1: R scientific calculator ###########################


# Πράξεις και μαθηματικές συναρτήσεις
2 + 3
5 * 7
11 / 2.5

# εκθέτες
3^2
4^3
2^(-5)
2^(1/2)

# Πράξεις με μηδέν και άπειρο
1/0
Inf*Inf
Inf/Inf # Not a Number (NaN)
0/0
(-Inf)*Inf
(-Inf)*(-Inf)
1/Inf

# Απόλυτη τιμή

abs(-10)
abs(   -10*10  )


# Τετραγωνική ρίζα
sqrt(4)
sqrt(144)
sqrt(10)


# Πράξεις με συναρτήσεις

sqrt(4) / 2

2 * sqrt(9) / abs(-3)  # 2 * 3 / 3



# Λογάριθμοι και εκθέτες
log( 10 ) #ln

log10(10) # base 10 log

log10(100)

log(2,3) # log of 2 to base 3
log(2,2)

log1p(0.0001) # log(1 + 0.00001), accurate for abs(x) <<1

# εκθετική συνάρτηση
exp(0)           # μαθηματική σταθερά e = lim (n /(1 + n)) ^ n
exp(1)
exp(10)

?exp
?sqrt

# Τριγωνομετρικές συναρτήσεις

# cos = συν
cos(0)
cos(pi)
cos(pi/3)

# sin = ημ
sin(0)
sin(pi/2)
sin(pi/6)

# tan = εφ
tan(0)
tan(pi/4)

sin(pi)^2 + cos(pi)^2


# Μηγαδικοί αριθμοί

1i

1i^2
# addition / subtraction
(1+2i) + (3 + 4i)
(1-2i) - (3+4i)
# division
(1+2i)/(3 - 5i)

(1 + 2i)^2 + (2i)^2 - (4i)^2 + (-2-2i) / (4 -9i) + cos(1 + 2i)

# Real / imaginary parts
Re(3+2i)
Im(3+2i)



# Αρνητικες ριζες;

sqrt(-2)

sqrt(-2 +0i)



################## Section 2: ορίζοντας μεταβλητές #############################

a <- 10
a = 10


# Creating Variables

a <- 15

b <- 20

c <- a + b

d <- - (c^2) / 2

# Print the result
c
d
print(c)

# Relational operators: TRUE & FALSE

1 == 1
1 == 2


4 != 1

4<=4

a = 1
a <- 1
a <- TRUE
a == 20


# Προσοχή 

0.5 == 1/2

.5 == 1/2

3/1 == 3

.3/.1 == 3.

?all.equal
all.equal( .3/.1 , 3  )



########################### Summary ############################################

+ -  / * ^ abs() exp() sqrt() sin() cos() log() 1i a <- 0  a = 10  == != all.equal()


# Exercise 1: Basic Operations

# 1. Multiply 8 by 6 and store the result in a variable named result.

result <- 8*6

# 2. Find the square root of 49 and store it in a variable named sqrt_result.

srt_result <- sqrt(49)


# 3. Print both variables.

result







# Ασκηση 2: Πόσα δευτερόλεπτα έχει ένας αιώνας;

sec = 1
minute = 60*sec
hour = 60*minute
day = 24*hour
year = 365*day
century = 100*year

century / sec

century / hour









################## Section 3: Data structures ##################################

# Vectors - διανύσματα

# Γενική σύνταξη:

c( 1 , 2 , 3 ,4 , 7   )

x = c(2,4,6,8,10,12,14,16,18,20)

x


x[1]
x[2]
x[10]

x[ 1:3  ]
x[5:10]
foo <- x[5:11]     # NA = Not Available

x[ c( 1,5,10 ) ]


# add element
x[11] = 22
x
x[1] = 0
x

x[12] = NA
x


# remove element
x[-11] 

x = x[-1]
x = x[-11]

# operations
x * 10
x
x = x*10

x - 1
x^2
sqrt(x)
foo = cos(x)
log(x)

# Simple plots
plot( cos(x) )

plot( log(x) )


?plot
x
# statistics

length(x)
mean(x)
sd(x)
var(x)
min(x)
max(x)
range(x)
sum(x)
summary(x)

# vector multiplication

x1 = c(1,2,3,4,5)
y1 = c(1,1,1,1,2)

x1*y1

foo = 2

x2 = c(1,2,3,4,5)
y2 = c(1,2)

x2*y2


# Generating sequences

1 : 10

5.5 : 20.5

n = 10

1:n
1:n - 1
1:(n-1)
1:(10*n)

# Seq(from, to , by step)

seq( 0, 100 , 0.1 )

n = 100

seq(0,n,0.1)

# repeating

rep( 1 , 10 )

rep(0,10)

rep(NA,10)

#random sequences

# runif(n , min, max) : Uniform distribution https://en.wikipedia.org/wiki/Continuous_uniform_distribution

?runif

runif(100, 0, 1)

runif(10, -25, 25)

# rnorm( n , mean, sd ) # Normal distribution: https://en.wikipedia.org/wiki/Normal_distribution

?rnorm

rnorm(10)

rnorm(10, 10, 2)

rnorm(1000, -10, 1)

# random vector

x = 1 : 50

error = rnorm(50,0,1)

y = x + error # x + noise


######### Plotting vectors #####################################################

plot(x)

plot(error)

plot(y)


plot(x, type = "l")

plot(error, type = "l")

plot(y, type = "l")


acf(error)
#?acf


plot(y, type = "s")

plot(y, type = "o")

plot(y, type = "l", lty =1)

plot(y, type = "l", lty =2)

plot(y, type = "l", lty =3)

plot(y, type = "l", lty =4)

plot(y, type = "l", lty =5)

plot(y, type = "l", lty =6)

plot(y, type = "l", lty =6, lwd = 2)

plot(y, type = "l", lty =6, lwd = 2, col = "blue")

plot(y, type = "l", lty =6, lwd = 2, col = "red")

plot(y, type = "l", lty =6, lwd = 2, col = "dark red")

plot(y, type = "l", lty =6, lwd = 2)
lines(x, type = "l", lty = 5, lwd = 2, col = "dark red")

?plot


hist(error)

density(error)
?density

plot(density(error))

qqnorm(error)
boxplot(error, main = "Box plot of error")

?boxplot


# plot polynomials etc
# y = x + error

z = y^2 * exp(-y/2) + 0.01

plot(z)

plot(z, type = "l")

plot(z, xlim = c(0,25), type = "l")

plot(z, xlim = c(0,25), type = "l", main = "Summer School Critique")

plot(z, xlim = c(0,25), type = "l", main = "Summer School Critique", col = "dark red")

plot(z, xlim = c(0,25), type = "l", main = "Summer School Critique", col = "dark red", lwd = 3)

plot(z, xlim = c(0,25), type = "l", main = "Summer School Critique", col = "dark red", lwd = 3, xlab = "έτη", ylab = "% κερδους")

plot(z, xlim = c(0,25), type = "l", main = "Summer School Critique", col = "dark red", lwd = 3, xlab = "έτη", ylab = "% κέρδους")





# Μπορεί να θέλουμε να κάνουμε Plot τη θεωρητική συνάρτηση
f <- function(x) x^2 * exp(-x / 2) + 0.01

# plot f
curve( f(x), 0, 25, main = expression(paste("Θεωρητική συνάρτηση: ", x^2 * e^{-x/2} + 0.01)) )

?curve

# Combine points with curve

plot(z, xlim = c(0,25), type = "l", main = "Summer School Critique", col = "dark red", lwd = 3, xlab = "έτη", ylab = "% κέρδους")
curve( f(x), 0, 25, add = TRUE )




############## Let's continue with the data structures #########################

# Logical vectors:

# Ας φτιάξουμε ένα διάνυσμα με τυχαίους αριθμούς απο την ομοιόμορφη κατανομή

v = runif(10, -10, 10)

v


# Μπορούμε να ελέγξουμε εάν το διάνυσμα έχει τιμές μεγαλύτερες του 0
v > 0


# Ποιές είναι αυτές οι τιμές; Βάζουμε τη συνθήκη μέσα στα []
v[ v>0 ]

# Ας φτιάξουμε ένα δεύτερο διάνυσμα με τυχαίους αριθμούς
w = runif(10,-10,10)

# Μπορούμε να ελέγξουμε αν το w έχει ίδιες τιμές με το v?
v == w

all.equal(v,w)

all.equal(v, v)



# Μήτρες / Πίνακες

# Μπορούμε να φτιάξουμε μήτρες με την εντολή matrix
?matrix

# Σύνταξη: matrix(vector, nrow, ncol, byrow OR bycol)


matrix( 1:9, nrow = 3, ncol = 3) # Αν δεν το θέσουμε, τα στοιχεία του διανύσατος μπαίνουνε ανα στήλη (bycol)

matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)

# Μπορούμε να γράψουμε κατευθείαν το διάνυσμα μέσα στο matrix()
matrix( c(1,10,3,2,0,5,1,4,0) , nrow = 3, ncol = 3, byrow = T)

# Ή πιο όμορφα:
z = c(1,10,3,2,0,5,1,4,0)

matrix(z, nrow =3, ncol =3)

# Πώς βλέπουμε μεμονομένα τα στοιχεία μιας μήτρας;

# Έστω μια μήτρα Μ 3x3
M = matrix(1:9, nrow = 3, ncol = 3)

# M[ γραμμη, στήλη ]
M[1,2]
M[2,1]
M[3,1]

# Μπορούμε να συνδιάσουμε πολλά διανύσματα σε μια μήτρα
x = 1:3
y = 4:6
z = 7:9

# ανά γραμμή (row bind)
rbind(x,y,z)
rbind(y,x,z)

# ανά στύλη (column bind)
cbind(x,y,z)
cbind(y,x,z)


# Διαγώνια μήτρα

diag( c(1,2,3,4,5) )

diag(1, 10) # Μοναδιαία μήτρα 10x10


# To diag μας δίνει και τη διαγώνιο μιας μήτρας που έχουμε ήδη ορίσει:
M = matrix( c(1,2,3,4) , byrow = T, ncol = 2)
M

diag( M )

# ίχνος μήτρας (άθροισμα κύριaς διαγωνίου). Δεν υπάρχει built-in συνάρτηση, αλλά είναι εύκολο:
sum( diag(M) )



# Submatrix
# Έστω Μ
M = matrix(1:9, 3,3)


M[ c(1,3), c(1,3) ] # M [ c(γραμμες), c(στειλες) ]

M[ c(1,2,3) , c(1,3) ]

# Έστω Μ
M = matrix(1:9, 3,3)

summary(M)


# πράξεις
M

# Η R γενικά, κάνει πράξεις ανά στοιχείο
M + 1
M / 2
M * 10
log(M)
exp(M)
sqrt(M)

# Προσθεση ανά στοιχείο
M + M

# Κανονικά η διαίρεση μητρών απαγορεύεται. Εδώ μπορούμε να κάνουμε την πράξη Μ / Μ επειδή η R διαιρεί τα στοιχεία μεταξύ τους
M / (2.1*M) 

# # Πολλαπλασιασμός μητρών

# Έστω 2 τυχαίες μήτρες 3x3
M1 = matrix(runif(9), 3,3)
M1
M2 = matrix(runif(9),3,3)
M2

M1 * M2

# O πολλαπλασιασμός μητρών γίνεται με τη σύνταξη: % * %
M3 = M1 %*% M2

M3


# ορίζουμε (det)
# Έστω μια μήτρα 2x2
M = matrix(c(1,2,3,4),2,2)
M

det(M)




# Αντίστροφη μήτρα: transpose (t)
# Έστω μήτρα Μ 3x3
M = matrix(1:9, 3,3)
M
t( M )

# Library με πολλές εντολές για γραμμική άλγευρα:
library(Matrix)



# Αντιστροφή μήτρας (inverse) https://en.wikipedia.org/wiki/Invertible_matrix#

# Έστω μια μήτρα 3x3
M1 = matrix(runif(9), 3,3)
M1

# H αντίστροφη της υπολογίζεται με την εντολή solve()
solve(M1)

M1_inv = solve(M1)
M1_inv # inverse of M1




# Πώς αλλιώς μπορούμε να επιβεβαιώσουμε ότι είναι όντως η αντίστροφη;
# Η αντίστροφη της αντίστροφης, δίνει την αρχική μήτρα
all.equal(solve(solve(M1)),M1)





# Εφαρμογή 1: Λύστε το παρακάτω γραμμικό σύστημα με τη χρήση γραμμικής άλγευρας

 x + 0.5 y + 0.3 z = 1
 0.5 x + 0.3 y + 0.25 z = 0
 0.3 x + 0.25 y + 0.2 z = 0

# Hint: Ax = b -->  x = A^(-1)*b


A = matrix(c(1,0.5,0.3, 0.5, 0.3, 0.25, 0.3,0.25, 0.25), nrow = 3, ncol = 3, byrow = TRUE)

A_inv = solve(A)

b = c(1,0,0)

x = A_inv %*% b 














A = matrix(c(1, 0.5, 0.3, 0.5, 0.3, 0.25, 0.3, 0.25, 0.2), nrow = 3, ncol = 3, byrow = TRUE)
A
Ainv = solve(A)
b = c(1, 0, 0)
x = Ainv %*% b
x










# In real life
solve(A, b)

?solve





# Εφαρμογή 2: Εργασιακή Θεωρία της Αξίας. Εστω μια οικονομία με 2 αγαθa, σιτάρι και γάλα 

# Για την παραγωγή μιας μονάδας σιταριού απαιτούνται: 0.3 μονάδες σιτάρι, 0.2 μονάδες γάλα και 1 ώρα άμεσης εργασίας
# Για την παραγωγή μιας μονάδας γάλακτος απαιτούνται: 0.2 μονάδες σιτάρι, 0.4 μονάδες γάλα και 0.5 ώρα άμεσης εργασίας

#1) Υπολογίστε την αξία των δύο αγαθών με βάση την εργασιακή θεωρία της αξίας
#2) Σε τι σχετική τιμή προβλέπει η εργασιακή θεωρία ότι θα ανταλλάσσονται τα 2 εμπορεύματα;






# Hint:

# V(σιταρι) = L(σιταρι) + V(σιταρι)*a(11) + V(γαλακτος)*a(21)

# V(γαλα) = L(γαλακτος) + V(σιταρι)*a(12) + V(γαλακτος)*a(22)





# V = L + A * V
# V - A * V = L
# V * (I - A) = L
# V = (I - A)^(-1) * L


# Leontief inverse = (I - A) ^ (-1)

# V(αξίες) = Leontief_inverse * L

# Για την παραγωγή μιας μονάδας σιταριού απαιτούνται: 0.3 μονάδες σιτάρι, 0.2 μονάδες γάλα και 1 ώρα άμεσης εργασίας
# Για την παραγωγή μιας μονάδας γάλακτος απαιτούνται: 0.2 μονάδες σιτάρι, 0.4 μονάδες γάλα και 0.5 ώρα άμεσης εργασίας


A = matrix(c(0.3,0.2,0.2,0.4), ncol = 2, nrow = 2, byrow = T )
L = c(1,0.5)

Identity = diag(1, 2)

Leontief = Identity - A

Leontief_inverse = solve(Leontief)

V = Leontief_inverse %*% L

Vsitiari = V[1,1]
Vgala = V[2]
relative_p = Vsitiari/ Vgala
Vsitari = V[1]
Vgala = V[2]

relative_p = V[1]/V[2]











A = matrix(c(0.3, 0.2, 0.2, 0.4), nrow = 2, ncol = 2, byrow = TRUE)
L = c(1, 0.5)
I_diag = diag(1,2)
Leontief_inverse = solve(I_diag - A)

V = Leontief_inverse %*% L

Vsitari = V[1]
Vgala = V[2]

Vsitari/Vgala








# Πιο γρήγορα
V = solve(I_diag - A, L)


# Συνέχεια της άσκησης: Υπεραξία και ποσοστό εκμετάλλευσης
# Έστω καλάθι των μισθωτών, b, το οποίο αποτελείται από 0.4 μονάδες σιταριού και 0.1 μονάδες γάλακτος ανά ώρα εργασίας
# Να βρεθεί η υπεραξία του συστήματος
# Να βρεθεί το ποσοστό εκμετάλλευσης





# Hint:
# Yπεραξία: Το πλεόνασμα που ΔΕΝ μένει στους εργάτες
# Ποσοστό εκμετάλλευσης = Υπεραξία / αξία εργατικής δύναμης (μισθοί)

















# Καλάθι κατανάλωσης μισθωτών


b = c(0.4, 0.1)



# Πόσες ώρες εργασίας απαιτούνται για την αναπαραγωγή της εργασίας;


# V(σιταρι) * b(σιταρι) + V(γαλα) * b(γάλα)

1- V %*% b

value_of_L_power = V %*% b

# Ό,τι περισσεύει, είναι το κομμάτι της απλήρωτης εργασίας ανά ώρα δουλειάς, που πάει στον καπιταλιστή: Υπεραξία

surplus_value = 1 - V %*% b



rate_of_exploitation = surplus_value / value_of_L_power




# Fundamental Marxian Theorem (FMT), Morishima (1975): Τα κέρδη είναι θετικά, αν και μόνο αν: rate_of_exploitation > 0



surplus_value = 1 - V%*%b
rate_of_exploitation = (1- V%*%b)/( V%*%b   )








################################################################################


A

# Eigenvalues
a = eigen( A )

a$values

a$vectors

# To access particular elements, use $
eigen(A)$values
eigen(A)$vectors


# Decompositions

# Lower - Upper: A = LU: https://en.wikipedia.org/wiki/LU_decomposition
M = matrix(c(4,3,6,3), 2,2,byrow = T)
M
lu.M=lu(M)
lu.M = expand(lu.M)
lu.M$L
lu.M$U

# Cholesky: U^T U: https://en.wikipedia.org/wiki/Cholesky_decomposition
M
chol(M)

M2 = matrix(c(8,6,6,4), nrow = 2)
chol(M2)
# why?
eigen(M2) # negative eigenvalues i.e. non positive definite

# Application of cholesky
M = matrix(c(8,5,5,4),2,2)
M_chol = chol(M)

solve(M)
chol2inv((M_chol))

all.equal(solve(M), chol2inv(M_chol))


# Singular value : https://en.wikipedia.org/wiki/Singular_value_decomposition
M
svd(M)



####################### Plotting matrices ######################################

# Combine different functions in one plot

# set a sequencce
x = seq(-4 * pi, 4 *pi, pi/6)

y1 = sin(x)
y2 = sin(x+pi/6) + 0.1
y3 = sin(x+pi/6) + 0.2

# combine in one matrix
m = cbind(y1,y2,y3)
m

# to plot data from a matrix: matplot
matplot(x, m ,type ="l")
matplot(x,m,type= "l", main = "sine functions")
legend("bottomleft", legend = c("y1", "y2", "y3"), col= 1:3, lty=1:3)



# 2D - 3D plots
# Example: utility function
# Create a grid of values
a = 1:20
b = 1:20
a_grid <- rep(a, each = length(b))
a_grid
b_grid <- rep(b, length(a))
b_grid
?rep
# Compute utility for each combination of a and b
utility <- matrix(  a_grid^(1/2) * b_grid^(1/2), nrow = length(a), ncol = length(b))

# Create a contour plot
contour(a, b, utility, xlab = "a", ylab = "b", main = expression(paste("Indifference curves, utility function ", u == sqrt(a * b))), col = terrain.colors(10))


persp(a, b, utility, xlab = "a", ylab = "b", zlab = "Utility", 
      main = "3D Plot of Utility Function", col = "lightblue")

persp(a, b, utility, xlab = "a", ylab = "b", zlab = "Utility", 
      main = "3D Plot of Utility Function", col = "lightblue", theta = 30, phi = 30)


any_function <- matrix(2*a_grid^(1/2) * log(b_grid)^(3/2) - 3*sin(a_grid), nrow = length(a), ncol = length(b))

persp(a, b, any_function, xlab = "a", ylab = "b", zlab = "z", 
      main = "3D Plot of any function", col = "lightblue", theta = 30, phi = 30)

#install.packages("scatterplot3d")
library(scatterplot3d)
x = 1:20
y = 1:20
z = runif(20)
scatterplot3d(x,y,z)
scatterplot3d(x,y,z, type = "h")
scatterplot3d(x,y,z, type = "l")


############# More data structures #############################################


# Lists

# Create a list containing economic data for three countries (fictitious data)
economic_data <- list(
  
  USA = list(
    GDP = 21433,          # in billions USD
    Inflation = 1.2,      # in percentage
    Population = 331      # in millions
  ) ,
  
  Germany = list(
    GDP = 3846,           # in billions USD
    Inflation = 0.4,      # in percentage
    Population = 83       # in millions
  ) ,
  
  Japan = list(
    GDP = 5082,           # in billions USD
    Inflation = 0.0,      # in percentage
    Population = 126      # in millions
  )
  
)

# Print the list
print(economic_data)

economic_data$USA$GDP
# Access GDP of USA


usa_gdp <- economic_data$USA$GDP

print(paste("USA GDP:", usa_gdp))




# Access inflation rate of Germany


germany_inflation <- economic_data$Germany$Inflation

print(paste("Germany Inflation Rate:", germany_inflation))


# Access population of Japan


japan_population <- economic_data$Japan$Population

print(paste("Japan Population:", japan_population))



# Add stuff to the list

# Add unemployment rate data
economic_data$USA$Unemployment <- 6.0   # in percentage
economic_data$Germany$Unemployment <- 4.5
economic_data$Japan$Unemployment <- 2.8

# Print the updated list
print(economic_data)



# Extract data from the list


gdp_values <- c(economic_data$USA$GDP, economic_data$Germany$GDP, economic_data$Japan$GDP)

inflation_values <- c(economic_data$USA$Inflation, economic_data$Germany$Inflation, economic_data$Japan$Inflation)

population_values <- c(economic_data$USA$Population, economic_data$Germany$Population, economic_data$Japan$Population)

# Calculate averages

average_gdp <- mean(gdp_values)

average_inflation <- mean(inflation_values)

average_population <- mean(population_values)

# Print the results

print(paste("Average GDP:", average_gdp))

print(paste("Average Inflation Rate:", average_inflation))

print(paste("Average Population:", average_population))

?read_csv


# Data frames

# Data Frames

economic_data_df <- data.frame(
  country = c("USA", "Germany", "Japan"),
  gdp = c(100, 80, 90),
  inflation = c(5.5, 4.3, 2.2),
  unemployment = c(11.1, 5.5, 2.1),
  revolution = c(FALSE, FALSE, FALSE)
)



write.csv(economic_data_df, "economic_data.csv")

library(readr)
economic_data <- read_csv("economic_data.csv")






################# Section 2: Download & manipulate economic data ###############

# Economic Data
library(eurostat)
library(dplyr)
library(ggplot2)

# pdfetch

# Data: https://ec.europa.eu/eurostat/databrowser/explore/all/economy?lang=en&display=list&sort=category


# Sectoral Balances: https://en.wikipedia.org/wiki/Sectoral_balances

# 3 balances

# (S - I) = (G - T) + (X - IM)

# 5 balances

# (S_households - I_households) + (S_firms - I_firms) + (S_banks - I_banks) = (G - T) + (X - IM)



# set the id (look for the ids in eurostat's website)
# nasa 10 nf tr = national sectoral accounts non financial transactions

id = "nasa_10_nf_tr"

# load the data (u need internet)
data <- get_eurostat( id , time_format = "num")

# select only the data for Greece
#"EL" = Greece

dataGR <- data[ data$geo == "DE" , ]



# B9 = Net lending (+) /net borrowing (-)   (sectoral balance / flow of funds)
# cp_mnac = current prices national currency
# Direct = paid vs received
# S11 = NFC, S12 = FC, S13 = General Government, S14 = Households, S2 = RoW


sectors <- c("S11", "S12", "S13","S14","S2")





sectoral_balances_GR <- dataGR %>%
  
  
  filter(na_item == "B9", direct == "PAID", unit == "CP_MNAC", sector %in% sectors) %>%
  
  select( -freq, -na_item, - direct, -unit, - geo ) %>%  # get read of unecessary columns
  
  rename(year = TIME_PERIOD)


write.csv(sectoral_balances_GR, "sectoral_balances_GR.csv")


library(ggplot2)


ggplot( data = sectoral_balances_GR, aes( x = year, y = values, color = sector)) +
  geom_line(size = 1.2) +
  theme_classic()


?ggplot




# fix the names

sectoral_balances_GR <- sectoral_balances_GR %>%
  mutate(sector = recode(sector,                  # mutate: access the vectors inside the data frame; recode: change their values
                         "S11" = "Non-Financial Corporations",
                         "S12" = "Financial Corporations",
                         "S13" = "General Government",
                         "S14" = "Households",
                         "S2" = "Rest of the world"))

ggplot(data = sectoral_balances_GR, aes(x = year, y = values, color = sector)) +
  geom_line(size = 1.2) +
  geom_hline(yintercept = 0, color = "black", linetype = "dotted", lwd = 1.4) +
  ggtitle("Sectoral Balances (million EUR), Greece, 1995-2022")+
  theme_minimal()

pdfetch

#gdp = B1GQ

gdp_data <- data %>%
  filter(na_item == "B1GQ", direct == "PAID", unit == "CP_MNAC", sector == "S1", geo == "EL") %>%
  select(-freq,- na_item, - direct, -unit, - geo, -sector ) %>%
  rename(year = TIME_PERIOD)

ggplot(data = gdp_data, aes(x = year, y = values)) +
  geom_line(size = 1.2)+
  ggtitle("Greek GDP (mil. EUR), nominal")



