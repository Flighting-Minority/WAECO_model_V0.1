========================================
   WAECO 水-农业-生态协同优化模型
   使用说明与项目文档
========================================

【项目简介】
WAECO (Water-Agriculture-Ecology Co-optimization) 模型是一个用于干旱区
“水资源-农业-生态”协同优化的决策支持工具。该模型基于论文：
"Improving synergy of the water-agriculture-ecology system in arid areas
using a novel co-optimization model" (Agricultural Water Management 312, 2025)

========================================
一、文件夹架构
========================================

WAECO_Model_Project/
│
├── Bin/                        // 编译后的可执行文件（用户无需关心）
│   ├── WAECO_model.exe         // C++ 核心计算程序
│   ├── backup/                 // 备份编译依赖文件
│   └── *.dll                   // 运行时依赖库
│
├── Data/                       // 中间数据目录（自动管理）
│   ├── input/                  // C++ 读取的 CSV 文件
│   │   ├── RegionParams.csv
│   │   ├── MeteoData.csv
│   │   ├── CropData.csv
│   │   ├── CropParams.csv
│   │   ├── VegetationData.csv
│   │   ├── VegetationParams.csv
│   │   ├── ReservoirData.csv
│   │   ├── ReservoirParams.csv
│   │   ├── CropWaterAllocation.csv
│   │   └── VegetationWaterAllocation.csv
│   └── output/                 // C++ 输出的结果 CSV 文件
│       ├── IterationResults.csv
│       ├── CropParams_Result.csv
│       ├── VegetationParams_Result.csv
│       ├── CropWater_Result.csv
│       └── VegetationWater_Result.csv
│
├── Docs/                       // 用户数据目录
│   ├── Input/                  // 放置原始 Excel 数据文件
│   └── Output/                 // 程序导出的结果 Excel 文件
│
├── Interior/                   // C++ 源代码（仅供开发者参考）
│   ├── main.cpp
│   ├── waeco.cpp
│   └── waeco.h
│
├── Python/                     // Python 源代码（仅供开发者参考）
│   ├── __init__.py             // 识别该部分程序的标志文件头
│   ├── entry.py                // 主菜单入口
│   └── translator.py           // Excel ↔ CSV 转换
│
├── .venv/                      // Python 运行的虚拟环境（自动创建）
├── CMakeLists.txt              // C++ 编译配置
├── Introduction.txt            // 说明书（本文件）
└── run.bat                     // 一键运行脚本（Windows）


========================================
二、系统要求
========================================

【最低配置】
- 操作系统：Windows 10/11 64位
- 内存：4GB RAM（推荐 8GB）
- 硬盘空间：500MB

【软件依赖】
- Python 3.8 或更高版本（首次运行时会自动安装依赖库）
- 无需安装 Microsoft Excel（程序使用 openpyxl 读写）

【已测试环境】
- Windows 10/11 + Python 3.14
- CLion 2024.1 + MinGW


========================================
三、快速开始
========================================

【首次使用】
1. 双击运行 run.bat（或 run.ps1）
2. 程序会自动检测 Python 环境并安装依赖库
3. 等待出现主菜单界面

【基本操作流程】
1. 选择 [4] 生成随机测试数据 → 快速创建示例数据
2. 选择 [5] 运行 C++ 核心计算 → 执行模型迭代
3. 选择 [6] 导出结果为 Excel → 查看分析结果

【使用自己的数据】
1. 参考 Docs/Input/ 下的示例 Excel 文件格式
2. 将数据文件放入 Docs/Input/ 目录
3. 选择 [1] 载入已有项目 → 选择你的文件


========================================
四、菜单功能说明
========================================

[1] 载入已有项目
    从 Docs/Input/ 目录选择已存在的 Excel 数据文件
    程序会自动将其转换为 CSV 供 C++ 使用

[2] 导入外部 Excel 文件
    指定任意路径的 Excel 文件（支持绝对路径）
    适合从其他位置导入数据

[3] 新建空白项目
    创建空的 Excel 模板文件
    用户按格式填写数据后使用

[4] 生成随机测试数据
    快速生成模拟数据进行测试
    可自定义区域、作物、植被、水库数量和模拟时长

[5] 运行 C++ 核心计算
    执行 WAECO 模型迭代优化
    运行前可设置：
      - 偏好因子 η (0~1)：控制协调度/发展度权重
      - 收敛阈值 ε：控制计算精度
      - 最大迭代次数：控制计算时长

[6] 导出结果为 Excel
    将计算结果从 CSV 转换为 Excel 文件
    保存在 Docs/Output/Results.xlsx

[0] 退出
    关闭程序


========================================
五、数据文件格式说明
========================================

程序需要 10 个数据表（Sheet），每个表对应一个 CSV 文件：

1. RegionParams（区域参数）
   列：unit_name, type, SW_avail, GW_avail, PSW, PGW, EC, EG,
       η_field, η_canal, CT, OP, CSO, CPM, PDC, STC, WP, PF,
       H_min, H_max, μ, φ, ψ, a, b, WT_obj, WT_max,
       POP, FD, Y_min, TAC, TAE, FA

