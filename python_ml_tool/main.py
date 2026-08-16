import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, classification_report

def load_data(filepath):
    """Loads data from a CSV file."""
    try:
        df = pd.read_csv(filepath)
        return df
    except FileNotFoundError:
        print(f"Error: File '{filepath}' not found.")
        return None

def preprocess_data(df, target_column):
    """Preprocesses the data by splitting features and target, handling missing values, and scaling."""
    if df is None or target_column not in df.columns:
        print("Error: Invalid DataFrame or target column.")
        return None, None, None, None

    # Separate features and target
    X = df.drop(columns=[target_column])
    y = df[target_column]

    # Handle missing values by filling with mean for numerical columns
    numerical_cols = X.select_dtypes(include=[np.number]).columns
    X[numerical_cols] = X[numerical_cols].fillna(X[numerical_cols].mean())

    # One-hot encode categorical columns
    categorical_cols = X.select_dtypes(include=['object', 'category']).columns
    X = pd.get_dummies(X, columns=categorical_cols, drop_first=True)

    # Split the data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Scale the features
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    return X_train_scaled, X_test_scaled, y_train, y_test

def train_model(X_train, y_train):
    """Trains a Logistic Regression model."""
    model = LogisticRegression()
    model.fit(X_train, y_train)
    return model

def evaluate_model(model, X_test, y_test):
    """Evaluates the model and prints metrics."""
    y_pred = model.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    report = classification_report(y_test, y_pred)
    print(f"Accuracy: {accuracy}")
    print(f"Classification Report:\n{report}")

def main():
    # Example usage
    # Replace 'data.csv' with your actual dataset path
    # Ensure 'target' is a column in your dataset
    filepath = 'data.csv'
    target_column = 'target'

    df = load_data(filepath)
    X_train, X_test, y_train, y_test = preprocess_data(df, target_column)
    model = train_model(X_train, y_train)
    evaluate_model(model, X_test, y_test)

if __name__ == "__main__":
    main()
