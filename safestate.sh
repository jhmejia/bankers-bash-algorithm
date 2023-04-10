# Safe state function
# Parameters:
#   available_vector_array: The available vector as an array
#   need_matrix_array: The need matrix as a 2D array
#   allocation_matrix_array: The allocation matrix as a 2D array
#   n: The number of processes
#   m: The number of resources
# Returns:
#   0 if the system is in a safe state
#   1 if the system is not in a safe state
function is_safe_state() {
  local available_vector_array=("${!1}")
  local need_matrix_array=("${!2}")
  local allocation_matrix_array=("${!3}")
  local n=$4
  local m=$5

  # Create a copy of the available vector array
  local available_vector_array_copy=("${available_vector_array[@]}")

  # Create a copy of the need matrix array
  local need_matrix_array_copy=("${need_matrix_array[@]}")

  # Create a copy of the allocation matrix array
  local allocation_matrix_array_copy=("${allocation_matrix_array[@]}")

  # Create an array to hold the work vector
  local work_vector_array=()

  # Create an array to hold the finish vector
  local finish_vector_array=()


  # Initialize the work vector array to the available vector array
  work_vector_array=("${available_vector_array_copy[@]}")

  # Initialize the finish vector array to false
  for (( i=0; i<n; i++ )); do
    finish_vector_array+=("false")
  done

  # Loop through the processes
  for (( i=0; i<n; i++ )); do
    # Loop through the processes
    for (( j=0; j<n; j++ )); do
      # Check if the current process has finished
      if [[ "${finish_vector_array[$j]}" == "false" ]]; then
        # Check if the current process can be completed
        can_complete=true
        for (( k=0; k<m; k++ )); do
          if [[ "${need_matrix_array_copy[$j*$m+$k]}" -gt "${work_vector_array[$k]}" ]]; then
            can_complete=false
            break
          fi
        done

        # If the current process can be completed, complete it
        if [[ "$can_complete" == true ]]; then
          # Add the allocation of the current process to the work vector
          for (( k=0; k<m; k++ )); do
            work_vector_array[$k]=$((work_vector_array[$k] + allocation_matrix_array_copy[$j*$m+$k]))
          done

          # Mark the current process as finished
          finish_vector_array[$j]="true"


          # Break out of the loop
          break
        fi
      fi
    done
  done

  # Check if all processes have finished
  for (( i=0; i<n; i++ )); do
    if [[ "${finish_vector_array[$i]}" == "false" ]]; then
      return 1
    fi
  done

  
  return 0
}