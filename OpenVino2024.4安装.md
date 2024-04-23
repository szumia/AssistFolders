## OpenVino2024.4安装
##### Writtern by mia on 2024 Feb 5th（Newly updated on 2024 Arp 23th）
### [1.Install use apt for Linux](https://www.intel.cn/content/www/cn/zh/developer/tools/openvino-toolkit/download.html?VERSION=v_2024_0_0&OP_SYSTEM=LINUX&DISTRIBUTION=APT)
Step 1: Download the GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB. You can also use the following command  
```wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB```  
Step 2: Add this key to the system keyring  
```sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB```  
Step 3: Add the repository via the following command  
* Ubuntu 22  
```echo "deb https://apt.repos.intel.com/openvino/2024 ubuntu22 main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2024.list```
* Ubuntu 20  
```echo "deb https://apt.repos.intel.com/openvino/2024 ubuntu20 main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2024.list```  

Step 4: Update the list of packages via the update command  
```sudo apt update```  
Step 5: Verify that the APT repository is properly set up. Run the apt-cache command to see a list of all available OpenVINO packages and components  
```apt-cache search openvino```  
Step 6: Install OpenVINO Runtime  
```sudo apt install openvino-2024.0.0```  


### [2.Install intel runtime 24.13.29138.7](https://github.com/intel/compute-runtime/releases)
Step1. Create temporary directory  
```mkdir neo```  
Step2. Download all *.deb packages
```
cd neo
wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.16238.4/intel-igc-core_1.0.16238.4_amd64.deb
wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.16238.4/intel-igc-opencl_1.0.16238.4_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/24.09.28717.12/intel-level-zero-gpu-dbgsym_1.3.28717.12_amd64.ddeb
wget https://github.com/intel/compute-runtime/releases/download/24.09.28717.12/intel-level-zero-gpu_1.3.28717.12_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/24.09.28717.12/intel-opencl-icd-dbgsym_24.09.28717.12_amd64.ddeb
wget https://github.com/intel/compute-runtime/releases/download/24.09.28717.12/intel-opencl-icd_24.09.28717.12_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/24.09.28717.12/libigdgmm12_22.3.17_amd64.deb
```  
Step3. Verify sha256 sums for packages
```
wget https://github.com/intel/compute-runtime/releases/download/24.09.28717.12/ww09.sum
sha256sum -c ww09.sum
```    
Step4. Install all packages as root  
```sudo dpkg -i *.deb```  
In case of installation problems, please install required dependencies, for example:  
```apt install ocl-icd-libopencl1```  
Step5. ha256 sums for packages  
```
c6ebef32424871f53e228bd486644b1b9118fc8e749c72fd18e9d054b660b0e1 intel-igc-core_1.0.16238.4_amd64.deb
5c9f01cb04961af8da1fc1aa071f2f35655053afef901032bc4615dffa06b451 intel-igc-opencl_1.0.16238.4_amd64.deb
b1c0007f0e2ec1193c33d4420ac7a7d94ecdb0f827e9ce8f33ad038008163a68 intel-level-zero-gpu-dbgsym_1.3.28717.12_amd64.ddeb
fd914c2c8005e6b020b4beeeaf14e3f66526095d3d14a624b3a6eac3c7799f8b intel-level-zero-gpu_1.3.28717.12_amd64.deb
77320a90217b30929751991ce61975c2b90950a1afc9264672e94d3f594809fa intel-opencl-icd-dbgsym_24.09.28717.12_amd64.ddeb
3df24e07e3f7ff5539d82eb1d9426e4ccf02813f76cd08e9292d4cb40866b20f intel-opencl-icd_24.09.28717.12_amd64.deb
883ffebb7c7d8603735b6e6028300601905a8af567f6582da8759e966206f72f libigdgmm12_22.3.17_amd64.deb
```


### 3.查看Intel设备GPU占用
```sudo apt-get install intel-gpu-tools```  
```sudo intel_gpu_top```  

### 相关链接
[OpenVino官网](https://docs.openvino.ai/2023.3/home.html)  
[Install OpenVino use APT](https://docs.openvino.ai/2023.3/openvino_docs_install_guides_overview.html?VERSION=v_2023_3_0&OP_SYSTEM=LINUX&DISTRIBUTION=APT)  
[intel-compute-runtime](https://github.com/intel/compute-runtime/releases)  
