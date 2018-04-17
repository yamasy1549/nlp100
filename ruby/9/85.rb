require './util'

pyfrom 'scipy', import: :io
pyfrom 'sklearn.decomposition', import: :TruncatedSVD

x = io.loadmat('84')['x']
svd = TruncatedSVD.(n_components: 300)
x_svd = svd.fit_transform(x)

# 保存
io.savemat('85.mat', PyCall::Dict.({ 'x_svd': x_svd }))
