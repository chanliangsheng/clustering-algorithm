# 可参考 1.https://www.bilibili.com/video/BV1kt411X7Zh?p=3&spm_id_from=pageDriver
# 2.https://blog.csdn.net/SL_World/article/details/104423536?utm_source=app&app_version=4.10.0&code=app_1562916241&uLinkId=usr1mkqgl919blen
# 3.https://www.cnblogs.com/pinard/p/6235920.html
import sklearn

sc = sklearn.cluster.SpectralClustering(n_clusters=2, affinity='rgb', gamma=1, assign_labels='discretize')
# 谱聚类。n_clustering：最后要聚类的个数；affinity：全连接发来构图，并且其中使用高斯核函数；gamma：高斯核函数中的参数；assign_labels:最后所选用聚类的算法
