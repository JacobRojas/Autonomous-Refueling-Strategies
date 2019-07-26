#First we load the necessary libraries and initialize a graph, as follows:
import sys
import random
import math
import matplotlib.pyplot as plt
import numpy as np

#sys.stderr = open('errors', 'w')

import tensorflow as tf
#from sklearn import datasets
sess = tf.Session()

x=[]
y=[]
file = open(sys.argv[1], 'r')
for line in file:
	data = [float(d.strip()) for d in line.split(',')]
	x.append(data[0:-1])
	y.append(data[-1])


#Shuffle Data
index = list(range(len(x)))
random.shuffle(index)
index = np.array(index)
x = np.array(x)
y = np.array(y)
x = x[index]
y = y[index]

#Now we will load the data. This time, each element of x data 
#will be a list of three values instead of one. Use the following code:
# iris = datasets.load_iris()
# x_vals = np.array([[x[1], x[2], x[3]] for x in iris.data])
# y_vals = np.array([y[0] for y in iris.data])

split = math.floor(len(x) * 0.75)

x_vals = x[:split]
y_vals = y[:split]

x_test = x[split:]
y_test = y[split:]

dim = len(x_vals[0])

print("Training Set = " + str(len(x_vals)))
print("Testing Set = " + str(len(x_test)))

#Next we declare the batch size, placeholders, variables, and model output.
#The only difference here is that we change the size specifications of the 
#x data placeholder to take three values instead of one, as follows:
batch_size = math.floor(len(x_vals) * 1)
test_size = len(x_test)
learning_rate = 0.00055
x_data = tf.placeholder(shape=[None, dim], dtype=tf.float32)
y_target = tf.placeholder(shape=[None, 1], dtype=tf.float32)
A = tf.Variable(tf.random_normal(shape=[dim,1]))
b = tf.Variable(tf.random_normal(shape=[1,1]))
model_output = tf.add(tf.matmul(x_data, A), b)

#For elastic net, the loss function has the L1 and L2 norms of the partial slopes.
#We create these terms and then add them into the loss function, as follows:
elastic_param1 = tf.constant(1.)
elastic_param2 = tf.constant(1.)
l1_a_loss = tf.reduce_mean(tf.abs(A))
l2_a_loss = tf.reduce_mean(tf.square(A))
e1_term = tf.multiply(elastic_param1, l1_a_loss)
e2_term = tf.multiply(elastic_param2, l2_a_loss)
loss = tf.expand_dims(tf.add(tf.add(tf.reduce_mean(tf.square(y_target - model_output)), e1_term), e2_term), 0)

#Now we can initialize the variables, declare our optimizer,
#and run the training loop and fit our coefficients, as follows:
init = tf.global_variables_initializer()
sess.run(init)
my_opt = tf.train.GradientDescentOptimizer(learning_rate)
train_step = my_opt.minimize(loss)
loss_vec = []
test_loss = []
for i in range(4000):
    #rand_index = np.random.choice(len(x_vals), size=batch_size)
    index = list(range(len(x_vals)))
    random.shuffle(index)
    rand_index = np.array(index[:batch_size])
    rand_x = x_vals[rand_index]
    rand_y = np.transpose([y_vals[rand_index]])
    #sess.run(train_step, feed_dict={x_data: rand_x, y_target: rand_y})
    temp_loss = sess.run([loss, train_step], feed_dict={x_data: rand_x, y_target: rand_y})
    loss_vec.append(temp_loss[0][0])

    #rand_index = np.random.choice(len(x_vals), size=batch_size)
    index = list(range(len(x_test)))
    random.shuffle(index)
    rand_index = np.array(index[:test_size])
    rand_x = x_test[rand_index]
    rand_y = np.transpose([y_test[rand_index]])
    #sess.run(train_step, feed_dict={x_data: rand_x, y_target: rand_y})
    temp_test = sess.run(loss, feed_dict={x_data: rand_x, y_target: rand_y})
    test_loss.append(temp_test[0])

print('\nA = ' + 
	str(sess.run(A)) + '\nb = ' + str(sess.run(b)))
print('Loss = ' + str(temp_loss[0][0]))
print('Test = ' + str(temp_test[0]))


#Give estimates
error = 0
for i in range(len(x_test), len(x)):
    results = sess.run([model_output, loss], feed_dict= {x_data: np.array([x[i]]), y_target: np.array([[y[i]]])})
    # print("Trip " + str(i+1))
    # print('  x = ' + str(x[i]))
    # print('  y = ' + str(y[i]))
    # print('  guess = ' + str(results[0][0][0]))
    # print('  loss = ' + str(results[1][0]))
    error += ((results[0][0][0] - y[i]))**2
print('\nError = ' + str(error / (len(x) - len(x_test))))

#Save the model
#saver = tf.train.Saver()
#saver.save(sess, '/Users/kameroncarr/Documents/GitHub/TxSt2019/model.ckpt')

#Now we can observe the loss over the training 
#iterations to be sure that it converged, as follows:
plt.plot(loss_vec, 'k-')
plt.plot(test_loss, 'k--')
plt.title('Loss vs. Generation')
plt.xlabel('Generation')
plt.ylabel('Loss')
#plt.yscale("log")
plt.show()