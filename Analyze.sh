User
#!/bin/bash

# Read a line from the input adapter file.
read adapter < "$1"

# Print the input file name.
echo "File name is $2"

# Calculate the total number of lines in the input FASTQ file.
line_count=$(wc -l < "$2")

# Calculate the total number of reads using the value stored in the line_count variable.
read_count=$((line_count / 4))

# Print the total number of reads.
echo "Total number of reads: $read_count"

# Print the input adapter sequence.
echo "Adapter sequence: $adapter"

# Calculate the total number of reads containing the adapter sequence.
adapter_count=$(grep "$adapter\$" "$2" | wc -l)

# Print the total number of reads containing adapter.
echo "Reads containing adapter: $adapter_count"

# Calculate the adapter rate in % and store it in the adapter_rate variable as an integer value.
adapter_rate=$((100 * adapter_count / read_count))

# Print the adapter rate.
echo "Adapter rate: $adapter_rate%"

# Check if the adapter rate is greater than 10% and print the appropriate message.
if ((adapter_rate > 10)); then
  echo "There are too many reads containing the adapter sequence."
else
  echo "There are not many reads containing the adapter sequence."
fi
# Extract the input FASTQ file name without the .fastq extension.
name="${2%.*}"

# This statement removes the adapter sequence from the reads ending with the adapter sequence.
sed "s/$adapter\$//" "$2" > "${name}_trimmed.fastq"

# Print the adapter trimmed read file.
echo "Adapter trimmed reads were written to ${name}_trimmed.fastq file."
