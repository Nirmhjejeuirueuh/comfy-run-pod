FROM runpod/worker-comfyui:5.8.5-base

# Install dependencies + hf_transfer for fast downloads
RUN pip install --no-cache-dir \
    xformers triton sageattention accelerate einops \
    transformers>=4.45.0 hf_transfer albumentations \
    opencv-python onnxruntime-gpu color-matcher kornia \
    spandrel torchsde

# Install custom nodes
RUN comfy-node-install \
    https://github.com/city96/ComfyUI-GGUF.git \
    https://github.com/ltdrdata/ComfyUI-Manager.git \
    https://github.com/rgthree/rgthree-comfy.git \
    https://github.com/numz/ComfyUI-SeedVR2_VideoUpscaler.git

# Create model directories
RUN mkdir -p /comfyui/models/text_encoders /comfyui/models/loras /comfyui/models/unet \
             /comfyui/models/vae /comfyui/models/SEEDVR2 /comfyui/models/upscale_models

# Copy workflows
COPY qwen-multi-angle-v2-api.json /app/qwen.json
COPY RealESRGAN_api.json /app/fast_upscale.json
COPY SeedVR2-Image-Upscaler-New-ComfyUI-api.json /app/high_upscale.json

# Copy fast download script
COPY download_models.sh /app/download_models.sh
RUN chmod +x /app/download_models.sh

WORKDIR /app

# Download models first (with hf_transfer), then start worker
CMD ["/bin/bash", "-c", "/app/download_models.sh && python -u /app/worker.py"]