source("PLACO_v0.1.1.R")
require(devtools)
library(data.table)
args <- commandArgs(T)

file_z <- read.table( args[1] , sep = "\t" , header = T ) # P
file_p <- read.table( args[2] , sep = "\t" , header = T ) # Z

Z.matrix <- as.matrix(file_z)
P.matrix <- as.matrix(file_p)

# Step 0a: Obtain the correlation matrix of Z-scores
R <- cor.pearson(Z.matrix, P.matrix, p.threshold=1e-4)
# Step 0b: Decorrelate the matrix of Z-scores
	# function for raising matrix to any power
	"%^%" <- function(x, pow)
		with(eigen(x), vectors %*% (values^pow * t(vectors)))
Z.matrix.decor <- Z.matrix %*% (R %^% (-0.5))
colnames(Z.matrix.decor) <- paste("Z",1:2,sep="")
write.table(as.data.frame(Z.matrix.decor),file=args[3],row.names=F,col.names = T,sep="\t",quote = F)

## Steps to implementing PLACO
# Step 1: Obtain the variance parameter estimates (only once)
VarZ <- var.placo(Z.matrix.decor, P.matrix, p.threshold=1e-4)
# Step 2: Apply test of pleiotropy for each variant
p = dim(P.matrix)[1]
out <- sapply(1:p, function(i) placo(Z=Z.matrix.decor[i,], VarZ=VarZ))
# Check the output for say variant 100
#print(out)
#print(typeof(out))
#print(typeof(out[1,1]))
#print(head(t(out)))
#out[,100]$T.placo
#out[,100]$p.placo

out <-  as.data.frame(apply(out, 2, function(x) unlist(x)))
write.table(as.data.frame(t(out)),file=args[4],row.names=F,col.names = T,sep="\t",quote = F)
