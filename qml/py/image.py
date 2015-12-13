import os,sys,shutil
import pyotherside
import subprocess
import random
from basedir import *
import imghdr
import hashlib
import logging

__appname__ = "harbour-9store"
cachePath=os.path.join(XDG_CACHE_HOME, __appname__, __appname__,"9store","")
dbPath=os.path.join(XDG_DATA_HOME, __appname__,__appname__, "QML","OfflineStorage","Databases")
savePath=os.path.join(HOME, "Pictures", "save","9store","")
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)

def saveImg(md5name,savename):
    try:
        realpath=cachePath+md5name
        tmppath = savePath+savename+"."+findImgType(realpath)
        isExis(savePath)
        #logging.debug(tmppath)
        shutil.copy(realpath,tmppath.encode("utf-8"))
        logging.debug(tmppath)
        pyotherside.send("1")
    except Exception as e:
        logging.debug(e)
        pyotherside.send("-1")

def isExis(path):
    if os.path.exists(path):
        pass
    else:
        os.makedirs(path)

"""
    缓存图片
"""
def cacheImg(url):
    cachedFile = cachePath+sumMd5(md5name)
    if os.path.exists(cachedFile):
        pass
    else:
        isExis(cachePath)
        downloadImg(cachedFile,url)
    #判断图片格式
    return cachedFile

"""
    下载文件

"""
def downloadImg(downname,downurl):
    try:
        urllib.request.urlretrieve(downurl,downname)
    except urllib.error.ContentTooShortError:
        pass

def clearImg():
    shutil.rmtree(cachePath)
    pyotherside.send("2")

def sumMd5(s):
    m = hashlib.md5()
    if isinstance(s,str):
        s = s.encode("utf-8")
    m.update(s)
    return m.hexdigest()



#判断图片格式
def findImgType(cachedFile):
    imgType = imghdr.what(cachedFile)
    return imgType
"""
    圆角
"""
def circle_img(cachedFile):
    ima = Image.open(cachedFile).convert("RGBA")
    size = ima.size
    r2 = min(size[0], size[1])
    if size[0] != size[1]:
        ima = ima.resize((r2, r2), Image.ANTIALIAS)
    circle = Image.new('L', (r2, r2), 0)
    draw = ImageDraw.Draw(circle)
    draw.ellipse((0, 0, r2, r2), fill=255)
    alpha = Image.new('L', (r2, r2), 255)
    alpha.paste(circle, (0, 0))
    ima.putalpha(alpha)
    ima.save(cachedFile)
