# plot(table(as.numeric(meta_data.0$R_B > 100), as.numeric(meta_data.0$hub_I > 5)))/

subject_dir = "201102 gamma change"; work_dir = paste0("C:\\Users\\rmsms\\OneDrive\\lab\\Multiscale\\",subject_dir)

last_dir = ""
# work_dir = paste0("C:\\Users\\rmsms\\OneDrive\\lab\\Multiscale\\", subject_dir, "\\", last_dir)

setwd(work_dir); getwd()


# win.graph(16,9); par(mfrow=c(3,7))
meta_data <- list()
meta_data_outbreak <- list()
thershold <- c(rep(100,21))
for(t in 1:(length(list.dirs())-1)){
  setwd(list.dirs()[t+1])
  print(getwd())
  meta_data[[t]] <- read.csv(list.files()[1])
  setwd("..")
  plot(meta_data[[t]]$V, meta_data[[t]]$R_B)
  abline(h = thershold[t], col='red')
}
# for(t in 1:(length(list.dirs())-1)){
#   setwd(list.dirs()[t+1])
#   print(getwd())
#   meta_data[[t]] <- read.csv(list.files()[1])
#   meta_data_outbreak[[t]] <- meta_data[[t]][,c(3,5)]
#   plot(table(meta_data_outbreak[[t]]$R_B > 100, meta_data_outbreak[[t]]$hub_I != 0))
#   setwd("..")
# }


parameter_range = 0:20/20

OUTBREAK <- numeric()
V <- numeric()
B <- numeric()

# win.graph(16,9); par(mfrow=c(3,7))
for(t in 1:21){
  target <- (meta_data[[t]]$R_B > thershold[t])
  
  outbreak <- sum(target)/length(meta_data[[1]]$t)
  v <- meta_data[[t]]$V[target]
  b <- meta_data[[t]]$R_B[target]
  
  OUTBREAK <- c(OUTBREAK, outbreak)
  V <- c(V, mean(v))
  B <- c(B, mean(b))
}

png(file=paste0("C:\\Users\\rmsms\\OneDrive\\lab\\Multiscale\\",subject_dir, last_dir,".png"),
    width=1600, height=700)
# win.graph(16,7); par(mfrow=c(1,2))
par(mfrow=c(1,2))
V[is.nan(V)] <- 0
B[is.nan(B)] <- 0
plot(parameter_range, B, ylim = range(V,B), col = 'red', pch = 16, main = paste0(subject_dir, last_dir))
points(parameter_range, V, col = 'blue', pch = 16)
plot(parameter_range, OUTBREAK, ylim = c(0.0,1.0), col = 'red', pch = 16, main = paste0(subject_dir, last_dir))
dev.off()


