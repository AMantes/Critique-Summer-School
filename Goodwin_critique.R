#################### Critique Summer School 2024 ###############################
#################### Introduction to Political Economy: Modelling ###############


# empty the environment

rm(list = ls())



# Load necessary packages
library(deSolve)
library(ggplot2)
library(stats)
library(DEoptim)

######################### Goodwin Cycles #######################################

# We need: Equations, Parameter values, Initial condition

# 1.Define the parameters from Grasselli and Costa-Lima (2012)  https://ms.mcmaster.ca/~grasselli/GrasselliCostaLima_MAFE_online.pdf
parameters <- c(
  nu      = 3,
  alpha   = 0.025, 
  beta    = 0.02,
  delta   = 0.01,
  phi0    = 0.04 / (1 - 0.04^2),
  phi1    = 0.04^3 / (1 - 0.04^2)
)

parameters

# Define the Goodwin model, as a function

# Η εξίσωση δέχεται 3 ειδών data:
# a. Για πόσα χρόνια θα τρέξουμε το μοντέλο (time)
# β. Τις αρχικές συνθήκες (το αρχικό ω και λ για t = 0)
# γ. Τις τιμές των παραμέτρων του μοντέλου (phi1, phi0, nu, alpha, beta, delta)

# Θα χρησιμοποιήσουμε μια μη γραμμική εξίσωση για την real wage Phillips Curve, όπως η Grasselli & Costa Lima:  (phi1 / ((1 - lambda)^2) - phi0

Goodwin <- function(Time, State, Pars) {

    with(as.list(c(State, Pars)), {                   # λέμε στην R να διαβάσει το "State" και τις παραμέτρους "Pars" σαν λίστες
  
        domega <- (phi1 / ((1 - lambda)^2) - phi0 - alpha) * omega # ω_dot = ...
        
        dlambda <- ((1 - omega) / nu - (alpha + beta + delta)) * lambda # λ_dot = ...
    
        return(list(c(domega, dlambda)))              # λέμε στην R να μας επιστρέψει μια λίστα με 2 διανύσματα: Ένα διάνυσμα με τις τιμές (ανά ημέρα) για το ωμέγα_dot και ένα διάνυσμα με τις τιμές (ανά ημέρα) του λάμδα_dot
  })
}


# Ορίζουμε τις αρχικές συνθήκες: Τη χρονική στιγμή t = 0, η οικονομία έχει ω = 0.8 (80% μερίδιο μισθών) και λ = 0.9 (90% ποσοστό απασχόλησης - 10% ανεργία)

# Initial conditions
Goodwin_initial_conditions <- c(omega = 0.8, lambda = 0.9)

# Έστω οτι θέλουμε να τρέξουμε το μοντέλο για 20 χρόνια
# Επειδή ο υπολογιστής δεν καταλαβαίνει τον χρόνο ως "συνεχή", πρέπει να χωρίσουμε τον χρόνο σε μικρά steps
# Μια καλή υπόθεση, είναι οτι το μοντέλο ανανεώνεται κάθε Μήνα. Άρα θα σπάσουμε τον 1 χρόνο σε 12 μήνες

# Στην πράξη, το step πρέπει να είναι σχετικά μικρό, πχ 0.03 ανά 1 χρόνο (εδώ έχουμε πολύ μεγαλύτερο)


# Time sequence
Time <- 20 # χρόνια
N <- 12 # steps ανά χρόνο
times <- seq(0, Time, by = Time / (Time*N))


# Τρέχουμε το θεωρητικό μοντέλο:
# H εντολή ode, χρειάζεται 4 πράγματα για να τρέξει:
# 1. Τις αρχικές συνθήκες (initial conditions)
# 2. την χρονική περίοδο (times)
# 3. To μοντέλο (Goodwin)
# 4. Τις παραμέτρους του μοντέλου (parameters)

?ode

out <- ode(y = Goodwin_initial_conditions, times = times, func = Goodwin, parms = parameters)

# O υπολογιστής δεν μπορεί να "λύσει" το μοντέλο στην πραγματικότητα. Αυτό που κάνει είναι με αριθμητικές μεθόδους, να προσεγγίζει αριθμητικά, την λύση του συστήματος.
# Υπάρχουν διάφορες ποσοτικές μέθοδοι που "λύνουν" και προσεγγίζουν ποσοτικά ένα δυναμικό σύστημα
# O default solver λέγεται lsoda και είναι ιδανικός για πολλά είδη διαφορικών εξισώσεων
# Ένας καλός εναλλακτικός solver είναι ο Runge Kutta 4th order: method = "rk4"
# Εμείς θα αφήσουμε την R να "λύσει" το σύστημα με τον default lsoda.
# https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods


out

