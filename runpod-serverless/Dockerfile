# Start from the official 'base' image which is a clean ComfyUI install
FROM runpod/worker-comfyui:5.5.0-base

# Install OpenCV and other dependencies required for face detection
RUN pip install --no-cache-dir opencv-python opencv-contrib-python

# Install custom nodes using comfy-node-install (supports URLs)
RUN comfy-node-install https://github.com/ZHO-ZHO-ZHO/ComfyUI-BRIA_AI-RMBG.git https://github.com/ltdrdata/was-node-suite-comfyui.git

# Download BRIA RMBG model (not available via comfy-cli)
RUN mkdir -p /comfyui/custom_nodes/ComfyUI-BRIA_AI-RMBG/RMBG-1.4 && \
    wget -O /comfyui/custom_nodes/ComfyUI-BRIA_AI-RMBG/RMBG-1.4/model.pth https://huggingface.co/briaai/RMBG-1.4/resolve/main/model.pth

# ComfyUI-Manager is already included in the base image, no need to install it