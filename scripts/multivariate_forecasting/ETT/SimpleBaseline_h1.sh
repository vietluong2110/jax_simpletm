export XLA_PYTHON_CLIENT_PREALLOCATE=false
export XLA_PYTHON_CLIENT_ALLOCATOR=platform

export CUDA_VISIBLE_DEVICES=7
model_name=JAX_SimpleBaseline
# python -u jax_run_ca.py \
#   --is_training 1 \
#   --lradj TST \
#   --patience 3 \
#   --root_path ./dataset/ETT-small/ \
#   --data_path ETTh1.csv \
#   --model_id ETTh1 \
#   --model $model_name \
#   --data ETTh1 \
#   --features M \
#   --seq_len 96 \
#   --pred_len 96 \
#   --e_layers 1 \
#   --d_model 32 \
#   --d_ff 32 \
#   --learning_rate 0.02 \
#   --batch_size 256 \
#   --fix_seed 2025 \
#   --use_norm 1 \
#   --wv db1 \
#   --m 3 \
#   --enc_in 7 \
#   --dec_in 7 \
#   --c_out 7 \
#   --des Exp \
#   --itr 3 \
#   --alpha 0.3 \
#   --l1_weight 0.0005 \
  # --benchmark True

# python -u run_ca.py \
#   --is_training 0 \
#   --lradj TST \
#   --patience 3 \
#   --root_path ./dataset/ETT-small/ \
#   --data_path ETTh1.csv \
#   --model_id ETTh1 \
#   --model $model_name \
#   --data ETTh1 \
#   --features M \
#   --seq_len 96 \
#   --pred_len 192 \
#   --e_layers 1 \
#   --d_model 32 \
#   --d_ff 32 \
#   --learning_rate 0.02 \
#   --batch_size 256 \
#   --fix_seed 2025 \
#   --use_norm 1 \
#   --wv db1 \
#   --m 3 \
#   --enc_in 7 \
#   --dec_in 7 \
#   --c_out 7 \
#   --des Exp \
#   --itr 3 \
#   --alpha 1.0 \
#   --l1_weight 5e-05 \
#   --benchmark True

# python -u jax_run_ca.py \
#   --is_training 1 \
#   --lradj TST \
#   --patience 3 \
#   --root_path ./dataset/ETT-small/ \
#   --data_path ETTh1.csv \
#   --model_id ETTh1 \
#   --model $model_name \
#   --data ETTh1 \
#   --features M \
#   --seq_len 96 \
#   --pred_len 336 \
#   --e_layers 2 \
#   --d_model 64 \
#   --d_ff 64 \
#   --learning_rate 0.002 \
#   --batch_size 256 \
#   --fix_seed 2025 \
#   --use_norm 1 \
#   --wv db1 \
#   --m 3 \
#   --enc_in 7 \
#   --dec_in 7 \
#   --c_out 7 \
#   --des Exp \
#   --itr 3 \
#   --alpha 0.0 \
#   --l1_weight 0.0 \

python -u jax_run_ca.py \
  --is_training 1 \
  --lradj TST \
  --patience 3 \
  --root_path ./dataset/ETT-small/ \
  --data_path ETTh1.csv \
  --model_id ETTh1 \
  --model $model_name \
  --data ETTh1 \
  --features M \
  --seq_len 96 \
  --pred_len 720 \
  --e_layers 2 \
  --d_model 32 \
  --d_ff 32 \
  --learning_rate 0.009 \
  --batch_size 256 \
  --fix_seed 2025 \
  --use_norm 1 \
  --wv db1 \
  --m 1 \
  --enc_in 7 \
  --dec_in 7 \
  --c_out 7 \
  --des Exp \
  --itr 3 \
  --alpha 0.9 \
  --l1_weight 0.0005 \
