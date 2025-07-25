@echo off
setlocal

REM Clone the ComfyUI repository
git clone https://github.com/comfyanonymous/ComfyUI.git ComfyUI.torch2.9
cd ComfyUI.torch2.9

REM Create and activate the virtual environment
py -m venv venv
call venv\Scripts\activate.bat

REM Upgrade pip and build tools
python -m pip install --upgrade pip setuptools wheel

REM Remove any existing Torch installation
pip uninstall -y torch torchvision torchaudio

REM Install Torch nightly with CUDA 12.8
pip install torch==2.9.0.dev20250716+cu128 torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu128

REM Install Triton for Windows
pip install triton-windows==3.3.1.post19

REM Clean the requirements.txt (remove only torch, torchvision, torchaudio — keep torchsde)
powershell -Command "(Get-Content requirements.txt) | Where-Object {($_ -notmatch '^torch==') -and ($_ -notmatch '^torchvision==') -and ($_ -notmatch '^torchaudio==')} | Set-Content requirements.txt"

REM Install remaining dependencies
pip install -r requirements.txt

REM Install SageAttention
python -m pip install sageattention

REM Downgrade setuptools to avoid conflict with Triton
pip uninstall -y setuptools
pip install setuptools==78.1.1

REM Install ComfyUI-Manager
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ..

REM Create custom launch script
echo @echo off > launch_comfyUI_torch2.9.bat
echo call venv\Scripts\activate.bat >> launch_comfyUI_torch2.9.bat
echo python main.py --use-sage-attention --fast fp16_accumulation --preview-method taesd >> launch_comfyUI_torch2.9.bat
echo pause >> launch_comfyUI_torch2.9.bat

echo.
echo ===========================================
echo Script created by Light_x02
echo You can now launch ComfyUI using launch_comfyUI_torch2.9.bat
echo ===========================================
pause
