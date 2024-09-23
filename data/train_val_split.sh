#!/bin/bash

# Paths
train_dir="train"
val_dir="val"

# Create the validation directory if it doesn't exist
mkdir -p $val_dir

# Loop through each class in the train directory
for class_dir in $train_dir/*; do
  class_name=$(basename $class_dir)
  
  # Create the corresponding class folder in the val directory
  mkdir -p "$val_dir/$class_name"
  
  # Find all files in the class directory and randomly select 10% of them
  num_files=$(find "$class_dir" -type f | wc -l)
  num_val_files=$((num_files / 10))

  # Move 10% of the files from the train to the val directory
  find "$class_dir" -type f | shuf -n $num_val_files | while read file; do
    mv "$file" "$val_dir/$class_name"
  done
  
  echo "Moved $num_val_files files from $class_name to validation set"
done

echo "Train-test split completed."
