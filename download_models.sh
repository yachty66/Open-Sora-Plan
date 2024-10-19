#!/bin/bash

# Create the main models directory and subdirectories if they don't exist
mkdir -p models/main_model
mkdir -p models/vae
mkdir -p models/text_encoder

# Function to download a file using aria2c with the correct filename
download_file() {
    local url=$1
    local output_dir=$2
    local filename=$3
    
    echo "Downloading $filename..."
    aria2c -x 16 -s 16 -d "$output_dir" -o "$filename" "$url"
}

# Download main_model files
base_url="https://huggingface.co/LanguageBind/Open-Sora-Plan-v1.3.0/resolve/main/any93x640x640"
download_file "$base_url/config.json" "models/main_model" "config.json"
download_file "$base_url/diffusion_pytorch_model-00001-of-00002.safetensors" "models/main_model" "diffusion_pytorch_model-00001-of-00002.safetensors"
download_file "$base_url/diffusion_pytorch_model-00002-of-00002.safetensors" "models/main_model" "diffusion_pytorch_model-00002-of-00002.safetensors"
download_file "$base_url/diffusion_pytorch_model.safetensors.index.json" "models/main_model" "diffusion_pytorch_model.safetensors.index.json"

# Download vae files
vae_base_url="https://huggingface.co/LanguageBind/Open-Sora-Plan-v1.3.0/resolve/main/vae"
download_file "$vae_base_url/config.json" "models/vae" "config.json"
download_file "$vae_base_url/merged.ckpt" "models/vae" "merged.ckpt"

# Download text_encoder files
text_encoder_base_url="https://huggingface.co/google/mt5-xxl/resolve/main"
download_file "$text_encoder_base_url/config.json" "models/text_encoder" "config.json"
download_file "$text_encoder_base_url/generation_config.json" "models/text_encoder" "generation_config.json"
download_file "$text_encoder_base_url/pytorch_model.bin" "models/text_encoder" "pytorch_model.bin"
download_file "$text_encoder_base_url/special_tokens_map.json" "models/text_encoder" "special_tokens_map.json"
download_file "$text_encoder_base_url/spiece.model" "models/text_encoder" "spiece.model"
download_file "$text_encoder_base_url/tokenizer_config.json" "models/text_encoder" "tokenizer_config.json"

echo "All downloads completed!"