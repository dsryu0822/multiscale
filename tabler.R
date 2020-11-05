setwd("C:\\Users\\rmsms\\OneDrive\\lab\\Multiscale")

# meta_data = read.csv(file.choose(getwd()))
nrow(meta_data)

outbreak_threshold = 500
condition_threshold = 5

outbreak <- (meta_data$R_B < outbreak_threshold)
condition <- (meta_data$hub_I < condition_threshold)


plot(NA,NA, xlim=c(1,10.5), ylim = c(0,20), xlab = 't', ylab = 'hub_I')
for (t in 1:nrow(meta_data)){
  lines(1:10,meta_data[t,7:16],
        col = ((-1*as.numeric(outbreak))+2)[t],
        lwd = ((as.numeric(outbreak))+1)[t])
  text(10.5,meta_data[t,16],t)
}
abline(h = condition_threshold, col = 'blue')
meta_data[167,]

table(outbreak, condition)

out <- lm(outbreak~condition); summary(out)
