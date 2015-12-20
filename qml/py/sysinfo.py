#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
Created on 2015年12月16日

@author: 0312birdzhang
'''
import platform

def getSysinfo():
    phoneName = platform.uname().node
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
