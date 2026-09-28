@echo off
chcp 65001 > nul
title WAECO 水-农业-生态协同优化模型

REM 文件名：run.bat
REM 作者：谢荣政; (DeepseekAi 辅助)
REM 创建日期：2026/7/22
REM 最后更新日期：2026/7/25
REM 介绍：检测环境，一次性启动项目
REM 联动：entry.py


echo ========================================
echo   🌾 WAECO 模型启动器
echo ========================================

REM ===== 1. 检测 Python（优先使用 .venv） =====
set PYTHON_CMD=

if exist ".venv\Scripts\python.exe" (
    echo ✅ 检测到虚拟环境 .venv
    set PYTHON_CMD=.venv\Scripts\python.exe
    goto :run
)

where python > nul 2>&1
if %errorlevel% equ 0 set PYTHON_CMD=python
if "%PYTHON_CMD%"=="" (
    where python3 > nul 2>&1
    if %errorlevel% equ 0 set PYTHON_CMD=python3
)
if "%PYTHON_CMD%"=="" (
    where py > nul 2>&1
    if %errorlevel% equ 0 set PYTHON_CMD=py
)

if "%PYTHON_CMD%"=="" (
    echo ❌ 未检测到 Python，请安装 Python 3.6+
    pause
    exit /b 1
)

:run
echo ✅ 使用 Python: %PYTHON_CMD%

REM ===== 2. 检查依赖库 =====
%PYTHON_CMD% -c "import pandas, openpyxl, numpy" > nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️ 缺少依赖库，正在安装...
    %PYTHON_CMD% -m pip install pandas openpyxl numpy
)

REM ===== 3. 检查 C++ 程序 =====
if not exist "Bin\WAECO_model.exe" (
    echo ⚠️ 未找到 WAECO_model.exe，请先编译 C++ 代码
    pause
    exit /b 1
)

REM ===== 4. 运行 Python 程序 =====
echo 🚀 正在启动程序...
cd /d "%~dp0"

set PYTHONPATH=%~dp0Python;%~dp0
%PYTHON_CMD% Python\entry.py

pause