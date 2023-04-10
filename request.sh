# Function to determine if a request is grantable. 
# Parameters:
#   1. Request vector array
#   2. Available vector array
#   3. Need matrix array
#   4. Allocation matrix array
#   5. Number of processes
#   6. Number of resources
#   7. Process number requesting resources
function is_request_grantable() {
  local request_vector_array=("${!1}")
  local available_vector_array=("${!2}")
  local need_matrix_array=("${!3}")
  local allocation_matrix_array=("${!4}")
  local n=$5
  local m=$6
  local process_number=$7

  # Check if the request vector is less than or equal to the need vector
  for (( i=0; i<m; i++ )); do
    if [[ "${request_vector_array[$i]}" -gt "${need_matrix_array[$process_number*$m+$i]}" ]]; then
      return 1
    fi
  done

  # Check if the request vector is less than or equal to the available vector
  for (( i=0; i<m; i++ )); do
    if [[ "${request_vector_array[$i]}" -gt "${available_vector_array[$i]}" ]]; then
      return 1
    fi
  done

  # Create a copy of the available vector array
  local available_vector_array_copy=("${available_vector_array[@]}")

  # Create a copy of the need matrix array
  local need_matrix_array_copy=("${need_matrix_array[@]}")

  # Create a copy of the allocation matrix array
  local allocation_matrix_array_copy=("${allocation_matrix_array[@]}")

  # Create a copy of the request vector array
  local request_vector_array_copy=("${request_vector_array[@]}")

  # Add the request vector to the allocation vector
  for (( i=0; i<m; i++ )); do
    allocation_matrix_array_copy[$process_number*$m+$i]=$((allocation_matrix_array_copy[$process_number*$m+$i] + request_vector_array_copy[$i]))
  done

  # Subtract the request vector from the need vector
  for (( i=0; i<m; i++ )); do
    need_matrix_array_copy[$process_number*$m+$i]=$((need_matrix_array_copy[$process_number*$m+$i] - request_vector_array_copy[$i]))
  done

  # Subtract the request vector from the available vector
  for (( i=0; i<m; i++ )); do
    available_vector_array_copy[$i]=$((available_vector_array_copy[$i] - request_vector_array_copy[$i]))
  done

  # Check if the system is in a safe state
  is_safe_state available_vector_array_copy[@] need_matrix_array_copy[@] allocation_matrix_array_copy[@] $n $m
  if [[ $? -ne 0 ]]; then
    return 1
  fi

  return 0

}
