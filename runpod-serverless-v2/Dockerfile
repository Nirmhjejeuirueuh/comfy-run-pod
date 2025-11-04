# Start from the official 'base' image which is a clean ComfyUI install
FROM runpod/worker-comfyui:5.5.0-base

# Install OpenCV and other dependencies required for face detection and custom nodes
RUN pip install --no-cache-dir opencv-python opencv-contrib-python transformers accelerate

# Install git first (needed for cloning)
RUN apt-get update && apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone custom nodes directly
RUN git clone https://github.com/RndNanthu/ComfyUI-RndNanthu /comfyui/custom_nodes/ComfyUI-RndNanthu
RUN git clone https://github.com/numz/ComfyUI-SeedVR2_VideoUpscaler /comfyui/custom_nodes/ComfyUI-SeedVR2_VideoUpscaler
RUN git clone https://github.com/chflame163/ComfyUI_LayerStyle_Advance /comfyui/custom_nodes/ComfyUI_LayerStyle_Advance
RUN git clone https://github.com/MoonGoblinDev/Civicomfy /comfyui/custom_nodes/Civicomfy
RUN git clone https://github.com/kijai/ComfyUI-Florence2 /comfyui/custom_nodes/ComfyUI-Florence2
RUN git clone https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes /comfyui/custom_nodes/ComfyUI_Comfyroll_CustomNodes
RUN git clone https://github.com/cubiq/ComfyUI_essentials /comfyui/custom_nodes/ComfyUI_essentials
RUN git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts /comfyui/custom_nodes/ComfyUI-Custom-Scripts
RUN git clone https://github.com/rgthree/rgthree-comfy /comfyui/custom_nodes/rgthree-comfy
RUN git clone https://github.com/kijai/ComfyUI-KJNodes /comfyui/custom_nodes/ComfyUI-KJNodes

# Special handling for ComfyUI-SeedVR2_VideoUpscaler (switch to nightly branch)
RUN cd /comfyui/custom_nodes/ComfyUI-SeedVR2_VideoUpscaler && \
    git fetch origin nightly && \
    git checkout nightly

# Install requirements for nodes that need them (conditional to avoid errors)
RUN cd /comfyui/custom_nodes/ComfyUI-RndNanthu && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

RUN cd /comfyui/custom_nodes/ComfyUI-SeedVR2_VideoUpscaler && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

RUN cd /comfyui/custom_nodes/ComfyUI_LayerStyle_Advance && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

RUN cd /comfyui/custom_nodes/ComfyUI-Florence2 && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

RUN cd /comfyui/custom_nodes/ComfyUI_Comfyroll_CustomNodes && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

RUN cd /comfyui/custom_nodes/ComfyUI-KJNodes && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

RUN cd /comfyui/custom_nodes/Civicomfy && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

RUN cd /comfyui/custom_nodes/ComfyUI-Custom-Scripts && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

RUN cd /comfyui/custom_nodes/rgthree-comfy && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Download models
# 16GB SeedVR2 Upscaler
RUN mkdir -p /comfyui/models/upscale_models && \
    wget -O /comfyui/models/upscale_models/seedvr2_ema_7b_fp16.safetensors "https://huggingface.co/numz/SeedVR2_comfyUI/resolve/main/seedvr2_ema_7b_fp16.safetensors"

# 6GB VXVI_LastFame_DMD2 Checkpoint
RUN mkdir -p /comfyui/models/checkpoints && \
    wget -O /comfyui/models/checkpoints/VXVI_LastFame_DMD2.safetensors "https://civitai.com/api/download/models/484695"

# ComfyUI-Manager is already included in the base image, no need to install it