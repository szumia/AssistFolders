## OpenVino2023.3安装
##### Writtern by mia on 2024 Feb 5th
### [1.Install use apt](https://docs.openvino.ai/2023.3/openvino_docs_install_guides_overview.html?VERSION=v_2023_3_0&OP_SYSTEM=LINUX&DISTRIBUTION=APT)
Step 1: Download the GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB. You can also use the following command  
```wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB```  
Step 2: Add this key to the system keyring  
```sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB```  
Step 3: Add the repository via the following command  
* Ubuntu 22  
```echo "deb https://apt.repos.intel.com/openvino/2023 ubuntu22 main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2023.list```
* Ubuntu 20  
```echo "deb https://apt.repos.intel.com/openvino/2023 ubuntu20 main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2023.list```  

Step 4: Update the list of packages via the update command  
```sudo apt update```  
Step 5: Verify that the APT repository is properly set up. Run the apt-cache command to see a list of all available OpenVINO packages and components  
```apt-cache search openvino```  
Step 6: Install OpenVINO Runtime  
```sudo apt install openvino-2023.3.0```  


### [2.Install intel runtime](https://github.com/intel/compute-runtime/releases/tag/21.48.21782)
Step1. Create temporary directory  
```mkdir neo```  
Step2. Download all *.deb packages
```
cd neo
wget https://github.com/intel/compute-runtime/releases/download/21.48.21782/intel-gmmlib_21.3.3_amd64.deb
wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.9441/intel-igc-core_1.0.9441_amd64.deb
wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.9441/intel-igc-opencl_1.0.9441_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/21.48.21782/intel-opencl-icd_21.48.21782_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/21.48.21782/intel-level-zero-gpu_1.2.21782_amd64.deb
```  
Step3. Verify sha256 sums for packages
```
wget https://github.com/intel/compute-runtime/releases/download/21.48.21782/ww48.sum
sha256sum -c ww48.sum
```    
Step4. Install all packages as root  
```sudo dpkg -i *.deb```  
Step5. ha256 sums for packages  
```
b9c157befe15e3b8d2f93a83c4409e2e069214f07e4a41d6b9c60e30bee836f4 intel-gmmlib_21.3.3_amd64.deb
db849b1b0e56ba0447ad344d6647435f6518c5fd3e546d02363e0cd2fb0b28e8 intel-igc-core_1.0.9441_amd64.deb
8c2c4813f8446befcc4acc251deb00ba99231fda37634a3ba54c2ec334de816a intel-igc-opencl_1.0.9441_amd64.deb
434d82140cde7f3fe0e306906d61bd79b921b464bdfabc1c47e26ef646fb2a51 intel-level-zero-gpu_1.2.21782_amd64.deb
482842bb090e615168c8061395dd541702db27d95852bc9c62a6ea8303e36f20 intel-opencl-icd_21.48.21782_amd64.deb
```  
### 相关链接
[OpenVino官网](https://docs.openvino.ai/2023.3/home.html)  
[Install OpenVino use APT](https://docs.openvino.ai/2023.3/openvino_docs_install_guides_overview.html?VERSION=v_2023_3_0&OP_SYSTEM=LINUX&DISTRIBUTION=APT)  
[intel-compute-runtime](https://github.com/intel/compute-runtime/releases)  
