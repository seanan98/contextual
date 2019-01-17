library(contextual)

## Multi-armed Bandit examples taken from "Reinforcement Learning: An Introduction"
## by Sutton and Barto, 2nd ed. (Version: 2018)

# 2.3 The 10-armed Testbed -----------------------------------------------------------------------------------

set.seed(1)
mus                <- rnorm(10, 0, 1)
sigmas             <- rep(1, 10)
bandit             <- BasicGaussianBandit$new(mu_per_arm = mus, sigma_per_arm = sigmas)


# violin plot ------------------------------------------------------------------------------------------------

library(ggplot2); library(ggnormalviolin)
print(ggplot(data = data.frame(dist_mean = mus, dist_sd = sigmas, dist = factor((1:10))), aes(x = dist,
             mu = dist_mean, sigma = dist_sd)) + ylab("Reward distribution") + geom_normalviolin() +
             theme(legend.position = "none") + xlab("Action") + geom_hline(aes(yintercept = 0)))

# epsilon greedy plot ----------------------------------------------------------------------------------------

agents             <- list(Agent$new(EpsilonGreedyPolicy$new(0),    bandit, "e = 0, greedy"),
                           Agent$new(EpsilonGreedyPolicy$new(0.1),  bandit, "e = 0.1"),
                           Agent$new(EpsilonGreedyPolicy$new(0.01), bandit, "e = 0.01"))

simulator          <- Simulator$new(agents = agents, horizon = 1000, simulations = 2000)

history            <- simulator$run()

plot(history, type = "average", regret = FALSE, lwd = 1, legend_position = "bottomright")

# 2.7 - Upper-Confidence-Bound Action Selection --------------------------------------------------------------

agents             <- list(Agent$new(EpsilonGreedyPolicy$new(0.1),  bandit, "EGreedy"),
                           Agent$new(UCB1Policy$new(),   bandit,            "UCB1"))

simulator          <- Simulator$new(agents = agents, horizon = 1000, simulations = 2000)

history            <- simulator$run()

plot(history, type = "average", regret = FALSE, lwd = 1, legend_position = "bottomright")