#!/bin/bash

systemctl enable t2fanrd
systemctl enable tiny-dfr # this may fail
systemctl enable NetworkManager
