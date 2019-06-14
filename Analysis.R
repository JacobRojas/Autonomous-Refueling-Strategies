library(ggplot2)
library(dplyr)
simResults <- read.table("simResult.txt", sep=" ", header = FALSE)

names(simResults) <- c("d = 50", "d = 60", "d = 70", "d = 80")
kSeq = c(5, 6, 8)

simResults <- cbind(k = rep(kSeq, nrow(simResults)/length(kSeq)), simResults)
simTable <- table(simResults)
sortedTable <- simResults[order(simResults$k),]

k5 <- filter(simResults, simResults$k == 5)
k6 <- filter(simResults, simResults$k == 6)
k8 <- filter(simResults, simResults$k == 8)
k5.avg <- colMeans(k5)
k6.avg <- colMeans(k6)
k8.avg <- colMeans(k8)
dLab <- c(50, 60, 70, 80)
k5.avg <- k5.avg[2:5]
k6.avg <- k6.avg[2:5]
k8.avg <- k8.avg[2:5]

k5.frame <- data.frame(k5.avg, dLab)
k6.frame <- data.frame(k6.avg, dLab)
k8.frame <- data.frame(k8.avg, dLab)

minAvg = min(k5.frame$k5.avg, k6.frame$k6.avg, k8.frame$k8.avg)
maxAvg = max(k5.frame$k5.avg, k6.frame$k6.avg, k8.frame$k8.avg)

plots <- list()
ggplot(k5.frame, aes(dLab, k5.avg)) + 
  geom_point(pch = 21, fill = "royalblue", size = 3, color = 'black') +
  ggtitle("SGAS Simulation\nk = 5") +
  xlab("Unit length, miles") +
  ylab("Success Ratio") +
  ylim(minAvg, maxAvg) +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(k6.frame, aes(dLab, k6.avg)) + 
  geom_point(pch = 21, fill = "royalblue", size = 3, color = 'black') +
  ggtitle("SGAS Simulation\nk = 6") +
  xlab("Unit length, miles") +
  ylab("Success Ratio") +
  ylim(minAvg, maxAvg) +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(k8.frame, aes(dLab, k8.avg)) + 
  geom_point(pch = 21, fill = "royalblue", size = 3, color = 'black') +
  ggtitle("SGAS Simulation\nk = 8") +
  xlab("Unit length, miles") +
  ylab("Success Ratio") +
  ylim(minAvg, maxAvg) +
  theme(plot.title = element_text(hjust = 0.5))

#dotchart(dLab, labels = k5.avg, 
#         xlab = "Unit Length, miles", 
#         ylab = "Success Ratio", 
#         main = "Success of SGAS Algorithm\nk = 5", 
#         ylim = c(0,1),
#         xaxt = 'n')
#axis(1, cex.axis = 1.2)

#identical(simResults2[2:5. ], simResults)



