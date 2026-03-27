#!/bin/bash
echo "=== Starting fast model download check (hf_transfer) ==="

# Enable hf_transfer for maximum speed
export HF_HUB_ENABLE_HF_TRANSFER=1

mkdir -p /comfyui/models/text_encoders /comfyui/models/loras /comfyui/models/unet \
         /comfyui/models/vae /comfyui/models/SEEDVR2 /comfyui/models/upscale_models

# Qwen models
if [ ! -f /comfyui/models/text_encoders/Qwen2.5-VL-7B-Instruct-Q5_K_M.gguf ]; then
    echo "Downloading Qwen2.5-VL GGUF..."
    huggingface-cli download unsloth/Qwen2.5-VL-7B-Instruct-GGUF Qwen2.5-VL-7B-Instruct-Q5_K_M.gguf --local-dir /comfyui/models/text_encoders --local-dir-use-symlinks False
fi

if [ ! -f /comfyui/models/text_encoders/Qwen2.5-VL-7B-Instruct-mmproj-F16.gguf ]; then
    echo "Downloading Qwen mmproj..."
    huggingface-cli download unsloth/Qwen2.5-VL-7B-Instruct-GGUF mmproj-F16.gguf --local-dir /comfyui/models/text_encoders --local-dir-use-symlinks False
fi

# Qwen Edit files
if [ ! -f /comfyui/models/loras/Qwen-Edit-2509-Multiple-angles.safetensors ]; then
    echo "Downloading Qwen LoRA..."
    huggingface-cli download Comfy-Org/Qwen-Image-Edit_ComfyUI split_files/loras/Qwen-Edit-2509-Multiple-angles.safetensors --local-dir /comfyui/models/loras --local-dir-use-symlinks False
fi

if [ ! -f /comfyui/models/unet/Qwen-Image-Edit-2509-Q5_K_M.gguf ]; then
    echo "Downloading Qwen UNET GGUF..."
    huggingface-cli download QuantStack/Qwen-Image-Edit-2509-GGUF Qwen-Image-Edit-2509-Q5_K_M.gguf --local-dir /comfyui/models/unet --local-dir-use-symlinks False
fi

if [ ! -f /comfyui/models/vae/qwen_image_vae.safetensors ]; then
    echo "Downloading Qwen VAE..."
    huggingface-cli download Comfy-Org/Qwen-Image_ComfyUI split_files/vae/qwen_image_vae.safetensors --local-dir /comfyui/models/vae --local-dir-use-symlinks False
fi

# Upscaler models
if [ ! -f /comfyui/models/SEEDVR2/seedvr2_ema_7b_fp16.safetensors ]; then
    echo "Downloading SeedVR2..."
    huggingface-cli download numz/SeedVR2_comfyUI seedvr2_ema_7b_fp16.safetensors --local-dir /comfyui/models/SEEDVR2 --local-dir-use-symlinks False
fi

if [ ! -f /comfyui/models/upscale_models/RealESRGAN_x4plus_anime_6B.pth ]; then
    echo "Downloading RealESRGAN..."
    wget -q -O /comfyui/models/upscale_models/RealESRGAN_x4plus_anime_6B.pth \
        https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth
fi

echo "=== All models ready ==="