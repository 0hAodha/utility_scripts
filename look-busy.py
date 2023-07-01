#!/bin/python3

from wakepy import keepawake 
import pyautogui 
import time 

with keepawake(keep_screen_awake=True):
    while (True):
        pyautogui.moveRel(100,0)
        time.sleep(0.1)

        pyautogui.moveRel(0,100)
        time.sleep(0.1)

        pyautogui.moveRel(-100,0)
        time.sleep(0.1)

        pyautogui.moveRel(0,-100)
        time.sleep(0.1)
