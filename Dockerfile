# Start from the official ComfyUI worker base
FROM runpod/worker-comfyui:5.8.5-base

# 1. Install Python dependencies (single layer)
RUN pip install --no-cache-dir \
    xformers triton sageattention accelerate einops \
    transformers>=4.45.0 hf_transfer albumentations \
    opencv-python onnxruntime-gpu color-matcher kornia \
    spandrel torchsde

# 2. Install Custom Nodes (single layer)
RUN comfy-node-install \
    https://github.com/city96/ComfyUI-GGUF.git \
    https://github.com/ltdrdata/ComfyUI-Manager.git \
    https://github.com/rgthree/rgthree-comfy.git \
    https://github.com/numz/ComfyUI-SeedVR2_VideoUpscaler.git

# 3. Create model directories (single layer)
RUN mkdir -p /comfyui/models/text_encoders \
             /comfyui/models/loras \
             /comfyui/models/unet \
             /comfyui/models/vae \
             /comfyui/models/SEEDVR2 \
             /comfyui/models/upscale_models

# 4. Download ALL large models in ONE single RUN layer (this is the biggest speedup)
#    We use hf_transfer for much faster Hugging Face downloads
RUN export HF_HUB_ENABLE_HF_TRANSFER=1 && \
    wget -q -O /comfyui/models/text_encoders/Qwen2.5-VL-7B-Instruct-Q5_K_M.gguf \
        https://huggingface.co/unsloth/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/Qwen2.5-VL-7B-Instruct-Q5_K_M.gguf && \
    wget -q -O /comfyui/models/text_encoders/Qwen2.5-VL-7B-Instruct-mmproj-F16.gguf \
        https://huggingface.co/unsloth/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/mmproj-F16.gguf && \
    wget -q -O /comfyui/models/loras/Qwen-Edit-2509-Multiple-angles.safetensors \
        https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/loras/Qwen-Edit-2509-Multiple-angles.safetensors && \
    wget -q -O /comfyui/models/unet/Qwen-Image-Edit-2509-Q5_K_M.gguf \
        https://huggingface.co/QuantStack/Qwen-Image-Edit-2509-GGUF/resolve/main/Qwen-Image-Edit-2509-Q5_K_M.gguf && \
    wget -q -O /comfyui/models/vae/qwen_image_vae.safetensors \
        https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors && \
    wget -q -O /comfyui/models/SEEDVR2/seedvr2_ema_7b_fp16.safetensors \
        https://huggingface.co/numz/SeedVR2_comfyUI/resolve/main/seedvr2_ema_7b_fp16.safetensors && \
    wget -q -O /comfyui/models/upscale_models/RealESRGAN_x4plus_anime_6B.pth \
        https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth

# 5. Copy workflows
COPY qwen-multi-angle-v2-api.json /app/qwen.json
COPY RealESRGAN_api.json /app/fast_upscale.json
COPY SeedVR2-Image-Upscaler-New-ComfyUI-api.json /app/high_upscale.json

WORKDIR /app
CMD ["python", "-u", "/app/worker.py"]