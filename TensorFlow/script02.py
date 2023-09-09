import numpy as np

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

class SimpleAnimalClassifier:
    def __init__(self):
        self.weights = np.random.rand(3, 1)
        self.bias = np.random.rand(1, 1)

    def forward(self, inputs):
        return sigmoid(np.dot(inputs, self.weights) + self.bias)

    def train(self, inputs, labels, epochs=10000, learning_rate=0.1):
        for epoch in range(epochs):
            predictions = self.forward(inputs)
            error = labels - predictions
            self.weights += learning_rate * np.dot(inputs.T, error)
            self.bias += learning_rate * np.sum(error)

# Training data
inputs = np.array([[2, 0, 1], [4, 1, 0]])
labels = np.array([[0], [1]])

# Initialize and train the classifier
classifier = SimpleAnimalClassifier()
classifier.train(inputs, labels)

# Predictions
bird_prediction = classifier.forward(np.array([2, 0, 1]))
print(f'Prediction for Bird (should be close to 0): {bird_prediction}')
mammal_prediction = classifier.forward(np.array([4, 1, 0]))
print(f'Prediction for Mammal (should be close to 1): {mammal_prediction}')
