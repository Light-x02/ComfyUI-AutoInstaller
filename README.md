![Python 3.12.9](https://img.shields.io/badge/python-3.12.9-blue)
![License: MIT](https://img.shields.io/badge/license-MIT-green)

# Full Installation Guide for ComfyUI with Python Virtual Environment (venv)

This guide explains how to install **ComfyUI** in an isolated Python virtual environment with an advanced configuration:

- **Python**: 3.12.9  
- **Torch**: 2.9.0.dev20250716+cu128  
- **Triton**: triton-windows==3.3.1.post19  
- **SageAttention**: enabled  
- **fp16 accumulation**: enabled via `--fast fp16_accumulation`

> 📡 **Recommended GPU**: NVIDIA GPU compatible with CUDA 12.8 or higher.

> 💡 **AMD / Other GPUs**: This guide is only compatible with **NVIDIA GPUs** supporting **CUDA 12.8 or later**. It does **not** cover installation on AMD, Intel, or CPU-only configurations.

While ComfyUI can theoretically run on these alternatives, expect major limitations:

- Very slow performance (especially without GPU)
- Key features (SageAttention, Triton) require CUDA-compatible NVIDIA GPU
- No official support for **ROCm** (AMD) or **DirectML** (Intel)

✅ **Compatible GPUs**:  
- NVIDIA GTX 10xx series, RTX 20xx, 30xx, 40xx, 50xx (e.g., GTX 1080, RTX 2060, 3080, 4090, 5080)

🛑 Not supported:  
- AMD Radeon (RX 5000/6000/7000)  
- Intel Arc / iGPU  
- Any non-NVIDIA GPU

---

## Requirements

### ✅ Hardware / Software

- **CUDA Toolkit 12.8** installed on your system (mandatory for Torch 2.9 + Triton)  
  - Download: [https://developer.nvidia.com/cuda-12-8-0-download-archive?target_os=Windows](https://developer.nvidia.com/cuda-12-8-0-download-archive?target_os=Windows)

- OS: **Windows 10 or 11**

- **NVIDIA GPU** with CUDA 12.8 support

- **Up-to-date NVIDIA drivers**

- **Python 3.12.9** (check “Add Python to PATH”)  
  - [https://www.python.org/downloads/release/python-3129/](https://www.python.org/downloads/release/python-3129/)

- **Git**  
  - [https://git-scm.com/downloads/win](https://git-scm.com/downloads/win)

- **Visual Studio Build Tools**  
  - [https://visualstudio.microsoft.com/visual-cpp-build-tools/](https://visualstudio.microsoft.com/visual-cpp-build-tools/)  
  - During installation, check: *C++ build tools*, *MSVC v143*, *Windows 10 SDK*, *CMake*

- Internet access

- Optional: **Notepad++** or similar text editor

---

## ⚙️ Automatic Installation (optional)

To save time, you can use the provided batch script to automate installation. It performs:

- Cloning the ComfyUI repository
- Creating and activating a Python 3.12.9 virtual environment
- Installing specific Torch (2.9.0.dev20250716+cu128) and Triton (3.2.0.post19) versions
- Cleaning `requirements.txt`
- Installing SageAttention and dependencies
- Creating the launch script `launch_comfyUI_torch2.9.bat`
- Installing ComfyUI-Manager

💡 **To use it**:
1. Make sure **Python 3.12.9**, **CUDA Toolkit 12.8**, and **Visual C++ Build Tools** are already installed.
2. Download or copy the `.bat` file and run it using CMD.

---

## ⚙️ Manual Installation (step-by-step)

### ❌ Do not use PowerShell  
Use **CMD** to avoid `.bat` or environment issues.

## Clone the ComfyUI repository

1. Open CMD (Win + R → type `cmd` → Enter).  
   ❗ **Do not close this window until the installation is complete.**

2. In your desired install location, run:

```bat
git clone https://github.com/comfyanonymous/ComfyUI.git ComfyUI.torch2.9
cd ComfyUI.torch2.9
```

---

## Create and activate Python virtual environment

Ensure Python 3.12.9 is properly installed.

```bat
py -m venv venv
call venv\Scripts\activate.bat
```

---

## Upgrade pip and build tools

```bat
python -m pip install --upgrade pip setuptools wheel
```

---

## Install PyTorch Nightly (CUDA 12.8)

```bat
pip uninstall torch torchvision torchaudio -y
pip install torch==2.9.0.dev20250716+cu128 torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu128
```

---

## Install Triton for Windows

```bat
pip install triton-windows==3.3.1.post19
```

---

## Clean requirements.txt

Open `requirements.txt` inside `ComfyUI.torch2.9` and remove or comment:

```
# torch
# torchvision
# torchaudio
```

Then install dependencies:

```bat
pip install -r requirements.txt
```

---

## Install SageAttention

```bat
python -m pip install sageattention
```

---

## Create a launch script

Create a `launch_comfyUI_torch2.9.bat` file in the `ComfyUI.torch2.9` folder with this content:

```bat
@echo off
call venv\Scripts\activate.bat
python main.py --use-sage-attention --fast fp16_accumulation --preview-method taesd
pause
```

---

## Install ComfyUI-Manager (optional)

```bat
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ..
```

---

## Fix setuptools conflict

⚠️ This step is **mandatory**: certain setuptools versions conflict with Triton (especially via `pkg_resources`).

```bat
pip uninstall -y setuptools
pip install setuptools==78.1.1
```

---

## Run ComfyUI

Launch `launch_comfyUI_torch2.9.bat` to start ComfyUI.
Check the console to confirm that Torch, Triton, and SageAttention load without errors.

---

✨ You're now ready to use ComfyUI with full performance!


