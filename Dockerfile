FROM runpod/worker-comfyui:5.8.5-base

# 1. Install system tools and dependencies
RUN apt-get update && apt-get install -y wget && apt-get clean
RUN pip install --no-cache-dir \
    xformers triton sageattention accelerate einops \
    transformers>=4.45.0 hf_transfer albumentations \
    opencv-python onnxruntime-gpu color-matcher kornia \
    spandrel torchsde

# 2. Install Custom Nodes
RUN comfy-node-install \
    https://github.com/city96/ComfyUI-GGUF.git \
    https://github.com/ltdrdata/ComfyUI-Manager.git \
    https://github.com/rgthree/rgthree-comfy.git \
    https://github.com/numz/ComfyUI-SeedVR2_VideoUpscaler.git

# 3. Copy workflows
COPY qwen-multi-angle-v2-api.json /app/qwen.json
COPY RealESRGAN_api.json /app/fast_upscale.json
COPY SeedVR2-Image-Upscaler-New-ComfyUI-api.json /app/high_upscale.json

# 4. Setup the script
COPY download_models.sh /app/download_models.sh
RUN chmod +x /app/download_models.sh

WORKDIR /app

# 5. Execute: First download, then run worker
CMD ["sh", "-c", "/app/download_models.sh && python -u /app/worker.py"]