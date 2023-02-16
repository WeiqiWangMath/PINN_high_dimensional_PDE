# -*- coding: utf-8 -*-
"""
Solve High dimensional periodic diffusion equation using PINN

Example 2: 
    exact solution: $\Psi_{exact}(x) = \exp (\sin{2\pi x_1}+ \sin{2\pi x_2})$
    
List of arguments:
    #1 : input_dim - number of dimensions of the problem
    #2 : N - number of sampling
    #3 : \nu - parameter \nu
    #4 : epochs - number of epochs
    #5 : M_error - number of sampling when measure error
    #6 : file_name - name of the output file
    #7 : N_runs - the number of runs
        
Output:
    PDE_loss1: loss function of the PDE vs. epoch
    N_loss1: loss function of the neural network vs. epoch
    error_epoch: error vs. epoch, the error is measured every 100 epoches
"""

import sys
import numpy as np
import tensorflow as tf
from keras import backend as K

print(sys.argv)

physical_devices = tf.config.list_physical_devices('GPU')
print("Num GPUs:", len(physical_devices))

class BiasLayer(tf.keras.layers.Layer):
    def __init__(self, *args, **kwargs):
        super(BiasLayer, self).__init__(*args, **kwargs)

    def build(self, input_shape):
        print(input_shape)
        self.bias = self.add_weight('bias',
                                    shape=input_shape[1:],
                                    initializer='glorot',
                                    trainable=True)
    def call(self, x):
        return x + self.bias

class ConstantTensorInitializer(tf.keras.initializers.Initializer):
  """Initializes tensors to `t`."""

  def __init__(self, t):
    self.t = t

  def __call__(self, shape, dtype=None):
    return self.t

  def get_config(self):
    return {'t': self.t}

class ConstantTensorConstraint(tf.keras.constraints.Constraint):
  """Constrains tensors to `t`."""

  def __init__(self, t):
    self.t = t

  def __call__(self, w):
    return self.t

  def get_config(self):
    return {'t': self.t}

# all you need to create a mask matrix M, which is a NxN identity matrix
# and you can write a contraint like below
class DiagonalWeight(tf.keras.constraints.Constraint):
    """Constrains the weights to be diagonal.
    """
    def __call__(self, w):
        N = K.int_shape(w)[-1]
        m = K.eye(N)
        v = w*m
        return v


# Neural Network for periodic problem

def init_model(nb_hidden_layers, nb_nodes_per_layer, m_periodic, n_periodic, omega, input_dim):

    # Append hidden layers
    all_layers = []

    # Initialize a feedforward neural network
    model = tf.keras.Sequential()

    # Input is two-dimensional (time + one spatial dimension)
    input_model = tf.keras.layers.InputLayer(input_shape= (input_dim,), name='input_model')
    model.add(input_model)

    # Construct first omega matrix
    omega_each_dim = omega*np.ones((input_dim,1))
    Omega_matrix = np.array([])

    for dim in range(input_dim):
        Omega_dim = np.zeros((m_periodic, input_dim))
        Omega_dim[:,dim] = omega_each_dim[dim,0]*np.ones((m_periodic,))
        Omega_matrix = np.vstack([Omega_matrix,Omega_dim]) if Omega_matrix.size else Omega_dim

    Omega = tf.Variable(Omega_matrix.T,dtype=tf.float32)

    # Create first C^inf periodic layers L_p(m,n)
    first_periodic_layer = tf.keras.layers.Dense(m_periodic*input_dim,
                                                 activation = tf.math.cos,
                                                 use_bias = True,
                                                 trainable = True,
                                                 name = 'first_periodic_layer',
                                                 kernel_initializer = ConstantTensorInitializer(Omega),
                                                 kernel_constraint = ConstantTensorConstraint(Omega),
                                                 bias_initializer = 'glorot_normal')
    all_layers.append(first_periodic_layer)
    model.add(first_periodic_layer)

    second_periodic_layer = tf.keras.layers.Dense(m_periodic*input_dim,
                                                  activation = 'tanh',
                                                  use_bias = True,
                                                  trainable = True,
                                                  name = 'second_periodic_layer',
                                                  kernel_constraint = DiagonalWeight(),
                                                  kernel_initializer = 'glorot_normal',
                                                  bias_initializer = 'glorot_normal')
    all_layers.append(second_periodic_layer)
    model.add(second_periodic_layer)

    # create the rest of the network (substitute other code here also)
    for layer in range(nb_hidden_layers):
        if layer == nb_hidden_layers-1:
            layer_name = 'first_to_last_hidden_layer'
        else:
            layer_name = 'hidden_layer_' + str(layer)

        hidden_layer = tf.keras.layers.Dense(nb_nodes_per_layer, 
                                        activation='tanh',
                                        name=layer_name,
                                        kernel_initializer= 'glorot_normal')
                                        #bias_initializer= weight_bias_initializer,
                                        #dtype=tf.float32)
        all_layers.append(hidden_layer)
        model.add(hidden_layer)

    # Output is one-dimensional
    model.add(tf.keras.layers.Dense(1))
    
    return model

