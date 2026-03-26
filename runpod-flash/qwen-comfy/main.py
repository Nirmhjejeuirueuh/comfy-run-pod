from runpod_flash import Endpoint, GpuType

@Endpoint(
    name="qwen-multi-angle",
    gpu=[
        GpuType.NVIDIA_GEFORCE_RTX_4090,    # 24GB (High speed backup)
        GpuType.NVIDIA_GEFORCE_RTX_3090,    # 24GB (Common backup)
        GpuType.NVIDIA_RTX_A5000,           # 24GB (Stable backup)
        GpuType.NVIDIA_L4                    # 24GB (Last resort)
    ],
    regions="all", 
    env={
        "requirements": "requirements.txt",
        "nodes": "nodes.json",
        "models": "models.yaml"
    }
)
def run_workflow(**kwargs):
    # This '**kwargs' allows the function to accept 'image' or any other key
    # The Flash ComfyUI handler will take these and map them to your workflow
    return kwargs