# export CUDA_VISIBLE_DEVICES=6

# model_name=SimpleBaseline
# python -u run_ca.py \
#   --is_training 1 \
#   --lradj 'TST' \
#   --patience 3 \
#   --root_path ./dataset/traffic/ \
#   --data_path traffic.csv \
#   --model "$model_name" \
#   --data custom \
#   --features M \
#   --seq_len 96 \
#   --pred_len 96 \
#   --e_layers 1 \
#   --d_model 128 \
#   --d_ff 256 \
#   --learning_rate 0.006 \
#   --batch_size 24 \
#   --fix_seed 2025 \
#   --use_norm 1 \
#   --wv "db1" \
#   --m 3 \
#   --enc_in 862 \
#   --dec_in 862 \
#   --c_out 862 \
#   --des 'Exp' \
#   --itr 3 \
#   --alpha 0.0\
#   --l1_weight 0.0 \

#!/bin/bash

# List of GPUs to use
GPUS=(5 6 7)
MAX_JOBS_PER_GPU=1

# Initialize job counters for each GPU
declare -A GPU_JOBS
for gpu in "${GPUS[@]}"; do
  GPU_JOBS[$gpu]=0
done

# Function to update job counters
update_job_counters() {
  for pid in "${!PID_GPU[@]}"; do
    if ! kill -0 "$pid" 2>/dev/null; then
      gpu_id=${PID_GPU[$pid]}
      unset PID_GPU[$pid]
      GPU_JOBS[$gpu_id]=$((GPU_JOBS[$gpu_id]-1))
    fi
  done
}

# Replace with your actual model name
model_name=SimpleBaseline

# Generate and execute the commands
declare -A PID_GPU
current_job=0
total_jobs=0


# Collect all parameter combinations
declare -a parameter_combinations
for pred_len in 96 192 336 720; do
  for e_layers in 2; do
    for wv in 'db1'; do
      for m in 3 1; do
        for kernel_size in None; do
          for lr in 0.006 0.003 0.002 0.001; do
            for batch_size in 32; do
              for use_norm in 1; do
                for fix_seed in 2025; do
                  for d_model in 128; do
                    for d_ff in 256; do
                      for alpha in 1 0.9 0.6 0.3 0.1 0; do
                        for l1_weight in 5e-5 5e-3 0; do
                          # Save the parameter combination
                          parameter_combinations+=("$pred_len,$e_layers,$wv,$m,$kernel_size,$lr,$batch_size,$use_norm,$fix_seed,$d_model,$d_ff,$alpha,$l1_weight")
                          ((total_jobs++))
                        done
                      done
                    done
                  done
                done
              done
            done
          done
        done
      done
    done
  done
done

# Start processing jobs
while ((current_job < total_jobs)) || (( ${#PID_GPU[@]} > 0 )); do
  update_job_counters
  
  # Start new jobs if GPUs are available
  while ((current_job < total_jobs)); do
    gpu_available=false
    for gpu in "${GPUS[@]}"; do
      if [[ ${GPU_JOBS[$gpu]} -lt $MAX_JOBS_PER_GPU ]]; then
        gpu_available=true
        gpu_id=$gpu
        break
      fi
    done
    
    if $gpu_available; then
      # Extract parameters
      IFS=',' read -r pred_len e_layers wv m kernel_size lr batch_size use_norm fix_seed d_model d_ff alpha l1_weight <<< "${parameter_combinations[$current_job]}"
      
      # Build the command as an array
      cmd_args=(
        python -u run_ca.py
        --is_training 1
        --lradj 'TST'
        --patience 3
        --root_path ./dataset/traffic/ \
        --data_path traffic.csv \
        --model "$model_name"
        --data custom
        --features M
        --seq_len 96
        --pred_len "$pred_len"
        --e_layers "$e_layers"
        --d_model "$d_model"
        --d_ff "$d_ff"
        --learning_rate "$lr"
        --batch_size "$batch_size"
        --fix_seed "$fix_seed"
        --use_norm "$use_norm"
        --wv "$wv"
        --m "$m"
        --enc_in 862
        --dec_in 862
        --c_out 862
        --des 'Exp'
        --itr 3
        --alpha "$alpha"
        --l1_weight "$l1_weight"
      )
      
      # Start the job
      echo "Starting job $((current_job+1))/$total_jobs on GPU $gpu_id with parameters: pred_len=$pred_len, e_layers=$e_layers, wv=$wv, m=$m, lr=$lr, batch_size=$batch_size, d_model=$d_model, d_ff=$d_ff, alpha=$alpha, l1_weight=$l1_weight"
      CUDA_VISIBLE_DEVICES=$gpu_id "${cmd_args[@]}" &
      pid=$!
      PID_GPU[$pid]=$gpu_id
      GPU_JOBS[$gpu_id]=$((GPU_JOBS[$gpu_id]+1))
      current_job=$((current_job+1))
    else
      break
    fi
  done
  
  sleep 1
done

# Wait for all jobs to finish
wait