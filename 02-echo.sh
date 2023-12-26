#!/bin/bash

echo line1
echo line2
echo line3

# How to print multiple lines using single echo command?
     # to do so we need to use escape sequence characters
  #   \n : It telss the ssytem to move the cursor to the next line
  #   \t : It moves the cursor to a tab space and then prints the next line


  echo lineX\nlineY

  # To use escape sequence characters, you need to enable the escape sequence using option called '-e'

  echo -e "lineX\nlineY"

  #  " : Double quotes
  #  '': Single quote