out_df1 <- as.data.frame(out) # original data saved as data frame

# Ας δούμε τις χρονοσειρές

# Phase plot (διάγραμμα φάσης)
ggplot(out_df1, aes(x = omega, y = lambda)) +
  geom_path(color = "darkblue") +
  labs(
    x = expression(omega),
    y = expression(lambda),
    title = "Goodwin Model Phase Portrait"
  ) +
  theme_minimal()

# plot(out[,2],out[,3], xlab = expression(omega), ylab = expression(lambda),type = "l", col="blue", main = 'Goodwin model')

# χρονοσειρές
ggplot(data = out_df1, aes(x = time)) +
  geom_line(aes(y = omega, color = "omega")) +
  geom_line(aes(y = lambda, color = "lambda")) +
  labs(x = "Time", y = "Values", title = "Goodwin Model (theoretical cycles)") +
  scale_color_manual("", breaks = c("omega", "lambda"), values = c("blue", "red")) +
  theme_minimal()



############################ Model Calibration #################################



# Στην πραγματικότητα δεν γνωρίζουμε τις παραμέτρους του μοντέλου
# Θα πρέπει να τις εκτιμήσουμε, όπως θα κάναμε για οποιαδήποτε οικονομετρική εξίσωση

# Στις διαφορικές εξισώσεις η παραδοσιακή οικονομετρία δεν δουλεύει, επειδή ο χρόνος είναι συνεχής
# Ευτυχώς υπάρχουν αντίστοιχες τεχνικές όπως πχ η μέθοδος ελαχίστον τετραγώνων, που κάνουν κάτι παραπλήσιο
# Βρίσκουν τις παραμέτρους που ελαχιστοποιούν το τετράγωνο του σφάλματος μεταξύ του μοντέλου και των πραγματικών δεδομένων


# Σήμερα θα κάνουμε το εξής: Θα φτιάξουμε artifical data μέσα απο το μοντέλο και θα προσθέσουμε στοχαστικά ένα σφάλμα
# Στη συνέχεια, θα υποθέσουμε οτι ΔΕΝ ξέρουμε τις παραμέτρους, και θα προσπαθήσουμε να τις βρούμε "εμπειρικά" (calibration)


# Αρχικά, αποθηκεύουμε τα αποτελέσματα του θεωρητικού μοντέλου σε ένα νέο data frame
out_df <- as.data.frame(out)


# Στην μεταβλητή ω (omega) προσθέτουμε ένα σφάλμα μέσω της κανονικής κατανομής (rnorm)
# Χρειαζόμαστε τόσα σφάλματα, όσες παρατηρήσεις έχουμε για το ω (20 χρόνια, με ετήσια συχνότητα) (length(out_df$omega)). Έστω οτι sd = 0.03

out_df$omega <- out_df$omega + rnorm(length(out_df$omega), sd = 0.03)  # Add noise to omega

# Το ίδιο και για το λ
out_df$lambda <- out_df$lambda + rnorm(length(out_df$lambda), sd = 0.03)  # Add noise to lambda


# Plot the artificial data
ggplot(data = out_df, aes(x = time)) +
  geom_line(aes(y = omega, color = "omega")) +
  geom_line(aes(y = lambda, color = "lambda")) +
  labs(x = "Time", y = "Values", title = "Goodwin Model with Artificial Data") +
  scale_color_manual("", breaks = c("omega", "lambda"), values = c("blue", "red")) +
  theme_minimal()


ggplot(out_df, aes(x = omega, y = lambda)) +
  geom_path(color = "blue") +
  labs(
    x = expression(omega),
    y = expression(lambda),
    title = "Goodwin Model Phase Portrait"
  ) +
  theme_minimal()



# plot for calibrated model against artificial data
ggplot() +
  geom_line(data = out_df, aes(x = time, y = omega, color = "omega (data)"), alpha = 0.3, size = 1) +
  geom_line(data = out_df, aes(x = time, y = lambda, color = "lambda (data)"), alpha = 0.3, size = 1) +
  geom_line(data = out_df1, aes(x = time, y = omega, color = "omega (original)"), linetype = "dashed", size = 1.1) +
  geom_line(data = out_df1, aes(x = time, y = lambda, color = "lambda (original)"), linetype = "dashed", size = 1.1) +
  labs(x = "Time", y = "Values", title = "adding noise to Goodwin cycles") +
  scale_color_manual("", breaks = c("omega (data)", "lambda (data)", "omega (original)", "lambda (original)"),
                     values = c("blue", "red", "darkblue", "darkred")) +
  theme_minimal() +
  theme(legend.position = "bottom")


# Define a function to simulate the Goodwin model
simulate_goodwin <- function(params, times, initial_state) {
  out <- ode(y = initial_state, times = times, func = Goodwin, parms = params)
  return(as.data.frame(out))
}

