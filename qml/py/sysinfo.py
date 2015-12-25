#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
Created on 2015年12月16日

@author: 0312birdzhang
'''
import platform
import os
propDict= {}
#/etc/hw-release
if os.path.exists("/etc/hw-release"):
    propFile= open("/etc/hw-release", "r" )
    for propLine in propFile:
        propDef= propLine.strip()
        if len(propDef) == 0:
            continue
        if propDef[0] in ( '!', '#' ):
            continue
        punctuation= [ propDef.find(c) for c in ':= ' ] + [ len(propDef) ]
        found= min( [ pos for pos in punctuation if pos != -1 ] )
        name= propDef[:found].rstrip()
        value= propDef[found:].lstrip(":= ").rstrip()
        propDict[name]= value
    propFile.close()
else:
    propDict["NAME"] = "SailfishEmul"

def getSysinfo():
    #phoneName = platform.uname().node
    phoneName = propDict.get("NAME","Sailfish").strip('"')
    osType = platform.uname().system
    cpuModel = platform.uname().processor
    if "86" in cpuModel:
        cpuModel = "x86"
    elif "arm" in cpuModel:
        cpuModel = "arm"
    else:
        pass
    d= {
        "phoneName":phoneName,
        "osType" :osType,
        "cpuModel":cpuModel
        }
    return d
