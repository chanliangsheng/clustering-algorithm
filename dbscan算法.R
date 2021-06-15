judge_code <- function(a)
  #定义函数用于判断是否为样本点，输入a为数据框的行号
{
  k <- (data - c(data[a,]))^2
  o <- rowSums(k)
  #求欧式距离，实际的值是欧式距离的平方
  o <- o<(r^2)
  #判断有哪些样本点落入定义的半径中
  l <- length(which(o==TRUE))
  #计算有多少个样本点落入半径中
  p <- which(o==TRUE)
  #将这些样本点的行号记录在p中
  return(c(l>minPTs,p))
  #返回l>minPTs和p，l>minPTs返回为true或者false，来判断落入半径里面的数据点的个数是否比设定的最小个数小
  #p是与a的欧式距离小于定义的半径的那些样本点的行号
  
}
#这个函数是用来判断输入的点是不是核心点




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

long <- length(data[,1])
#计算data一共有多少行（计算有多少个样本点）

num_data <- c(1:long)
#产生了一组数，每一个数对应每一个样本点

count <- c(1:long)

cluster_num <- 0

cluster_result <- matrix(0,nrow=long,ncol=long)
#生成一个4417*4417的矩阵,用来存储不同的类

for (i in 1:long) {
  #browser()
  #代码调试
  if (length(num_data)==0) {
    break
  }
  if (length(num_data)==1) {
    random_num <- num_data
  }
  if (length(num_data)>1) {
    random_num <- sample(num_data,1)
  }
  #随机选一个样本点
  q <- judge_code(random_num)
  #判断这个随机点是否为核心点，返回值放入q中
  if (!q[1]) {
    num_data <- setdiff(num_data,random_num)
    #如果这个随机点不是核心点，将它从生成随机点的数据集中去除
  }
  if (q[1])
    #如果这个点是核心点，进行下列操作
  {
    cluster_1_A <- c(random_num,q[-1])
    #将这个随机数（核心点）和属于这个类的点放在一起，q[-1]是属于这个类的返回值
    cluster_1_B <- cluster_1_A
    cluster_1_B <- cluster_1_B[-1]
    #去除这个类的第一个数（就是生成的随机数），方便后面计算
    count[(random_num)] <- 0
    #去除已经计算过的样本点
    for (j in 1:long) {
      
      if (j > length(cluster_1_B)) 
        #如果j超过了样本点的大小，说明这个类所有点都已经被计算过了
      {
        break
        print("fuck you")
      }
      q <- judge_code(cluster_1_B[j])
      #判断第一类的其他样本点是不是核心点
      if (count[cluster_1_B[j]]!=0) {
        #如果这个点没有被标记过（没有被算过）
        if (q[1]) {
          #如果这个点是核心点
          cluster_1_A <- c(cluster_1_A,q[-1])
          #将这个类和这个核心点算出来的其他点合在一起
          cluster_1_B <- cluster_1_A
          cluster_1_B <- cluster_1_B[!duplicated(cluster_1_B)]
          #去除重复的行号，只会去除后面部分重复的行号！
          cluster_1_A <- cluster_1_B
          count[cluster_1_B[j]] <- 0
          #去除已经计算过的第j行（标记这一行已经被处理过了）
        }
        
      }
    }
    num_data <- setdiff(num_data,cluster_1_A)
    #去除已经聚成一类的数据
    cluster_num <- cluster_num + 1
    #类的数目增加1
    cluster_result[,cluster_num] <- t(c(cluster_1_A,
                                        rep(0,length(cluster_result[,1])-
                                              length(cluster_1_A))))
    #将分好的一类放入一列中
  }
}
print(paste0("The clustering number is ",cluster_num))
