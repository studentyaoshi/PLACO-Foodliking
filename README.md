# PLACO

**A workflow for cross-trait pleiotropic association analysis using the PLACO method**
**Authors:** Shi Yao & Xin Ke & Hao Wu
**Version:** V1.0

---

## Overview

This pipeline provides an automated workflow for identifying shared genetic loci between **food liking** and **obesity** using the **PLACO (Pleiotropic Analysis under Composite Null Hypothesis)** method. PLACO is the original statistical method developed by Ray & Chatterjee (2020).

This script automates the following steps:

1. Merge two GWAS summary statistic files  
2. Filter variants based on Z-score thresholds  
3. Generate Z-score and P-value matrices  
4. Run PLACO analysis in R  
5. Merge annotation and PLACO results into the final output  

---

## Requirements

Please ensure the following software is installed and available in your environment:

- Bash
- Python (recommended >= 3.8)
- R (recommended >= 4.0)
- Required R packages for PLACO analysis

---

## Directory Structure

```bash
PLACO_pipeline/
├── PLACO.sh
├── 0.work_PLACO.py
├── 0.work_PLACO.r
