setwd("D:\\研究生学习\\mission\\To_Chen")
#设置工作目录

r <- 1.5
#设置样本点的半径

minPTs <- 6
#设置核心最小样本点数（即1个样本点半径内的样本点数大于4个才算是核心样本点）

data <- read.table(file = list.files()[4],header = FALSE)
#读取本地的某个txt文件
judge <- (data[,3]==0)
data <- data[judge,]
#选择区域0的数据
data <- data[,c(4,5,2)]
#选择（x,y,z）
names(data) <- c("x","y","value")
#改变列名
data[1] <- data[1] - min(data[1])
data[2] <- data[2] - min(data[2])
#把x，y移动到靠（0，0）的地方

result <- dbscan::dbscan(data,1.5,6)
#使用dbscan聚类，设定半径为1.5，半径内最小点数为6

cluster_result <- result["cluster"]
#将聚类结果拿出来

cluster_result <- as.vector(unlist(cluster_result[1]))
#将聚类结果格式变成向量