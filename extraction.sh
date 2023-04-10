# Function to get a line from the input file \
# and convert it to an array. 
# Parameters:
#   line_number: The line number to get from the input file
#   num_of_elements: The number of elements in the array
#   destination_array: The name of the array to copy the values to
#   delimiter: The delimiter to use when splitting the line into an array
# Returns:
#   The array with the values from the line to the destination array
get_line_as_array() {
  input="$1"
  line_number="$2"
  num_of_elements="$3"
  destination_array="$4"
  delimiter="$5"

  # Extract the line from the input file
  line=$(sed "${line_number}q;d" <<< "$input")

  # Split the line into an array using the specified delimiter
  IFS="$delimiter" read -ra array <<< "$line"

  # Copy the values from the array to the destination array
  for i in "${!array[@]}"; do
    if [[ $i -lt $num_of_elements ]]; then
      eval "${destination_array}[$i]=${array[$i]}"

    else
      break
    fi
  done

  # Return the destination array
  #echo "${!destination_array}"
}

# Define function to print the letter for each index
function print_letter {
  local alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  # if $1 is not empty, use it as the number of letters to print
  # otherwise, use the value of $m
  local num_letters=${1:-$m}  
  for (( i=0; i<num_letters; i++ )); do
    printf '%s ' "${alphabet:$i:1}"
  done
  printf '\n'
}

# Extracts an nxm matrix from input starting from line_number
# with num_of_elements elements in each line
# Returns the matrix as a 2D array
# Parameters:
#   line_number: The line number to start extracting the matrix from
#   num_of_elements: The number of elements in each line of the matrix
#   n: The number of rows in the matrix
#   m: The number of columns in the matrix
# Returns:
#   The matrix as a 2D array
function extract_matrix() {
  local line_number=$1
  local num_of_elements=$2
  local n=$3
  local m=$4
  local delimiter=" "
  local matrix_array=()

  for (( i=0; i<n; i++ )); do
    # Create a new array to hold the current line of the matrix
    declare -a current_line_array=()

    # Extract the current line and store it in the current_line_array
    get_line_as_array "$input" "$line_number" "$num_of_elements" current_line_array "$delimiter"
    line_number=$((line_number+1))

    # Append the current line array to the matrix_array
    matrix_array+=("${current_line_array[@]}")
  done

  echo "${matrix_array[@]}"
}