### Ubuntu安装搜狗输入法
#### Writtern by mia on 2024 Feb 5th
[搜狗输入法官网](https://shurufa.sogou.com/linux/guide)  
[安装相关链接](https://blog.csdn.net/mr__bai/article/details/118674640) 
* 先安装fcitx  
```sudo apt install fcitx``` 
* 若dpkg执行失败，执行以下命令后重新执行dpkg  
```sudo apt -f install```
* 若Configurate中搜索不到“sougoupinyin”，则执行  
```sudo apt --fix-broken install```  
* 依旧不能输入中文，则执行  
```sudo apt install libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2```  
```sudo apt install libgsettings-qt1```
* 重启后即可使用