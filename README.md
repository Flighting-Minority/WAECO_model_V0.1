# WAECO 模型：干旱区“水资源-农业-生态”协同优化

> 南京邮电大学本科生 · 中科院实习项目
> 复现自 *Agricultural Water Management* 312 (2025) 109408

## 一、项目简介

WAECO (Water-Agriculture-Ecology Co-optimization) 是一个用于干旱区“水资源-农业-生态”协同优化的决策支持工具。

本项目基于论文 *Improving synergy of the water-agriculture-ecology system in arid areas using a novel co-optimization model*，尝试复现一个可迭代、可简单使用、并可以进行基础计算的数学程序模型。

**论文信息**

- 期刊：Agricultural Water Management 312 (2025) 109408
- 作者：Xingyu Zhu, Xiaoling Su, Vijay P. Singh, Haijiang Wu, Jiping Niu, Lianzhou Wu, Jiangdong Chu
- 链接：https://www.sciencedirect.com/science/article/pii/S0378377425001222

## 二、核心功能

- ✅ Excel ↔ CSV 自动转换
- ✅ 随机测试数据生成
- ✅ 10 张数据表的完整加载
- ✅ WAECO 核心迭代计算（粒子群优化 PSO + 协调发展度 F_CD）
- ✅ 偏好因子 η、收敛阈值 ε、最大迭代次数交互设置
- ✅ 结果导出为 Excel
- ✅ 一键运行脚本（Windows）
- ✅ 虚拟环境自动管理

## 三、技术架构

项目采用 **C++ + Python 混合架构**，原因是：

| 模块     | 语言/格式  | 职责                |
| ------ | ------ | ----------------- |
| 核心计算   | C++    | 高性能迭代优化（PSO、F_CD） |
| 数据 I/O | Python | Excel 读写、菜单交互     |
| 数据交换   | CSV    | 两种语言之间的中间格式       |
| 启动脚本   | Batch  | 环境检测与一键运行         |

**为什么用两种语言？**
项目最初计划纯 C++ 实现，但让C/C++语言直接读取 Excel 需要高度复杂的外部库。

而Python 的 `pandas` / `openpyxl` 可以轻松处理 Excel，并且可以将其转化为简单易懂的CSV文件。

因此再三衡量后，我决定采用：

```mermaid
graph LR
A[Python\n负责管理数据]<-->|导入：xlsx.→.csv\n导出：.csv→.xlsx|B[方便读写的\nCSV格式文件]
B<-->|输入：.csv→特定数据对象\n输出：特定数据对象→.csv|C[C++\n负责模型计算]
```

## 四、快速开始

1. 确保已安装 Python 3.8 或更高版本
2. 双击运行 `run.bat`
3. 程序会自动检测环境并安装依赖
4. 出现主菜单后，按提示操作

**基本流程：**

- 选择 `[4]` 生成随机测试数据
- 选择 `[5]` 运行 C++ 核心计算
- 选择 `[6]` 导出结果为 Excel

详细使用说明见 [`Introduction.txt`](Introduction.txt)。

## 五、项目结构

WAECO_model_V0.1/
├── Bin/ # 编译后的可执行文件与 DLL 依赖
├── Data/ # 中间数据目录（CSV，自动管理）
│ ├── input/
│ └── output/
├── Docs/ # 用户数据目录（Excel）
│ ├── Input/
│ └── Output/
├── Interior/ # C++ 源代码
├── Python/ # Python 源代码
├── CMakeLists.txt # C++ 编译配置
├── Introduction.txt # 详细使用说明
└── run.bat # 一键运行脚本

## 六、当前状态与后续计划

**已实现**

- Excel ↔ CSV 自动转换
- 随机测试数据生成
- 10 张数据表的完整加载
- WAECO 核心迭代计算
- 协调发展度 F_CD 计算
- 结果导出为 Excel
- 偏好因子与收敛参数交互设置
- 一键运行脚本与虚拟环境管理

**后续计划**

- 接入实际流域数据进行验证
- 增加可视化图表与多方案对比
- 开展参数敏感性分析
- 进一步完善算法实现与对照实验

## 七、系统要求

- **操作系统**：Windows 10/11 64 位
- **内存**：4 GB RAM（推荐 8 GB）
- **硬盘空间**：500 MB
- **Python**：3.8 或更高版本
- **无需安装 Microsoft Excel**（程序使用 openpyxl 读写）

已测试环境：Windows 10/11 + Python 3.14；CLion 2024.1 + MinGW。

## 八、常见问题

**Q：双击 `run.bat` 后窗口一闪而过？**
A：请检查是否安装了 Python。如果没有，请从 python.org 下载安装。

**Q：提示 `ModuleNotFoundError: No module named 'pandas'`？**
A：程序会自动安装依赖，或手动运行 `pip install pandas openpyxl numpy`。

**Q：C++ 计算时提示找不到 `WAECO_model.exe`？**
A：请确保 `Bin/WAECO_model.exe` 存在。如果缺失，需要重新编译 C++ 代码。

**Q：编译可执行文件有什么要求？**
A：不要删去 `Bin/` 目录下的 `*.dll` 依赖文件。如果误删，可从 `Bin/backup/` 复制回来。

**Q：迭代计算不收敛怎么办？**
A：可以降低收敛阈值（如 0.01）或增加最大迭代次数。

## 九、参考论文

Xingyu Zhu, Xiaoling Su, Vijay P. Singh, Haijiang Wu, Jiping Niu, Lianzhou Wu, Jiangdong Chu.
*Improving synergy of the water-agriculture-ecology system in arid areas using a novel co-optimization model.*
Agricultural Water Management, 312 (2025) 109408.
https://www.sciencedirect.com/science/article/pii/S0378377425001222
