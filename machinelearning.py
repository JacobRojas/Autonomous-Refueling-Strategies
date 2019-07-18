#First we load the necessary libraries and initialize a graph, as follows:
import sys
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
x_vals = np.array(x)
y_vals = np.array(y)

print(x_vals)
print(y_vals)

#Next we declare the batch size, placeholders, variables, and model output.
#The only difference here is that we change the size specifications of the 
#x data placeholder to take three values instead of one, as follows:
batch_size = 25
learning_rate = 0.0000001
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
for i in range(100):
    rand_index = np.random.choice(len(x_vals), size=batch_size)
    rand_x = x_vals[rand_index]
    rand_y = np.transpose([y_vals[rand_index]])
    sess.run(train_step, feed_dict={x_data: rand_x, y_target: rand_y})
    temp_loss = sess.run(loss, feed_dict={x_data: rand_x, y_target: rand_y})
    loss_vec.append(temp_loss[0])
    if (i+1)%250==0:
        print('Step #' + str(i+1) + ' A = ' + 
        	str(sess.run(A)) + ' b = ' + str(sess.run(b)))
        print('Loss = ' + str(temp_loss))

#Now we can observe the loss over the training 
#iterations to be sure that it converged, as follows:
plt.plot(loss_vec, 'k-')
plt.title('Loss vs. Generation')
plt.xlabel('Generation')
plt.ylabel('Loss')
plt.show()