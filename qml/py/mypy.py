import sys,os
import subprocess
import urllib
import urllib.request
import pyotherside
from basedir import *
import logging
from distutils.version import LooseVersion, StrictVersion

"""
//定义发送消息规则
//0,开始下载
//1,下载完成，开始安装
//2,安装完成
//3,升级成功
//4,卸载完成
//-1,安装失败

"""
target=HOME+"/Downloads/"
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)

def install(rpmpath):
    pyotherside.send("status","1")
    p = subprocess.Popen("pkcon -y install-local "+rpmpath,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    #0则安装成功
    retval = p.wait()
    print("installed,",rpmpath)
    if p.returncode == 0:
        pyotherside.send("status","2")
        return True
    else:
        pyotherside.send("status","-1")
        return False


def unistall(rpmpath):
    p = subprocess.Popen("pkcon remove "+rpmpath,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    #0则安装成功
    retval = p.wait()
    print("removed,",rpmpath)
    pyotherside.send("status","4")
    return p.returncode




"""
    下载文件

"""
#def downloadRpm(downname,downurl):
#    print("starting download")
#    pyotherside.send("status","0")
##    r=urllib.request.get(downurl)
##    with open(downname,"wb") as code:
##        code.write(r.content)
#    p = subprocess.Popen("curl  -o "+downname+" "+downurl,shell=True)
#    #0则安装成功
#    retval = p.wait()
#    install(downname)

appid="1"
def newdownload(downname,downurl):
    urllib.request.urlretrieve(downurl,target+downname, schedule)
    install(target+downname)

#显示下载进度
def schedule(a,b,c):
    """
    a:已经下载的数据块
    b:数据块的大小
    c:远程文件的大小
    """
    per = 100.0 * a * b / c
    if per > 100 :
        per = 100
    #print('%.2f%%' % per)
    pyotherside.send("progress",per)

#先过滤掉相等的
def versionCompare(v1,v2):
    return LooseVersion(v1) < LooseVersion(v2)


#获取平台架构
def getPlatform():
    import platform
    return platform.machine()