# Define the objective function for optimization
objective_function <- function(params) {
  params <- list(nu = params[1], alpha = params[2], beta = params[3], delta = params[4], phi0 = params[5], phi1 = params[6])
  sim_df <- simulate_goodwin(params, times, Goodwin_initial_conditions)
  sum((sim_df$omega - out_df$omega)^2 + (sim_df$lambda - out_df$lambda)^2)  # Sum of squared errors

}

# Other objective functions

# log likelihood
# -sum(dnorm(out_df$omega, mean = sim_df$omega, sd = 0.05, log = TRUE) +
#       dnorm(out_df$lambda, mean = sim_df$lambda, sd = 0.05, log = TRUE))

# Mean Absolute Error
# mean(abs(sim_df$omega - out_df$omega) + abs(sim_df$lambda - out_df$lambda))

# Root Mean Squarred Error
# sqrt(mean((sim_df$omega - out_df$omega)^2 + (sim_df$lambda - out_df$lambda)^2))

# Initial guess for parameters
initial_guess <- c(nu = 2, alpha = 0.01, beta = 0.01, delta = 0.04, phi0 = 0.08 , phi1 =0.00001)


?optim

# Calibrate the model using optim
optim_result <- optim(
  par = initial_guess,
  fn = objective_function,
  method = "L-BFGS-B",
  lower = c(0, 0, 0, 0, 0, 0),
  upper = c(10, 0.1, 0.1, 0.1, 1, 1),
  control = list(maxit = 1000)
)



# Display the calibrated parameters
calibrated_parameters <- optim_result$par
names(calibrated_parameters) <- c("nu", "alpha", "beta", "delta", "phi0", "phi1")
print(calibrated_parameters)

# Simulate the model with the calibrated parameters
calibrated_out <- ode(y = Goodwin_initial_conditions, times = times, func = Goodwin, parms = calibrated_parameters)
calibrated_df <- as.data.frame(calibrated_out)




# Improved plot for calibrated model against artificial data
ggplot() +
  geom_line(data = out_df, aes(x = time, y = omega, color = "omega (data)"), alpha = 0.3, size = 1) +
  geom_line(data = out_df, aes(x = time, y = lambda, color = "lambda (data)"), alpha = 0.3, size = 1) +
  geom_line(data = calibrated_df, aes(x = time, y = omega, color = "omega (model)"), linetype = "dashed", size = 1.1) +
  geom_line(data = calibrated_df, aes(x = time, y = lambda, color = "lambda (model)"), linetype = "dashed", size = 1.1) +
  labs(x = "Time", y = "Values", title = "Calibration of the Goodwin Model") +
  scale_color_manual("", breaks = c("omega (data)", "lambda (data)", "omega (model)", "lambda (model)"),
                     values = c("blue", "red", "darkblue", "darkred")) +
  theme_minimal() +
  theme(legend.position = "bottom")


# plot for calibrated model against true model
ggplot() +
  geom_line(data = out_df1, aes(x = time, y = omega, color = "omega (true)"), alpha = 0.3, size = 1) +
  geom_line(data = out_df1, aes(x = time, y = lambda, color = "lambda (true)"), alpha = 0.3, size = 1) +
  geom_line(data = calibrated_df, aes(x = time, y = omega, color = "omega (calibrated)"), linetype = "dashed", size = 1.1) +
  geom_line(data = calibrated_df, aes(x = time, y = lambda, color = "lambda (calibrated)"), linetype = "dashed", size = 1.1) +
  labs(x = "Time", y = "Values", title = "Calibration of the Goodwin Model") +
  scale_color_manual("", breaks = c("omega (true)", "lambda (true)", "omega (calibrated)", "lambda (calibrated)"),
                     values = c("blue", "red", "darkblue", "darkred")) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggplot() +
  geom_path(data = out_df1, aes(x = omega, y = lambda, color = "true")) +
  geom_path(data = calibrated_df, aes(x = omega, y = lambda, color = "calibrated")) +
  labs(
    x = expression(omega),
    y = expression(lambda),
    title = "Goodwin Model Phase Portrait"
  ) +
  scale_color_manual(name = "", breaks = c("true", "calibrated"),
                     values = c("darkblue", "darkred")) +
  theme_minimal() +
  theme(legend.position = "bottom")



###################### Bonus Material ##########################################


# Η μέθοδος που εφαρμόσαμε δε δουλεύει πολύ καλά: Eπιστρέφει το initial guess :( 

