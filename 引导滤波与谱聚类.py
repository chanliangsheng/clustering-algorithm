import guided_filter
import sklearn

# 导入自己定义的库

guided_filter.guidedfilter()
# 用自定义的引导过滤库中的引导过滤函数来进行引导过滤，有四个参数

sc = sklearn.cluster.SpectralClustering(n_clusters=2, affinity='rgb', gamma=1, assign_labels='discretize')
# 谱聚类。n_clustering：最后要聚类的个数；affinity：全连接发来构图，并且其中使用高斯核函数；gamma：高斯核函数中的参数；assign_labels:最后所选用聚类的算法
