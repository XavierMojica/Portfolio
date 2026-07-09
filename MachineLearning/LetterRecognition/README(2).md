# Transfer Learning: MNIST CNN to Handwritten A–E Classifier

![Python](https://img.shields.io/badge/Python-3.10%2B-blue)
![TensorFlow](https://img.shields.io/badge/TensorFlow-Keras-yellow)
![OpenCV](https://img.shields.io/badge/OpenCV-Image%20Processing-limegreen)
![Scikit--learn](https://img.shields.io/badge/Scikit--learn-Evaluation-orange)

## Project Overview

This project demonstrates how transfer learning can adapt a convolutional neural network trained on the MNIST digit dataset into a custom handwritten letter classifier for the letters **A, B, C, D, and E**.

The workflow combines computer vision preprocessing, data augmentation, convolutional neural networks, transfer learning, fine-tuning, and model evaluation. It is designed as a practical machine learning portfolio project showing how a model can be adapted from a larger source dataset to a much smaller custom dataset.

## Business and Technical Problem

Handwritten character recognition is a common computer vision task used in document processing, form digitization, education technology, postal automation, and identity verification workflows. In real-world machine learning projects, labeled custom data is often limited. This project addresses that challenge by:

- Training a CNN on the larger MNIST dataset.
- Reusing the learned visual feature extractor.
- Creating an augmented dataset from a small set of custom handwritten samples.
- Fine-tuning the model to classify five custom letter classes.

## Skills Demonstrated

- Image preprocessing with OpenCV
- Thresholding, cropping, centering, padding, and resizing images
- Data augmentation for small datasets
- CNN development with TensorFlow/Keras
- Transfer learning and feature extraction
- Fine-tuning pretrained layers
- Train/validation/test splitting with stratification
- Model evaluation with confusion matrices and classification reports
- Class-wise accuracy tracking across epochs
- Visualization of prediction confidence and learning curves

## Tech Stack

| Category | Tools |
|---|---|
| Programming | Python |
| Deep Learning | TensorFlow, Keras |
| Computer Vision | OpenCV |
| Data Handling | NumPy, pandas |
| Model Evaluation | scikit-learn |
| Visualization | Matplotlib |
| Notebook Environment | Google Colab / Jupyter Notebook |

## Dataset

This project uses two sources of image data:

1. **MNIST handwritten digits**  
   Used to train the base CNN model and learn general handwritten stroke features.

2. **Custom handwritten letter images**  
   Five uploaded images representing the classes:

| File | Label |
|---|---|
| `IMG_0154.jpg` | A |
| `IMG_0155.jpg` | B |
| `IMG_0156.jpg` | C |
| `IMG_0157.jpg` | D |
| `IMG_0158.jpg` | E |

Because the custom letter dataset is very small, the project uses image augmentation to create additional training examples.

## Methodology

### 1. Image Preprocessing

Each custom handwritten image is converted into an MNIST-like format:

- Convert image to grayscale.
- Apply median blur to reduce small image noise.
- Use Otsu thresholding to isolate the handwritten stroke.
- Convert dark handwriting into a white foreground on a black background.
- Crop around the handwritten ink.
- Pad the image into a square shape to avoid distortion.
- Resize the image to `28x28`.
- Normalize pixel values to the range `[0, 1]`.

This preprocessing step makes the custom letter images compatible with the MNIST-trained CNN.

### 2. Base CNN Training on MNIST

A convolutional neural network is trained on MNIST digits using:

- Convolutional layers for feature extraction
- Max pooling for spatial compression
- Dense layers for learned representation
- Dropout for regularization
- Softmax output for digit classification

The trained dense feature layer is later reused as the feature extractor for the custom letter classifier.

### 3. Data Augmentation

Since the custom dataset is small, the project uses augmentation to create more variation:

- Rotation
- Width shifting
- Height shifting
- Zooming
- Shearing

This helps the model learn a more flexible representation of each letter class.

### 4. Transfer Learning

The MNIST model's learned feature layer is reused as a fixed feature extractor. A new classification head is added for the five custom classes:

```text
MNIST CNN Feature Extractor -> Dropout -> Dense Layer -> 5-Class Softmax Output
```

The output classes are:

```text
A, B, C, D, E
```

### 5. Fine-Tuning

After training the new classification head, the model is lightly fine-tuned with a smaller learning rate. Early layers are kept frozen while later layers are adjusted to better fit the A–E classification task.

### 6. Evaluation

The model is evaluated using:

- Validation accuracy
- Test accuracy
- Class-wise accuracy per letter
- Confusion matrix
- Classification report
- Prediction confidence table
- Final visual prediction output for the original A–E images

## Results to Report

After running the notebook, update this section with your actual model output.

| Metric | Result |
|---|---|
| MNIST Test Accuracy | `99.17%` |
| A–E Validation Accuracy on Augmented Images | `96.81%` |
| Correct Original A–E Predictions | `100%` |

Example final prediction table generated by the notebook:

| File | Expected Letter | Predicted Letter | Confidence | Correct? |
|---|---|---|---|---|
| `IMG_0154.jpg` | A | A | 91.86% Confidence | Yes |
| `IMG_0155.jpg` | B | B | 99.99% Confidence | Yes |
| `IMG_0156.jpg` | C | C | 65.31% Confidence | Yes |
| `IMG_0157.jpg` | D | D | 100% Confidence | Yes |
| `IMG_0158.jpg` | E | E | 85.71% Confidence | Yes |

## Visual Outputs

The notebook generates several visualizations:

- Preprocessed 28x28 letter images
- Original images with predicted labels and confidence scores
- Confusion matrix for A–E predictions
- Separate validation and test accuracy curves for each letter
- Transfer-head and fine-tuning performance plots

## Repository Structure

```text
.
├── README.md
├── handwritten_letters_transfer_learning.ipynb
├── images/
│   ├── IMG_0154.jpg
│   ├── IMG_0155.jpg
│   ├── IMG_0156.jpg
│   ├── IMG_0157.jpg
│   └── IMG_0158.jpg
└── requirements.txt
```

## Installation

Create a virtual environment and install the required packages:

```bash
pip install tensorflow opencv-python matplotlib scikit-learn pandas numpy
```

Or create a `requirements.txt` file:

```text
tensorflow
opencv-python
matplotlib
scikit-learn
pandas
numpy
```

Then install with:

```bash
pip install -r requirements.txt
```

## How to Run

1. Clone the repository.

```bash
git clone <your-repo-url>
cd <your-repo-name>
```

2. Add the five handwritten letter images to the project.

```text
images/IMG_0154.jpg
images/IMG_0155.jpg
images/IMG_0156.jpg
images/IMG_0157.jpg
images/IMG_0158.jpg
```

3. Update the image paths in the notebook if needed.

4. Run the notebook cells in order:

```text
Step 1: Attach handwritten letters
Step 2: Preprocess images
Step 3: Train base MNIST CNN
Step 4: Build augmented A–E dataset
Step 5: Train transfer learning model
Step 6: Fine-tune model
Step 7: Evaluate predictions
Step 8: Plot class-wise learning curves
```

## Key Portfolio Takeaways

This project highlights the ability to build an end-to-end machine learning workflow from raw image files to final model evaluation. It is especially useful for demonstrating:

- Practical transfer learning
- Computer vision preprocessing
- Model adaptation with limited labeled data
- Debugging and improving neural network workflows
- Communicating machine learning results visually and clearly

## Limitations

This project uses only one original handwritten image per letter, thus five letters in total. Although augmentation improves training stability, the model may not generalize well to handwriting styles that differ significantly from the original examples provided for this tutorial.

## Future Improvements

Potential next steps include:

- Collecting more real handwritten samples per letter.
- Expanding the classifier to all 26 alphabet letters.
- Comparing CNN performance against a pretrained image model.
- Saving the trained model as a `.keras` or `.h5` file.
- Building a small Streamlit or Gradio demo for live image upload and prediction.
- Adding experiment tracking with MLflow.
- Deploying the classifier as a lightweight API.

## Author

**Xavier Mojica**  
Data Scientist / Machine Learning

This project was developed as part of a machine learning transfer learning project and refined for a portfolio presentation.
