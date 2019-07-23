#First we load the necessary libraries and initialize a graph, as follows:
import sys
import random
import math
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
#from sklearn import datasets
sess = tf.Session()


x=[]
y=[]
file = open(sys.argv[1], 'r')
for line in file:
	data = [float(d.strip()) for d in line.split(',')]
	x.append([data[0], data[1], data[2]])
	y.append(data[3])


#Now we will load the data. This time, each element of x data 
#will be a list of three values instead of one. Use the following code:
# iris = datasets.load_iris()
# x_vals = np.array([[x[1], x[2], x[3]] for x in iris.data])
# y_vals = np.array([y[0] for y in iris.data])

split = math.floor(len(x) * 0.75)

x_vals = np.array(x[:split])
y_vals = np.array(y[:split])

x_test = np.array(x[split:])
y_test = np.array(y[split:])

print("Training Set = " + str(len(x_vals)))
print("Testing Set = " + str(len(x_test)))

#Next we declare the batch size, placeholders, variables, and model output.
#The only difference here is that we change the size specifications of the 
#x data placeholder to take three values instead of one, as follows:
batch_size = math.floor(len(x_vals))
test_size = len(x_test)
learning_rate = 0.0007
x_data = tf.placeholder(shape=[None, 3], dtype=tf.float32)
y_target = tf.placeholder(shape=[None, 1], dtype=tf.float32)
A = tf.Variable(tf.random_normal(shape=[3,1]))
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
for i in range(1000):
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

    if (i+1)%250==0:
        print('Step #' + str(i+1) + '\nA = ' + 
        	str(sess.run(A)) + '\nb = ' + str(sess.run(b)))
        print('Loss = ' + str(temp_loss[0][0]))
        print('Test = ' + str(temp_test[0]))


#Give estimates
for i in range(len(x)):
    print("Trip " + str(i+1))
    print('  x = ' + str(x[i]))
    print('  y = ' + str(y[i]))
    print('  guess = ' + str(
      sess.run(model_output, feed_dict=
      {x_data: np.array([x[i]]), y_target: np.array([[y[i]]])})))

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