nb_hidden_layers = 3
nb_nodes_per_layer = 30

input_dim = int(sys.argv[1])
m_periodic = 11
n_periodic = 30

L_period = 1.0 #2*np.pi
omega = 2*np.pi/L_period
# Initialize model aka u_\theta
model5 = init_model(nb_hidden_layers, nb_nodes_per_layer, m_periodic, n_periodic, omega, input_dim)
print(model5.summary())

# Samping

a = 0
b = 1
N = int(sys.argv[2])

nu = float(sys.argv[3])
M_error = int(sys.argv[5])

# Monte Carlo points in the domain

input_data_MC = np.random.uniform(0 ,1, (N,input_dim))

# Define the diffusion function and its derivatives here

def diffusion_fcns(x):
    diffusion = 1 + 1/4 * np.sin(2*np.pi*x[:, 0]) * np.sin(2*np.pi*x[:, 1])
    L,x_dim = np.shape(x)
    grad_diffusion = [np.zeros_like(x[:, 0])] * x_dim
    grad_diffusion[0] = np.pi/2 * np.cos(2*np.pi*x[:, 0]) * np.sin(2*np.pi*x[:, 1])
    grad_diffusion[1] = np.pi/2 * np.sin(2*np.pi*x[:, 0]) * np.cos(2*np.pi*x[:, 1])
    return diffusion, grad_diffusion


# Define the exact solution
def exact_solu(x):
    y = np.exp(np.sin(2*np.pi*np.double(x[:, 0])) + np.sin(2*np.pi*np.double(x[:, 1])))
    return y

# Compute the gradient and divergence of the exact solution numerically
def exact_grad_div(x):
    L,x_dim = np.shape(x)
    dx = np.double(0.003)
    gradient = [np.zeros_like(x[:, 0])] * x_dim
    divergence = np.zeros_like(x[:, 0])
    
    for i in range(x_dim):
        dx_i = np.zeros_like(x);
        dx_i[:, i] = 1;
        
            
        # six-order finite difference
        gradient[i] = (-1/60 * exact_solu(x - 3*dx*dx_i) + 3/20 * exact_solu(x - 2*dx*dx_i) - 3/4 * exact_solu(x - dx*dx_i) + 3/4 * exact_solu(x + dx*dx_i) - 3/20 * exact_solu(x + 2*dx*dx_i) + 1/60 * exact_solu(x + 3*dx*dx_i)) / dx
        divergence = divergence + ((1/90) * exact_solu(x - 3*dx*dx_i) -(3/20) * exact_solu(x - 2*dx*dx_i) + (3/2) * exact_solu(x - dx*dx_i) - (49/18) * exact_solu(x) + (3/2) * exact_solu(x + dx*dx_i) - (3/20) * exact_solu(x + 2*dx*dx_i) +(1/90) * exact_solu(x + 3*dx*dx_i)) / dx**2
    
    return gradient, divergence


# Training function

def trainStep_N_dimension(x, diffusion_x, grad_diffusion_x, exact_x, exact_grad_x, exact_div_x, opt, model):
    
    L,x_dim = np.shape(x)
    
    # Outer gradient for model parameters
    with tf.GradientTape() as tape:
        
        # Inner gradient for first derivative of N wrt x
        with tf.GradientTape(persistent=True) as tape1:
            tape1.watch(x)
            
            # Inner inner gradient for fi derivative of N wrt x
            with tf.GradientTape(persistent=True) as tape2:
                tape2.watch(x)
            
                N = model(x)
            
            # Gradient of the NN
            grad_N = tape2.gradient(N, x)
            grad_N_i = []
            for i in range(x_dim):
                grad_N_i.append(grad_N[: ,i])
        # Divergence of the NN
        div_N = tf.zeros([L])
        for i in range(x_dim):
            div_N = div_N + tape1.gradient(grad_N_i[i], x)[:, i]
        
            
        
        N = tf.reshape(N, [L])
        
        grad_error = [np.zeros_like(x[:, 0])] * x_dim
        
        # Plug trial solution into ODE:
        divergence_error = div_N - exact_div_x
        N_error = N - exact_x
        
       
        eqn = - diffusion_x *  divergence_error  + nu * N_error 
        for i in range(x_dim):
            grad_error[i] = grad_N[:, i] - exact_grad_x[i]
            eqn = eqn - grad_diffusion_x[i] * grad_error[i]
        
        loss = tf.reduce_sum(tf.square(eqn)) 
        N_loss = tf.reduce_sum(tf.square(N_error))
        gradient_loss = tf.square(grad_error[x_dim-1])
        for i in range(x_dim-1):
            gradient_loss = gradient_loss + tf.square(grad_error[i])
        gradient_loss = tf.reduce_sum(gradient_loss)
        divergence_loss = tf.reduce_sum(tf.square(divergence_error))
        
    # Compute the gradient of loss wrt model parameters
    grads = tape.gradient(loss, model.trainable_variables)
    
    # Gradient step
    opt.apply_gradients(zip(grads, model.trainable_variables))
    
    
    return loss, N_loss, gradient_loss, divergence_loss


