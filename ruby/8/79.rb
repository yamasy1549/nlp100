require './util'
require './train'

# MacOSX backend is not usable through pycall...
pyimport 'matplotlib', as: :mp
pyimport 'numpy', as: :np
mp.rcParams[:backend] = 'TkAgg' if mp.rcParams[:backend] == 'MacOSX'

pyimport 'matplotlib.mlab', as: 'mlab'
pyimport 'matplotlib.pyplot', as: 'plt'

pyfrom 'sklearn.metrics', import: :precision_recall_curve

x_train, x_test, y_train, y_test = train_test_data(test_size: 0.2)
model = logreg(x_train, y_train)

y_test_class = y_test.map(&:to_i)
x_test_pred = model.predict_proba(x_test).tolist.to_a.map { |array| array[0] }
precision, recall, threshold = *precision_recall_curve(y_test_class, x_test_pred)

plt.step(recall, precision, where: 'post')
plt.xlabel('Recall')
plt.ylabel('Precision')
plt.show()
