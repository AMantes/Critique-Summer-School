
y <- function(t) 10 * exp(2 * t)
# Plot the curve
curve(y, from = 0, to = 3, main = expression(paste("Λύση διαφορικής εξίσωσης: ", 10 * e^{2 * t})))


# Explode: Re(l1) > 0 , Im = 0

y <- function(t) (2/3)*exp(5*t) + (1/3)*exp(2*t)
z <- function(t) (2/3)*exp(5*t) - (2/3)*exp(2*t)
curve(y, from = 0, to = 0.5, main = "Λύση του συστήματος διαφορικών εξισώσεων", ylim = c(-1,10))
curve(z, from = 0, to = 0.5, add = T, col = "red")


# Explode Re(l2), Re(l1) > 0
y <- function(t) (2/3)*exp(5*t) + (1/3)*exp(2*t)
z <- function(t) (2/3)*exp(5*t) - (2/3)*exp(2*t)
curve(y, from = 0, to = 1, main = "Λύση του συστήματος διαφορικών εξισώσεων", ylim = c(-1,20),lwd=2.5)
curve(z, from = 0, to = 1, add = T, col = "red", lwd = 2.5)



# spiral unstable, Re > 0 Im >0
y <- function(t) exp(0.5*t)* ( (2/3) *  cos(2*t)  -sin(2*t) * (1/3) + (2/3) *( sin(2*t)*(2/3)  +cos(2*t) * (1/3)) )
z <- function(t) exp(0.5*t)* ( (4/3) *  cos(2*t)  -sin(2*t) * (1/3) + (4/3) *( sin(2*t)*(4/3)  +cos(2*t) * (1/3)) )
curve(y, from = 0, to = 10, main = "Λύση του συστήματος διαφορικών εξισώσεων", ylim = c(-100,100),lwd=2.5)
curve(z, from = 0, to = 10, add = T, col = "red", lwd = 2.5)

# Generate a sequence of t values
t_values <- seq(0, 20, by = 0.01)

# Compute corresponding y and z values
y_values <- y(t_values)
z_values <- z(t_values)


# Plot y against z
plot(y_values, z_values, type = "l", col = "black", lwd = 2.5,
     main = expression(paste("Λύση του συστήματος διαφορικών εξισώσεων ", y, " vs ", z)),
     xlab = "y(t)", ylab = "z(t)", xlim = c(min(y_values, z_values), max(y_values, z_values)), ylim = c(min(y_values, z_values), max(y_values, z_values)))

# Add arrows to indicate the direction of movement with fewer arrows
arrow_length <- 0.1
arrow_step <- 10  # Place an arrow every 10 points
for (i in seq(1, length(t_values) - arrow_step, by = arrow_step)) {
  arrows(y_values[i], z_values[i], y_values[i + arrow_step], z_values[i + arrow_step], length = arrow_length, col = "red")
}


# Spiral Stable


y <- function(t) exp(-0.5*t)* ( (2/3) *  cos(2*t)  -sin(2*t) * (1/3) + (2/3) *( sin(2*t)*(2/3)  +cos(2*t) * (1/3)) )
z <- function(t) exp(-0.5*t)* ( (4/3) *  cos(2*t)  -sin(2*t) * (1/3) + (4/3) *( sin(2*t)*(4/3)  +cos(2*t) * (1/3)) )
curve(y, from = 0, to = 10, main = "Λύση του συστήματος διαφορικών εξισώσεων", ylim = c(-1,2),lwd=2.5)
curve(z, from = 0, to = 10, add = T, col = "red", lwd = 2.5)


# Generate a sequence of t values
t_values <- seq(0, 10, by = 0.01)

# Compute corresponding y and z values
y_values <- y(t_values)
z_values <- z(t_values)


# Plot y against z
plot(y_values, z_values, type = "l", col = "black", lwd = 2.5,
     main = expression(paste("Λύση του συστήματος διαφορικών εξισώσεων ", y, " vs ", z)),
     xlab = "y(t)", ylab = "z(t)", xlim = c(min(y_values, z_values), max(y_values, z_values)), ylim = c(min(y_values, z_values), max(y_values, z_values)))

# Add arrows to indicate the direction of movement with fewer arrows
arrow_length <- 0.1
arrow_step <- 10  # Place an arrow every 10 points
for (i in seq(1, length(t_values) - arrow_step, by = arrow_step)) {
  arrows(y_values[i], z_values[i], y_values[i + arrow_step], z_values[i + arrow_step], length = arrow_length, col = "red")
}

# cycle
y <- function(t) exp(0.*t)* ( (2/3) *  cos(2*t)  -sin(2*t) * (1/3) + (2/3) *( sin(2*t)*(2/3)  +cos(2*t) * (1/3)) )
z <- function(t) exp(0.*t)* ( (4/3) *  cos(2*t)  -sin(2*t) * (1/3) + (4/3) *( sin(2*t)*(4/3)  +cos(2*t) * (1/3)) )
curve(y, from = 0, to = 10, main = "Λύση του συστήματος διαφορικών εξισώσεων", ylim = c(-2.5,2.5),lwd=2.5)
curve(z, from = 0, to = 10, add = T, col = "red", lwd = 2.5)


# Generate a sequence of t values
t_values <- seq(0, 4, by = 0.01)

# Compute corresponding y and z values
y_values <- y(t_values)
z_values <- z(t_values)


# Plot y against z
plot(y_values, z_values, type = "l", col = "black", lwd = 2.5,
     main = expression(paste("Λύση του συστήματος διαφορικών εξισώσεων ", y, " vs ", z)),
     xlab = "y(t)", ylab = "z(t)", xlim = c(min(y_values, z_values), max(y_values, z_values)), ylim = c(min(y_values, z_values), max(y_values, z_values)))

# Add arrows to indicate the direction of movement with fewer arrows
arrow_length <- 0.1
arrow_step <- 10  # Place an arrow every 10 points
for (i in seq(1, length(t_values) - arrow_step, by = arrow_step)) {
  arrows(y_values[i], z_values[i], y_values[i + arrow_step], z_values[i + arrow_step], length = arrow_length, col = "red")
}