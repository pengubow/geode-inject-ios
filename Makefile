TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = GeometryJump

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = geodeinject

geodeinject_FILES = main.m utils.m dyld_bypass_validation.m geode.x *.c fishhook/*.c
geodeinject_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
