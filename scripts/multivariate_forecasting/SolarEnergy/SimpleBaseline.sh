
export XLA_PYTHON_CLIENT_PREALLOCATE=false
# export XLA_PYTHON_CLIENT_ALLOCATOR=platform
export CUDA_VISIBLE_DEVICES=7
model_name=JAX_SimpleBaseline
python -u jax_run_ca.py \
  --is_training 1 \
  --lradj 'TST' \
  --patience 3 \
  --root_path ./dataset/solar/ \
  --data_path solar_AL.txt \
  --model_id Solar \
  --model "$model_name" \
  --data Solar \
  --features M \
  --seq_len 96 \
  --pred_len 96 \
  --e_layers 1 \
  --d_model 128 \
  --d_ff 256 \
  --learning_rate 0.01 \
  --batch_size 256 \
  --fix_seed 2025 \
  --use_norm 0 \
  --wv "db8" \
  --m 3 \
  --enc_in 137 \
  --dec_in 137 \
  --c_out 137 \
  --des 'Exp' \
  --itr 3 \
  --use_norm 0 \
  --alpha 0.0 \
  --l1_weight 0.005 \

python -u jax_run_ca.py \
  --is_training 1 \
  --lradj 'TST' \
  --patience 3 \
  --root_path ./dataset/solar/ \
  --data_path solar_AL.txt \
  --model_id Solar \
  --model "$model_name" \
  --data Solar \
  --features M \
  --seq_len 96 \
  --pred_len 192 \
  --e_layers 1 \
  --d_model 128 \
  --d_ff 256 \
  --learning_rate 0.003 \
  --batch_size 256 \
  --fix_seed 2025 \
  --use_norm 0 \
  --wv "db8" \
  --m 1 \
  --enc_in 137 \
  --dec_in 137 \
  --c_out 137 \
  --des 'Exp' \
  --itr 2 \
  --use_norm 0 \
  --alpha 0.0 \
  --l1_weight 0.005 \

python -u jax_run_ca.py \
  --is_training 1 \
  --lradj 'TST' \
  --patience 3 \
  --root_path ./dataset/solar/ \
  --data_path solar_AL.txt \
  --model_id Solar \
  --model "$model_name" \
  --data Solar \
  --features M \
  --seq_len 96 \
  --pred_len 336 \
  --e_layers 1 \
  --d_model 128 \
  --d_ff 256 \
  --learning_rate 0.003 \
  --batch_size 256 \
  --fix_seed 2025 \
  --use_norm 0 \
  --wv "db8" \
  --m 1 \
  --enc_in 137 \
  --dec_in 137 \
  --c_out 137 \
  --des 'Exp' \
  --itr 2 \
  --use_norm 0 \
  --alpha 0.1 \
  --l1_weight 0.005 \
        
python -u jax_run_ca.py \
  --is_training 1 \
  --lradj 'TST' \
  --patience 3 \
  --root_path ./dataset/solar/ \
  --data_path solar_AL.txt \
  --model_id Solar \
  --model "$model_name" \
  --data Solar \
  --features M \
  --seq_len 96 \
  --pred_len 720 \
  --e_layers 1 \
  --d_model 128 \
  --d_ff 256 \
  --learning_rate 0.009 \
  --batch_size 256 \
  --fix_seed 2025 \
  --use_norm 0 \
  --wv "db8" \
  --m 1 \
  --enc_in 137 \
  --dec_in 137 \
  --c_out 137 \
  --des 'Exp' \
  --itr 3 \
  --use_norm 0 \
  --alpha 0.0 \
  --l1_weight 0.005 \
        


