#!/bin/bash

figlet $1 > $1-output.txt
echo This super complex build was generated at `date +"%Y-%m-%d-%H-%M"` >> $1-output.txt