# Υπάρχουν πιο προχωρημένες μέθοδοι που βασίζονται σε evolutionary algorithms
# Πρακτικά ο υπολογιστής:
# Ψάχνει στην τύχη ποιές παράμετροι κάνουν καλύτερο fit
# Φτιάχνει "οικογένειες" με αυτές τις παραμέτρους
# Φτιάχνει "απόγονους" με αυτές τις παραμέτρους ελαφρώς διαφοροποιημένες (μεταλλαγμένες) (mutations)
# Διαλέγει μετά απο πολλές τέτοιες γενιές, αυτή που έχει το μικρότερο σφάλμα 

##############################

# Bounds for the parameters: Θέτουμε άνω και κάτω όρια στον παραμετρικό χώρο, για το που να ψάξει ο αλγόριθμος


lower_bounds <- c(1, 0, 0, 0, 0, 0)
upper_bounds <- c(5, 0.1, 0.1, 0.1, 0.05, 0.05)

# Perform optimization using Differential Evolution
evolutionary_calibration_result <- DEoptim(objective_function, lower = lower_bounds, upper = upper_bounds)

?DEoptim


# Extract the best parameters
best_params <- evolutionary_calibration_result$optim$bestmem

named_params <- setNames(best_params, c("nu", "alpha", "beta", "delta", "phi0", "phi1"))

# Print the best parameters
print(named_params)


fitted_sim <- ode(y = Goodwin_initial_conditions, times = times, func = Goodwin, parms = list(
  nu = best_params[1], alpha = best_params[2], beta = best_params[3], delta = best_params[4], phi0 = best_params[5], phi1 = best_params[6]
))
fitted_sim_df <- as.data.frame(fitted_sim)

ggplot() +
  geom_line(data = out_df, aes(x = time, y = omega, color = "omega (data)"), alpha = 0.3, size = 1) +
  geom_line(data = out_df, aes(x = time, y = lambda, color = "lambda (data)"), alpha = 0.3, size = 1) +
  geom_line(data = fitted_sim_df, aes(x = time, y = omega, color = "omega (model)"), linetype = "dashed", size = 1.1) +
  geom_line(data = fitted_sim_df, aes(x = time, y = lambda, color = "lambda (model)"), linetype = "dashed", size = 1.1) +
  labs(x = "Time", y = "Values", title = "Fitted Goodwin Model vs. Artificial Data") +
  scale_color_manual("", breaks = c("omega (data)", "lambda (data)", "omega (model)", "lambda (model)"),
                     values = c("blue", "red", "darkblue", "darkred")) +
  theme_minimal() +
  theme(legend.position = "bottom")



ggplot() +
  geom_line(data = out_df1, aes(x = time, y = omega, color = "omega (true)"), alpha = 0.3, size = 1) +
  geom_line(data = out_df1, aes(x = time, y = lambda, color = "lambda (true)"), alpha = 0.3, size = 1) +
  geom_line(data = fitted_sim_df, aes(x = time, y = omega, color = "omega (calibrated)"), linetype = "dashed", size = 1.1) +
  geom_line(data = fitted_sim_df, aes(x = time, y = lambda, color = "lambda (calibrated)"), linetype = "dashed", size = 1.1) +
  labs(x = "Time", y = "Values", title = "Fitted vs True Goodwin Model") +
  scale_color_manual("", breaks = c("omega (true)", "lambda (true)", "omega (calibrated)", "lambda (calibrated)"),
                     values = c("blue", "red", "darkblue", "darkred")) +
  theme_minimal() +
  theme(legend.position = "bottom")


ggplot() +
  geom_path(data = fitted_sim_df, aes(x = omega, y = lambda, color = "true")) +
  geom_path(data = out_df1, aes(x = omega, y = lambda, color = "calibrated")) +
  labs(
    x = expression(omega),
    y = expression(lambda),
    title = "Goodwin Model Phase Portrait"
  ) +
  scale_color_manual(name = "", breaks = c("true", "calibrated"),
                     values = c("darkblue", "darkred")) +
  theme_minimal() +
  theme(legend.position = "bottom")



################################################################################

############### Άσκηση1 : Τι θα γίνει εάν ξεκινήσει το μοντέλο απο τις παρακάτω αρχικές συνθήκες; #############
#   (omega = .8, lambda = .9) 
#   (omega = .7, lambda = .925)
#   (omega = .6, lambda = .95)

# Φτιάξτε ένα plot με το phase space για όλες τις παραπάνω αρχικές συνθήκες


############# Άσκηση 2: Βρείτε το σημείο ισορροπίας και τρέξτε το μοντέλο με αυτό σαν initial condition ######
# Προσθέστε το αποτέλεσμα στο Phase Plot της άσκησης 1

############ Άσκηση 3: Πώς συμπεριφέρεται το Y_dot? Τρέξτε μια προσομοίωση και κάντε το Plot