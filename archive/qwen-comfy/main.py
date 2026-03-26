from runpod_flash import Endpoint, GpuGroup
import torch

@Endpoint(
    name="qwen-multi-angle",
    gpu=GpuGroup.ANY,           # Most reliable for getting a GPU
    workers=1,
    idle_timeout=900,           # 15 minutes
    execution_timeout_ms=600000,    # This forces torch + CUDA on the worker
)
async def run_workflow(image: str = None, **kwargs):
    cuda_available = torch.cuda.is_available()
    gpu_name = torch.cuda.get_device_name(0) if cuda_available else "CPU only"

    return {
        "status": "ok",
        "cuda_available": cuda_available,
        "gpu_name": gpu_name,
        "message": "First run may take 1-3 minutes due to dependency install"
    }