def PINNtrain(x, epochs, model):
    
    # optional, use a stopping tolerance (i.e., if loss < 1e-7 then stop training early)
    stop_tol = 1e-12
    
    # set the initial best loss seen so far to something large
    best_loss = 1e12
    best_loss_epoch = -1
    best_weights = None
    
    # Define an optimizer
    lr = tf.keras.optimizers.schedules.PolynomialDecay(0.1, epochs, 1e-4)
    opt = tf.keras.optimizers.Adam()
    epoch_loss, N_loss, gradient_loss, divergence_loss, error_epoch = (np.zeros(epochs) for i in range(5))
    
    # Calculate diffusion function, forcing term at sample points x in double precision
    diffusion_x, grad_diffusion_x = diffusion_fcns(np.double(x.numpy()))
    exact_x = exact_solu(np.double(x.numpy()))
    exact_grad_x, exact_div_x = exact_grad_div(np.double(x.numpy()))
    
    # Sample points to test error
    test_data_MC = np.random.uniform(0 ,1, (M_error ,input_dim))
    
    # Main training loop
    for i in range(epochs):
        
        epoch_loss[i], N_loss[i], gradient_loss[i], divergence_loss[i]  = trainStep_N_dimension(x, diffusion_x, grad_diffusion_x, exact_x, exact_grad_x, exact_div_x, opt, model)
        
        if (np.mod(i, 100)==0):
          z_model = model(test_data_MC)
          z_model = tf.reshape(z_model, [M_error])
          z_exact = exact_solu(test_data_MC)
          error_epoch[i] = np.sqrt(sum(np.square(z_model - z_exact)))/np.sqrt(sum(np.square(z_exact)))
          print("PDE loss in {}th epoch: {: 1.6e}. Last save epoch and best loss so far: {}, {: 1.6e}. Current error {: 1.6e}".format(i, epoch_loss[i], best_loss_epoch, best_loss, error_epoch[i]))
    
        if (epoch_loss[i] < best_loss):
            best_weights = model.get_weights()
            best_loss_epoch = i
            best_loss = epoch_loss[i]
            #print("Found a new best local minimum at epoch {}: loss {: 1.6e}. Saving weights.".format(i, epoch_loss[i]))
            
        if (epoch_loss[i] < stop_tol):
            print("Current model has loss {: 1.6e}, lower than stopping tolerance {: 1.6e}, stopping early at epoch {}.".format(epoch_loss[i],stop_tol,i))
            return epoch_loss, N_loss, gradient_loss, divergence_loss
    
    if (best_loss < epoch_loss[i]):
        model.set_weights(best_weights)
        print("Current loss {: 1.6e}, Best loss {: 1.6e}. Restoring best model weights.".format(epoch_loss[i],best_loss))
    else:
        print("Current loss {: 1.6e}, Best loss {: 1.6e}. Keeping current model weights.".format(epoch_loss[i],best_loss))
        
    return epoch_loss, N_loss, gradient_loss, divergence_loss, error_epoch

# train NN for Monte Carlo sample
epochs = int(sys.argv[4])
PDE_loss1, N_loss1, gradient_loss1, divergence_loss1, error_epoch = PINNtrain(tf.convert_to_tensor(input_data_MC, dtype = float), epochs, model5)



file_name = sys.argv[6]
N_runs = int(sys.argv[7])
np.savetxt(file_name + 'Run' +str(N_runs)+ '.out', (PDE_loss1, N_loss1, error_epoch))