import numpy as np
import matplotlib.pyplot as plt

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def sigmoid_derivative(x):
    return x * (1 - x)

class NeuralNetwork:
    def __init__(self, input_size, hidden_size, output_size):
        # Initialize weights and biases
        self.weights_input_hidden = np.random.rand(input_size, hidden_size)
        self.weights_hidden_output = np.random.rand(hidden_size, output_size)
        self.bias_hidden = np.zeros((1, hidden_size))
        self.bias_output = np.zeros((1, output_size))
        self.losses = [] # List to store loss values

    def forward(self, inputs):
        # Feed forward through the network
        self.hidden_layer_input = np.dot(inputs, self.weights_input_hidden) + self.bias_hidden
        self.hidden_layer_output = sigmoid(self.hidden_layer_input)
        self.output_layer_input = np.dot(self.hidden_layer_output, self.weights_hidden_output) + self.bias_output
        self.output = sigmoid(self.output_layer_input)
        return self.output

    def backward(self, inputs, expected_output, learning_rate=0.1):
        # Compute the error
        output_error = expected_output - self.output
        output_delta = output_error * sigmoid_derivative(self.output)

        # Compute error for the hidden layer
        hidden_layer_error = output_delta.dot(self.weights_hidden_output.T)
        hidden_layer_delta = hidden_layer_error * sigmoid_derivative(self.hidden_layer_output)

        # Update the weights
        self.weights_hidden_output += self.hidden_layer_output.T.dot(output_delta) * learning_rate
        self.bias_output += np.sum(output_delta, axis=0, keepdims=True) * learning_rate
        self.weights_input_hidden += inputs.T.dot(hidden_layer_delta) * learning_rate
        self.bias_hidden += np.sum(hidden_layer_delta, axis=0, keepdims=True) * learning_rate

    def train(self, inputs, expected_output, epochs, learning_rate=0.1):
        for _ in range(epochs):
            self.forward(inputs)
            self.backward(inputs, expected_output, learning_rate)
            loss = np.mean(np.square(expected_output - self.output)) # Mean Squared Error
            self.losses.append(loss)

# Training data
inputs = np.array([[0, 0, 1], [1, 1, 1], [1, 0, 1], [0, 1, 1]])
expected_output = np.array([[0], [1], [1], [0]])

# Initialize the Neural Network
nn = NeuralNetwork(input_size=3, hidden_size=4, output_size=1)

# Train the network
nn.train(inputs, expected_output, epochs=10000)

# Plot loss
plt.plot(nn.losses)
plt.xlabel('Epoch')
plt.ylabel('Loss')
plt.title('Loss Over Time')
plt.show()

# Make predictions
prediction = nn.forward(np.array([1, 0, 0]))
print("Prediction for [1, 0, 0]:", prediction) # Output should be close to 1
