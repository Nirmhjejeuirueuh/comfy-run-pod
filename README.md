# ComfyUI Docker Image v2.5

A comprehensive ComfyUI Docker image with advanced AI models and custom nodes for image generation and processing.

## What's Included

### Base System
- **ComfyUI 5.5.0-base** - Latest stable ComfyUI from RunPod
- **Python 3.12** with CUDA support
- **OpenCV** and **Transformers** libraries

### Custom Nodes
- **ComfyUI-RndNanthu** - Random utilities and enhancements
- **ComfyUI-SeedVR2_VideoUpscaler** (Nightly branch) - Advanced video upscaling
- **ComfyUI_LayerStyle_Advance** - Advanced layer styling
- **Civicomfy** - Civic AI integration
- **ComfyUI-Florence2** - Florence-2 vision model integration
- **ComfyUI_Comfyroll_CustomNodes** - Custom workflow nodes
- **ComfyUI_essentials** - Essential utilities
- **ComfyUI-Custom-Scripts** - Custom scripting capabilities
- **rgthree-comfy** - Advanced workflow management
- **ComfyUI-KJNodes** - KJ's custom nodes collection

### Pre-installed Models
- **SeedVR2 Upscaler** (16GB) - High-quality video/image upscaling
- **VXVI_LastFame_DMD2 Checkpoint** (6GB) - Advanced SDXL checkpoint

## System Requirements

- **Container Disk Space**: Minimum 60GB (recommended 80GB+)
- **RAM**: 16GB+ recommended
- **GPU**: NVIDIA GPU with CUDA support

## RunPod Deployment Guide

Follow these steps to deploy on RunPod Serverless:

### Step 1: Access RunPod Console
1. Go to https://console.runpod.io/serverless
2. Click **"New Endpoint"**

### Step 2: Configure Repository
1. **Select Repository Source**: Choose your Git repository
2. **Repository URL**: `https://github.com/KavinthaD/comfyui-from-github-v2.5`
3. **Branch**: `main` (or your preferred branch)
4. **Dockerfile Path**: Leave empty (uses root `Dockerfile`)
5. Click **"Next"**

### Step 3: GPU Configuration
1. **GPU Type**: Select **A100, H100, or RTX 4090/3090** (24GB+ VRAM recommended)
2. **GPU Count**: 1
3. **Container Disk Size**: **80GB minimum** (critical for model storage)
4. **Container Registry**: Leave default
5. Click **"Next"**

### Step 4: Environment Variables (AWS S3)
Add these environment variables for model storage:

```
BUCKET_ENDPOINT_URL=https://your-bucket-name.s3.us-east-1.amazonaws.com
BUCKET_ACCESS_KEY_ID=your-access-key-id
BUCKET_SECRET_ACCESS_KEY=your-secret-access-key
```

**Note**: Replace with your actual S3 bucket details. The endpoint URL format is: `https://[bucket-name].s3.[region].amazonaws.com`

### Step 5: Advanced Configuration (Optional)
1. **Container Port**: `8188` (ComfyUI default)
2. **HTTP Routes**: `/` (root path)
3. **Worker Concurrency**: 1 (recommended for GPU workloads)
4. **Max Workers**: 1
5. **Idle Timeout**: 300 seconds
6. **Scaler Type**: Queue Delay (recommended)

### Step 6: Deploy
1. Review all settings
2. Click **"Deploy Endpoint"**
3. Wait for build to complete (1-2 hours)

### Step 7: Monitor Build
1. Go to your endpoint in the dashboard
2. Click **"View Logs"** tab
3. Monitor build progress
4. **Success indicators**:
   - Build ends with "OK"
   - Large model layers downloaded (15GB+)
   - No error messages

### Step 8: Access ComfyUI
Once deployed successfully:
1. Get the endpoint URL from RunPod dashboard
2. Access ComfyUI at: `https://[your-endpoint-id].runpod.net`
3. The interface will load with all custom nodes and models ready

## API Testing with Postman

Test your deployed ComfyUI endpoint using RunPod's API:

### POST Request - Run a Job
```
Method: POST
URL: https://api.runpod.ai/v2/[YOUR-ENDPOINT-ID]/run
Headers:
  Authorization: Bearer [YOUR-RUNPOD-API-KEY]
  Content-Type: application/json

Body (JSON):
{
  "input": {
    "workflow": {
      // Your ComfyUI workflow JSON here
    }
  }
}
```

**Example Response:**
```json
{
  "id": "77a8df5c-2137-4801-8adb-29bf630c6308-e2",
  "status": "IN_QUEUE"
}
```

### GET Request - Check Job Status
```
Method: GET
URL: https://api.runpod.ai/v2/[YOUR-ENDPOINT-ID]/status/[JOB-ID]
Headers:
  Authorization: Bearer [YOUR-RUNPOD-API-KEY]
```

**Replace `[JOB-ID]` with the `id` from the POST response above.**

**Example Status Response:**
```json
{
  "id": "77a8df5c-2137-4801-8adb-29bf630c6308-e2",
  "status": "COMPLETED",
  "output": {
    // Generated images/results
  }
}
```

### Status Values
- `IN_QUEUE`: Job is waiting to be processed
- `IN_PROGRESS`: Job is currently running
- `COMPLETED`: Job finished successfully
- `FAILED`: Job encountered an error
- `CANCELLED`: Job was cancelled

### Finding Your Endpoint ID and API Key
1. **Endpoint ID**: Found in RunPod dashboard under your endpoint details
2. **API Key**: Generate from https://console.runpod.io/settings

## Troubleshooting RunPod Issues

### Build Failures
- **Disk Space**: Ensure 80GB+ container disk
- **Timeout**: Large models may take 20+ minutes to download
- **Network**: Stable connection required for GitHub/S3 access

### Runtime Issues
- **GPU Memory**: Use GPUs with 24GB+ VRAM for complex workflows
- **Cold Starts**: First request may take longer due to model loading
- **Storage**: S3 bucket must be accessible and have proper permissions

### Common Errors
- **"No space left on device"**: Increase container disk size
- **"Model download failed"**: Check S3 credentials and bucket permissions
- **"CUDA out of memory"**: Use higher-end GPU or reduce batch sizes

## Features

- **Face Detection**: OpenCV integration for facial recognition
- **Video Upscaling**: SeedVR2 for high-quality video enhancement
- **Advanced Workflows**: Multiple custom node collections
- **Model Management**: Pre-loaded checkpoints and upscalers
- **CUDA Optimized**: Full GPU acceleration support

## Troubleshooting

### Build Issues
- **Disk Space**: Ensure 60GB+ container space
- **Network**: Stable internet for model downloads
- **GPU**: NVIDIA GPU required for optimal performance

### Runtime Issues
- **Memory**: Increase RAM if workflows are complex
- **Models**: Models download automatically on first run
- **Custom Nodes**: All nodes are pre-installed and ready

## Version History

- **v2.5**: Simplified build process, direct git cloning, optimized space usage
- **v2.4**: Added multiple custom nodes, improved model management
- **v2.3**: Enhanced error handling and fallback mechanisms
- **v2.2**: Added SeedVR2 nightly branch support
- **v2.1**: Initial multi-node setup
- **v1.0**: Basic ComfyUI with RMBG support

## Contributing

This Docker image is built for the Figuro ComfyUI project. For issues or improvements, please check the repository.

## License

See individual component licenses for details.