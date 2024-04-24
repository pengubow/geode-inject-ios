#include <dlfcn.h>
#include <Foundation/Foundation.h>

#if __has_include("geode_download.h")
#include "geode_download.h"
#else
#warning geode_download.h not found - create a file called geode_download.h with the following content:
#warning #define GEODE_DOWNLOAD_URL @"https://your-url-to-download/Geode.ios.dylib"
#error aborting compilation - see info above
#endif

void init_loadGeode(void) {
	NSLog(@"mrow init_loadGeode");

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	NSString *applicationSupportDirectory = [paths firstObject];

	NSString *geode_dir = [applicationSupportDirectory stringByAppendingString:@"/GeometryDash/game/geode"];
	NSString *geode_lib = [geode_dir stringByAppendingString:@"/Geode.ios.dylib"];

	bool is_dir;
	NSFileManager *fm = [NSFileManager defaultManager];
	if(![fm fileExistsAtPath:geode_dir isDirectory:&is_dir]) {
		NSLog(@"mrow creating geode dir !!");
		if(![fm createDirectoryAtPath:geode_dir withIntermediateDirectories:YES attributes:nil error:NULL]) {
			NSLog(@"mrow failed to create folder!!");
		}
	}

	NSLog(@"mrow PATH %@", applicationSupportDirectory);
	NSLog(@"mrow geode dir: %@", geode_dir);
	NSLog(@"mrow Geode lib path: %@", geode_lib);

	bool geode_exists = [fm fileExistsAtPath:geode_lib];

	if (!geode_exists) {
		NSLog(@"mrow geode dylib DOES NOT EXIST! downloading...");
		NSURL *url = [NSURL URLWithString:GEODE_DOWNLOAD_URL];
		NSData *data = [NSData dataWithContentsOfURL:url];
		if (data) {
			if (![data writeToFile:geode_lib atomically:YES]) {
				NSLog(@"mrow FAILED to download Geode: failed to save file");
				return;
			} else {
				NSLog(@"mrow SUCCESS - downloaded Geode!");
			}
		} else {
			NSLog(@"mrow FAILED to download Geode: no data");
			return;
		}
	}

	NSLog(@"mrow trying to load Geode library from %@", geode_lib);

	dlopen([geode_lib UTF8String], RTLD_LAZY);
}