2. MeteoData（气象数据）
   列：unit_name, year, month, T, P, U2, Rn, G, es, ea, Δ,
       E_Phi20, γ, H_0

3. CropData（作物参数）
   列：crop_name, Kc, HI, BIO, SWP, D, α, CS, R, WC, Price,
       CL, CF, CP, CAF, CI, CAM, UF, UP, UAF, AMC, TC

4. CropParams（作物面积规划）
   列：unit_name, crop_name, AC_min, AC_max, AC_now, AC_plan

5. VegetationData（植被参数）
   列：vege_name, Kp, WPE, APM, ASO, ACO, F, SEC, SEI, λ,
       WV, RCV, BV

6. VegetationParams（植被面积规划）
   列：unit_name, vege_name, AE_min, AE_max, AE_now, AE_plan

7. ReservoirData（水库参数）
   列：reservoir_name, Vd, Va, V_min, V_max, β, ρ

8. ReservoirParams（水库来水数据）
   列：reservoir_name, year, month, W

9. CropWaterAllocation（作物水资源分配）
   列：unit_name, crop_name, year, month, WA_min, WA_max, SW, GW

10. VegetationWaterAllocation（植被水资源分配）
    列：unit_name, vege_name, year, month, WE_min, WE_max, SW, GW

【常见单位说明】
- 水量：10⁸ m³
- 面积：10⁴ ha
- 价格：CNY
- 温度：°C
- 产量：10⁴ t


========================================
六、技术实现
========================================

【编程语言】
- C++：核心迭代计算（高性能）
- Python：数据 I/O、菜单交互（灵活易用）
- Batch：环境检测与启动

【为什么使用两种语言？】
项目最初计划纯 C++ 实现，但读取 Excel 文件需要复杂的外部库。
Python 的 pandas/openpyxl 库可以轻松处理 Excel，因此采用：
  Python 管数据 → CSV 传数据 → C++ 管计算 → CSV 传结果 → Python 导出

【核心算法】
- 协调发展度优化（F_CD）
- 粒子群优化（PSO）迭代
- 多目标约束优化


========================================
七、常见问题与解决方案
========================================

Q1: 双击 run.bat 后窗口一闪而过？
A1: 请检查是否安装了 Python。如果没有，请从 python.org 下载安装。

Q2: 提示 "ModuleNotFoundError: No module named 'pandas'"？
A2: 程序会自动安装依赖，或手动运行：
    pip install pandas openpyxl numpy

Q3: C++ 计算时提示 "找不到 WAECO_model.exe"？
A3: 请确保 Bin/WAECO_model.exe 存在。如果缺失，需要重新编译 C++ 代码。

Q4: 程序显示乱码或问号？
A4: 这是控制台编码问题。程序已设置 UTF-8 编码，正常使用时不会出现。

Q5: 生成的 Excel 结果打不开？
A5: 请确保 Docs/Output/ 目录存在写入权限。如果文件损坏，重新运行导出。

Q6: 迭代计算不收敛怎么办？
A6: 可以降低收敛阈值（如 0.01）或增加最大迭代次数。
    或者可以尝试重新开发，毕竟我作为一个学生能力还是有限的，抱歉。

Q7: 编译可执行文件WAECO_model.exe有什么要求吗？
A7: 有，我个人建议不要删去同目录下的*.dll依赖文件
    如果误删，建议打开Bin\backup\文件夹，选取所有的*.dll文件，复制到原位置，即可。

Q8: Python/文件夹下Data/和Docs/是怎么一回事（如果真的存在）？
A8: 我也不清楚，应该是开发过程中或者程序误生成的，删去不影响，留着也没影响


========================================
八、已实现与未实现功能
========================================

【已实现】
✅ Excel ↔ CSV 自动转换
✅ 随机测试数据生成
✅ 10 张数据表的完整加载
✅ WAECO 核心迭代计算
✅ 协调发展度 F_CD 计算
✅ 结果导出为 Excel
✅ 偏好因子 η 交互设置
✅ 收敛阈值和迭代次数自定义
✅ 一键运行脚本
✅ 虚拟环境自动管理

【未实现/待完善】
⏳ 真实数据验证（需要实际流域数据）
⏳ 可视化图表生成
⏳ 多方案对比分析
⏳ 参数敏感性分析
⏳ 算法本身的可行性（没有对照，而且我的实现也很有限）


========================================
九、致谢与来源
========================================

【论文来源】
Agricultural Water Management 312 (2025) 109408
"Improving synergy of the water-agriculture-ecology system in arid areas
using a novel co-optimization model"
作者：Xingyu Zhu, Xiaoling Su, Vijay P. Singh, et al.
journal homepage: www.elsevier.com/locate/agwat

【开发人员】
- 谢荣政（南京邮电大学 网络工程专业）
  负责 C++ 核心算法实现、Python 数据管理、项目整体架构

- Deepseek AI
  提供代码、问题诊断和架构设计支持

【开发工具】
- CLion 2024.1（C++ IDE）
- Python 3.14 + pandas/openpyxl/numpy （归属于CLion下载的Python插件和虚拟环境）
- MinGW（C++ 编译器）

========================================
版本：1.0
最后更新：2026年7月25日
========================================