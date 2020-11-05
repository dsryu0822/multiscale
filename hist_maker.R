getwd()

hist_data <- read.csv(file.choose(), header = T)
# hist_data <- read.csv("record_hist.csv", header = T)

win.graph(16,9); par(mfrow=c(4,5))
for(i in 1:20) {
  hist(hist_data[,i], main = paste0("beta_A = " ,names(hist_data)[i]), xlim=c(0,0.01))
}

win.graph(16,9); par(mfrow=c(4,5))
for(i in 1:20) {
  hist(hist_data[,i+20], main = paste0("beta_A = " ,names(hist_data)[i+20]), xlim=c(0,1))
}

