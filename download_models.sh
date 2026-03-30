#!/bin/bash
set -e

echo "=== Starting direct model download (No Cache Mode) ==="

MODELS_DIR="/comfyui/models"
mkdir -p $MODELS_DIR/text_encoders $MODELS_DIR/loras $MODELS_DIR/unet $MODELS_DIR/vae $MODELS_DIR/SEEDVR2 $MODELS_DIR/upscale_models

# Function for direct download via wget (prevents double space usage)
download_file() {
    URL=$1
    DEST=$2
    FILENAME=$3
    if [ ! -f "$DEST/$FILENAME" ]; then
        echo "Downloading $FILENAME..."
        wget -q --show-progress -O "$DEST/$FILENAME" "$URL"
    else
        echo "$FILENAME already exists."
    fi
}

# 1. Qwen 2.5 VL Models (Text Encoders)
download_file "https://huggingface.co/unsloth/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/Qwen2.5-VL-7B-Instruct-Q5_K_M.gguf" "$MODELS_DIR/text_encoders" "Qwen2.5-VL-7B-Instruct-Q5_K_M.gguf"
download_file "https://huggingface.co/unsloth/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/mmproj-F16.gguf" "$MODELS_DIR/text_encoders" "Qwen2.5-VL-7B-Instruct-mmproj-F16.gguf"

# 2. Qwen Edit Models (LoRA, UNET, VAE)
download_file "https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/loras/Qwen-Edit-2509-Multiple-angles.safetensors" "$MODELS_DIR/loras" "Qwen-Edit-2509-Multiple-angles.safetensors"
download_file "https://huggingface.co/QuantStack/Qwen-Image-Edit-2509-GGUF/resolve/main/Qwen-Image-Edit-2509-Q5_K_M.gguf" "$MODELS_DIR/unet" "Qwen-Image-Edit-2509-Q5_K_M.gguf"
download_file "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors" "$MODELS_DIR/vae" "qwen_image_vae.safetensors"

# 3. Upscalers
download_file "https://huggingface.co/numz/SeedVR2_comfyUI/resolve/main/seedvr2_ema_7b_fp16.safetensors" "$MODELS_DIR/SEEDVR2" "seedvr2_ema_7b_fp16.safetensors"
download_file "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth" "$MODELS_DIR/upscale_models" "RealESRGAN_x4plus_anime_6B.pth"

echo "=== All models downloaded successfully ==="