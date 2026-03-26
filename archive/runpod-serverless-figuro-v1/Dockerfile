# 1. Start from the official ComfyUI base
FROM runpod/worker-comfyui:5.5.0-base

# 2. Install Python Speed Stack (SageAttention, Triton, Xformers)
# These are crucial for Qwen-VL performance
RUN pip install --no-cache-dir \
    xformers \
    triton \
    sageattention \
    accelerate \
    einops \
    transformers>=4.45.0 \
    hf_transfer

# 3. Install Custom Nodes via comfy-node-install
# We MUST have ComfyUI-GGUF to run your Qwen GGUF models
RUN comfy-node-install \
    https://github.com/city96/ComfyUI-GGUF.git \
    https://github.com/ltdrdata/ComfyUI-Manager.git

# 4. Create model directories
RUN mkdir -p /comfyui/models/text_encoders \
    mkdir -p /comfyui/models/loras \
    mkdir -p /comfyui/models/unet \
    mkdir -p /comfyui/models/vae

# 5. Download Qwen Models (The "Fat" layers)
# We use wget -O to ensure filenames match exactly what your workflow expects

# Qwen Text Encoder (GGUF)
RUN wget -O /comfyui/models/text_encoders/Qwen2.5-VL-7B-Instruct-Q5_K_M.gguf \
    https://huggingface.co/unsloth/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/Qwen2.5-VL-7B-Instruct-Q5_K_M.gguf

# Qwen mmproj (renamed as per your Colab logic)
RUN wget -O /comfyui/models/text_encoders/Qwen2.5-VL-7B-Instruct-mmproj-F16.gguf \
    https://huggingface.co/unsloth/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/mmproj-F16.gguf

# Multi-angle LoRA
RUN wget -O /comfyui/models/loras/Qwen-Edit-2509-Multiple-angles.safetensors \
    https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/loras/Qwen-Edit-2509-Multiple-angles.safetensors

# Lightning 4-step LoRA
RUN wget -O /comfyui/models/loras/Qwen-Image-Edit-2509-Lightning-4steps-V1.0-bf16.safetensors \
    https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-2509/Qwen-Image-Edit-2509-Lightning-4steps-V1.0-bf16.safetensors

# Diffusion Model (GGUF)
RUN wget -O /comfyui/models/unet/Qwen-Image-Edit-2509-Q5_K_M.gguf \
    https://huggingface.co/QuantStack/Qwen-Image-Edit-2509-GGUF/resolve/main/Qwen-Image-Edit-2509-Q5_K_M.gguf

# Qwen VAE
RUN wget -O /comfyui/models/vae/qwen_image_vae.safetensors \
    https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors

# 6. Final check and setup
# Make sure your workflow_api.json is in the root folder when you build this
COPY workflow_api.json /app/workflow_api.json

# Standard RunPod Worker start command
WORKDIR /app
CMD [ "python", "-u", "/app/worker.py" ]